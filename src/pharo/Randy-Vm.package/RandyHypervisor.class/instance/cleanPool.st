private
cleanPool
	"Stops broken VMs, starts up to hot new VMs"

	| brokens join result |
	poolMonitor
		critical: [ brokens := pool select: #isBroken.
			pool removeAll: brokens.
			brokens do: [ :each | self lock: each ] ].
	join := Semaphore new.
	brokens
		do: [ :each | 
			[ [ each stop ]
				ensure: [ self release: each.join signal ] ] fork ].
	[ [ result := self start: hot ]
		ensure: [ join signal ] ] fork.
	brokens do: [ :each | join wait ].
	join wait.
	^ result
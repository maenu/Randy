private
cleanPool
	"Stops broken VMs, starts up to hot new VMs"

	| brokens join result |
	poolMonitor
		critical: [ brokens := pool select: #isBroken.
			pool removeAll: brokens ].
	join := Semaphore new.
	brokens
		do: [ :each | 
			[ [ each stop ]
				ensure: [ join signal ] ] fork ].
	[ [ result := self start: hot ]
		ensure: [ join signal ] ] fork.
	brokens do: [ :each | join wait ].
	join wait.
	^ result
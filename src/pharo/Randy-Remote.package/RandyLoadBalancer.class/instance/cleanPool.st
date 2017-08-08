as yet unclassified
cleanPool
	"Stops broken VMs, starts up to hot new VMs"

	| brokenVms join |
	brokenVms := (pool associationsSelect: [ :association | association value isBroken ]) collect: #key.
	join := Semaphore new.
	brokenVms
		do: [ :each | 
			[ [ self stopVm: each. pool remove: each ]
				ensure: [ join signal ] ] fork ].
	brokenVms do: [ :each | join wait ].
	^ self start: hot
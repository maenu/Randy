public
start: anInteger
	| vmContainers join |
	poolMonitor
		critical:
			[ vmContainers := (1 to: ((anInteger min: (hot - (pool select: [ :each | each state == #ready ]) size max: 0)) min: poolSize - pool size))
				collect: [ :i | self newVmContainer ].
			pool addAll: vmContainers ].
	join := Semaphore new.
	^ [vmContainers
		do: [ :each | 
			[ [ each start ]
				ensure: [ join signal ] ] fork ];
		do: [ :each | join wait ];
		size]ensure:[needsCleaning signal]
public
start: anInteger
	| vmContainers join |
	poolMonitor
		critical:
			[ vmContainers := (1 to: ((anInteger min: (hot - (pool select: [ :each | each state == #ready ]) size max: 0)) min: poolSize - pool size))
				collect: [ :i | 
					| vmContainer |
					vmContainer := self newVmContainer.
					pool add: vmContainer.
					self lock: vmContainer.vmContainer ] ].
	join := Semaphore new.
	^ vmContainers
		do: [ :each | 
			[ [ each start ]
				ensure: [ self release: each.
					join signal ] ] fork ];
		do: [ :each | join wait ];
		size
accessing
start: anInteger
	| vms join |
	vms := 1 to: ((anInteger min: hot) min: poolSize - pool size).
	join := Semaphore new.
	(vms collect: [ :i | self addVm ])
		do: [ :each | 
			[ [ self startVm: each ]
				ensure: [ join signal ] ] fork ].
	vms do: [ :each | join wait ].
	^ vms size
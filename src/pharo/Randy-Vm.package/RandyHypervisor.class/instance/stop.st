public
stop
	| vmContainers join |
	running :=false.
	poolMonitor
		critical: [ vmContainers := pool copy.
			pool removeAll.
			vmContainers do: [ :each | self lock: each ] ].
	join := Semaphore new.
	^ vmContainers
		do: [ :each | 
			[ [ each stop ]
				ensure: [ self release: each.
					join signal ] ] fork ];
		do: [ :each | join wait ];
		size
public
stop
	| vmContainers join |
	poolMonitor
		critical: [ vmContainers := pool copy.
			pool removeAll ].
	join := Semaphore new.
	^ vmContainers
		do: [ :each | 
			[ [ each stop ]
				ensure: [ join signal ] ] fork ];
		do: [ :each | join wait ];
		size
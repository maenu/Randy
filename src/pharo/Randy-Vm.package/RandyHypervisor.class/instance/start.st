public
start
	running := true.
	[ [ running ]
		whileTrue: [ [ self cleanPool ]
				ensure: [ (Delay forSeconds: 30) wait ] ] ] fork.
	^ self start: hot
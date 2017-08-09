accessing
poolSize: anInteger
	poolMonitor
		critical: [ self assert: (poolSize isNil or: anInteger isNotNil).
			poolSize := anInteger ]
accessing
port: anInteger
	poolMonitor
		critical: [ self assert: (port isNil or: anInteger isNotNil).
			port := anInteger ]
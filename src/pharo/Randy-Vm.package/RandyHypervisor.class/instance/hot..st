accessing
hot: anInteger
	poolMonitor
		critical: [ self assert: (hot isNil or: anInteger isNotNil).
			hot := anInteger ]
accessing
poolSize: anInteger
	poolMonitor
		critical: [ 
			poolSize := anInteger ]
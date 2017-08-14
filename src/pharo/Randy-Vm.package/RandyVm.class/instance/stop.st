as yet unclassified
stop
	process
		ifNotNil: [ process isRunning
				ifTrue: [ process sigint.
					process waitForExit].
					process closeAndCleanStreams .
			process := nil ]
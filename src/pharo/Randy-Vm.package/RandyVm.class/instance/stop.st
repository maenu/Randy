accessing
stop
	process
		ifNotNil: [ 
			process isRunning
				ifTrue: [ process sigint.
					process waitForExit ].
			process closeAndCleanStreams.
			process := nil.
			OSSUnixSubprocess new
				command: 'rm';
				arguments: {(image , '.' , port asString)};
				run;
				waitForExit ]
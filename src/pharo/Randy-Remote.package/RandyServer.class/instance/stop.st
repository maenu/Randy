meta-data
stop
	process
		ifNotNil: [ process sigint.
			process := nil ]
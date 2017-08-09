running
stop
	"No monitor, this must always forces stop."

	statsMonitor critical: [ stats stopping ].
	^ [ | result |
	result := vm stop.
	vmMonitor critical: [ statsMonitor critical: [ stats stoppedWith: result ] ].
	result ]
		ifError: [ :error | 
			vmMonitor
				critical: [ statsMonitor critical: [ stats stopFailedWith: error ].
					error signal ] ]
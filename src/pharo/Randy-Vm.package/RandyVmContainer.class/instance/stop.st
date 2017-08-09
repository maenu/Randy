running
stop
	vmMonitor
		critical: [ statsMonitor
				critical: [stats stopping].
			^ [ | result |
			result := vm stop.
			statsMonitor
				critical: [stats stoppedWith: result].
			result ]
				ifError: [ :error | 
					statsMonitor
				critical: [stats stopFailedWith: error].
					error signal ] ]
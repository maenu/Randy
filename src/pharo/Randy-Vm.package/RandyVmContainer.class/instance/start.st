running
start
	vmMonitor
		critical: [statsMonitor
				critical: [ self assert: stats state == #added.
			stats starting].
			^ [ | result |
			result := vm start.
			statsMonitor
				critical: [stats startedWith: result].
			result ]
				ifError: [ :error | 
					statsMonitor
				critical: [stats startFailedWith: error].
					error signal ] ]
running
start
	vmMonitor
		critical: [ statsMonitor
				critical: [ self assert: stats state == #created.
					stats starting ].
			^ [ | result |
			result := vm start.
			statsMonitor critical: [ stats startedWith: result ].
			result ]
				ifError: [ :error | 
					statsMonitor critical: [ stats startFailedWith: error ].
					self error: error ] ]
running
run: aString
	vmMonitor
		critical: [ statsMonitor
				critical: [ self assert: stats state == #ready.
					stats running ].
			^ [ | result |
			result := vm run: aString.
			statsMonitor critical: [ stats ranWith: result ].
			result ]
				ifError: [ :error | 
					statsMonitor critical: [ stats runFailedWith: error ].
					error signal ] ]
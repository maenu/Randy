as yet unclassified
startVm: aVm
	| stats |
	stats := pool at: aVm.
	self assert: stats state == #added.
	stats starting.
	^ [ | result |
	result := aVm start.
	stats startedWith: result.result ]
		ifError: [ :error | 
			stats startFailedWith: error.
			error signal ].
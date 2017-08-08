as yet unclassified
stopVm: aVm
	| stats |
	stats := pool at: aVm.
	self assert: stats state == #running.
	stats stopping.
	^ [ |result|result:=aVm stop.
	stats stoppedWith: result.result ]
		ifError: [ :error | 
			stats stopFailedWith: error.
			error signal ]
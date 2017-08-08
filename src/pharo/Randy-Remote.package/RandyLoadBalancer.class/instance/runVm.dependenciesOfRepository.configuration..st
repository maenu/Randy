as yet unclassified
runVm: aVm dependenciesOfRepository: aString configuration: anotherString
	| stats |
	stats := pool at: aVm.
	self assert: stats state == #ready.
	stats running.
	^ [ | result |
	result := aVm dependenciesOfRepository: aString configuration: anotherString.
	stats ranWith: result.
	result ]
		ifError: [ :error | 
			stats runFailedWith: error.
			error signal ]
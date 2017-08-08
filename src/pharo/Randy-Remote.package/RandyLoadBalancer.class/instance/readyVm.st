as yet unclassified
readyVm
self start: 1.
	^ pool keys detect: [ :vm | (pool at: vm) state == #ready ]
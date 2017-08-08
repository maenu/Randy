as yet unclassified
addVm
	| concretePort vm |
	concretePort := port.
	[ pool keys detect: [ :each | each port == concretePort ] ifFound: [ true ] ifNone: [ false ] ] whileTrue: [ concretePort := concretePort + 1 ].
	vm := RandyVm image: image port: concretePort.
	pool at: vm put: (RandyVmStats new added; yourself).
	^ vm
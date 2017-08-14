as yet unclassified
on: anInteger poolSize: anotherInteger hot: yetAnotherInteger image: aString port: yetYetAnotherInteger
	| server hypervisor |
	server := self on: anInteger.
	hypervisor := RandyHypervisor
		poolSize: anotherInteger
		hot: yetAnotherInteger
		image: aString
		port: yetYetAnotherInteger.
	server delegate: (RandyZnHypervisorDispatcherDelegate hypervisor: hypervisor).
	server delegate map: '/dependencies' to: RandyZnDependenciesDelegate new.
	^ server
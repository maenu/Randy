private
newVmContainer
	^ poolMonitor
		critical: [ | concretePort |
			concretePort := port.
			[ pool contains: [ :each | each port == concretePort ] ] whileTrue: [ concretePort := concretePort + 1 ].
			RandyVmContainer vm: (RandyVm image: image port: concretePort) ]
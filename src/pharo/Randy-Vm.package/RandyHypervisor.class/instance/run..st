public
run: aString
	| vmContainer |
	poolMonitor
		critical: [ poolMonitor waitUntil: [ pool anySatisfy: [ :each | each state == #ready ] ].
			vmContainer := pool detect: [ :each | each state == #ready ].
			self lock: vmContainer ].
	^ [ vmContainer run: aString ]
		ensure: [ self release: vmContainer ]
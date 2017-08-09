public
run: aString
	"TODO vmContainer is not locked, best effort"

	| vmContainer |
	self cleanPool.
	poolMonitor
		critical: [ 
			vmContainer := pool detect: [ :each | each state == #ready ].
			self lock: vmContainer ].
	^ [ vmContainer run: aString ]
		ensure: [ self release: vmContainer ]
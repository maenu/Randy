public
run: aString
	"TODO vmContainer is not locked, best effort"

	| vmContainer |
	self cleanPool.
	poolMonitor
		critical: [ 
			vmContainer := pool detect: [ :each | each state == #ready ] ].
	^ vmContainer run: aString
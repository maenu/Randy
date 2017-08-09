public
run: aString
	"TODO vmContainer is not locked, best effort"

	| vmContainer |
	poolMonitor
		critical: [ self start: 1.
			vmContainer := pool detect: [ :each | each state == #ready ] ].
	^ [vmContainer run: aString] ensure:[needsCleaning signal]
initialization
initialize
	super initialize.
	pool := IdentitySet new.
	poolMonitor := Monitor new.
	locks := IdentitySet new.
	lockMonitor := Monitor new
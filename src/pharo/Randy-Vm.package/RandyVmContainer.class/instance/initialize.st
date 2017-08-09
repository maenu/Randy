initialization
initialize
	super initialize.
	vmMonitor := Monitor new.
	statsMonitor := Monitor new.
	stats := RandyVmStats new
		created;
		yourself
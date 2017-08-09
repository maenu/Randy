initialization
initialize
	super initialize.
	pool := IdentitySet new.
	poolMonitor := Monitor new.
	needsCleaning := Semaphore new.cleaner := [ true
				whileTrue: [ needsCleaning wait.
					self cleanPool.
					needsCleaning isSignaled
						ifTrue: [ needsCleaning consumeAllSignals.
							needsCleaning signal ] ] ] fork
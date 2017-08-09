lock-release
lock: aVmContainer
	lockMonitor
		critical: [ lockMonitor waitWhile: [ locks includes: aVmContainer ].
			locks add: aVmContainer ]
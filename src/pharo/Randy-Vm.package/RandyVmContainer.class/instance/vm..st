accessing
vm: aVm
	vmMonitor
		critical: [ self assert: (vm isNil or: aVm isNotNil).
			vm := aVm ]
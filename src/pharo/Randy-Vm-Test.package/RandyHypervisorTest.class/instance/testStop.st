tests
testStop
	| pool |
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub port willReturn: port0.
			mock ].
	hypervisor start.
	pool := hypervisor instVarNamed: #pool.
	hypervisor stop should equal: hot.
	(hypervisor instVarNamed: #pool) size should equal: 0.
	(pool
		allSatisfy: [ :vmContainer | 
			[ vmContainer stub stop shouldBeSentInAnotherProcess.
			vmContainer state should equal: #stopped.
			true ] ifError: [ false ] ]) should be: true
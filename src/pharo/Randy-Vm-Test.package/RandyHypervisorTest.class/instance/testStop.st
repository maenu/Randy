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
	pool := (hypervisor instVarNamed: #pool) copy.
	hypervisor stop should equal: hot.
	(hypervisor instVarNamed: #pool) size should equal: 0.
	(pool
		count: [ :vmContainer | 
			| vm |
			vm := vmContainer instVarNamed: #vm.
			[ vm should receive start.
			vm should receive stop.
			vm should not receive run: Any.
			vmContainer state should equal: #created.
			true ] ifError: [ false ] ]) should equal: 2
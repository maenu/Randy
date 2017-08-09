tests
testStart
	| pool |
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub port willReturn: port0.
			mock ].
	hypervisor start should equal: hot.
	pool := hypervisor instVarNamed: #pool.
	pool size should equal: hot.
	(pool
		count: [ :vmContainer | 
			| vm |
			vm := vmContainer instVarNamed: #vm.
			[ vm should receive start.
			vm should not receive stop.
			vm should not receive run: Any.
			vmContainer port should equal: port.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should equal: 1.
	(pool
		count: [ :vmContainer | 
			| vm |
			vm := vmContainer instVarNamed: #vm.
			[ vm should receive start.
			vm should not receive stop.
			vm should not receive run: Any.
			vmContainer port should equal: port + 1.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should equal: 1
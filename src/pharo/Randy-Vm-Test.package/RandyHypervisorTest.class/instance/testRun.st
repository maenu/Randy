tests
testRun
	| pool string result |
	string := #string.
	result := #result.
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub port willReturn: port0.
			(mock stub run: string) willReturn: result.
			mock ].
	hypervisor start.
	(hypervisor run: string) should equal: result.
	pool := hypervisor instVarNamed: #pool.
	pool size should equal: hot.
	(pool
		count: [ :vmContainer | 
			| vm |
			vm := vmContainer instVarNamed: #vm.
			[ vm should receive start.
			vm should not receive stop.
			vm  should receive run: string.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should equal: 1.
	(pool
		count: [ :vmContainer | 
			| vm |
			vm := vmContainer instVarNamed: #vm.
			[ vm should receive start.
			vm should not receive stop.
			vm  should not receive run: string.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should equal: 1
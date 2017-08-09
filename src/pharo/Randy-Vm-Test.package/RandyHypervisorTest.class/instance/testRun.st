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
		anySatisfy: [ :vmContainer | 
			[ (vmContainer stub run: string) shouldBeSentInAnotherProcess.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should be: true.
	(pool
		anySatisfy: [ :vmContainer | 
			[ vmContainer stub should not receive run: string.
			vmContainer state should equal: #ready.
			true ] ifError: [ false ] ]) should be: true
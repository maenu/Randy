tests
testStop
	| pool |
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			mock ].
	hypervisor start.
	pool := (hypervisor instVarNamed: #pool) associations asOrderedCollection
		sort: [ :a :b | (a value events at: #started) < (b value events at: #started) ].
	hypervisor stop should equal: 2.
	(hypervisor instVarNamed: #pool) size should equal: 0.
	(pool at: 1) key stub stop shouldBeSentInAnotherProcess.
	(pool at: 1) value state should equal: #stopped.
	(pool at: 2) key stub stop shouldBeSentInAnotherProcess.
	(pool at: 2) value state should equal: #stopped
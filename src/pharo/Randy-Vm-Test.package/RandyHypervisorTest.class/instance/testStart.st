tests
testStart
	| pool |
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			mock ].
	hypervisor start should equal: hot.
	pool := (hypervisor instVarNamed: #pool) associations asOrderedCollection
		sort: [ :a :b | (a value events at: #started) < (b value events at: #started) ].
	pool size should equal: hot.
	(pool at: 1) key stub start shouldBeSentInAnotherProcess.
	(pool at: 1) key image should equal: image.
	(pool at: 1) key port should equal: port.
	(pool at: 1) value state should equal: #ready.
	(pool at: 2) key stub start shouldBeSentInAnotherProcess.
	(pool at: 2) key image should equal: image.
	(pool at: 2) key port should equal: port + 1.
	(pool at: 2) value state should equal: #ready
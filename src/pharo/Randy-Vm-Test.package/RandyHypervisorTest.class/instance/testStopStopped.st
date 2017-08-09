tests
testStopStopped
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			mock ].
	hypervisor start.
	hypervisor stop.
	hypervisor stop should equal: 0.
	(hypervisor instVarNamed: #pool) size should equal: 0
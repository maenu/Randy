tests
testStartMoreThanHot
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			mock ].
	(hypervisor start: 3) should equal: hot.
	(hypervisor instVarNamed: #pool) size should equal: hot
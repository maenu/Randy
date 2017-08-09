tests
testDependenciesOfRepositoryConfiguration
	| pool repository configuration result |
	repository := #repository.
	configuration := #configuration.
	result := #result.
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			(mock stub dependenciesOfRepository: repository configuration: configuration) willReturn: result.
			mock ].
	hypervisor start.
	(hypervisor dependenciesOfRepository: repository configuration: configuration) should equal: result.
	pool := (hypervisor instVarNamed: #pool) associations asOrderedCollection
		sort: [ :a :b | (a value events at: #started) < (b value events at: #started) ].
	pool size should equal: hot.
	((pool at: 1) key stub dependenciesOfRepository: repository configuration: configuration) shouldBeSentInAnotherProcess.
	(pool at: 1) value state should equal: #ready.
	(pool at: 2) key stub should not receive dependenciesOfRepository: repository configuration: configuration.
	(pool at: 2) value state should equal: #ready
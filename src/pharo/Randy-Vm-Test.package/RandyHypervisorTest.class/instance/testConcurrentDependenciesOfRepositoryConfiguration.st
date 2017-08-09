tests
testConcurrentDependenciesOfRepositoryConfiguration
	|  running proceed finished repository configuration result  pool|
	running := Semaphore new.
	proceed := Semaphore new.
	finished := Semaphore new.
	repository := #repository.
	configuration := #configuration.
	result := #result.
	(RandyVm stub image: Any port: Any)
		will: [ :image0 :port0 | 
			| mock |
			mock := Mock new.
			mock stub image willReturn: image0.
			mock stub port willReturn: port0.
			(mock stub
				dependenciesOfRepository: repository
				configuration: configuration)
				will: [ 
					running signal.
					proceed wait.
					result ].
			mock ].
	hypervisor start.
	[ (hypervisor
		dependenciesOfRepository: repository
		configuration: configuration) should equal: result. finished signal. ] fork.
	[(hypervisor
		dependenciesOfRepository: repository
		configuration: configuration) should equal: result. finished signal. ] fork.
	running
		wait;
		wait.
	pool := (hypervisor instVarNamed: #pool) associations
		asOrderedCollection
		sort:
			[ :a :b | (a value events at: #started) < (b value events at: #started) ].
	pool size should equal: hot + 1.
	((pool at: 1) key stub
		dependenciesOfRepository: repository
		configuration: configuration) shouldBeSentInAnotherProcess.
	(pool at: 1) value state should equal: #running.
	((pool at: 2) key stub
		dependenciesOfRepository: repository
		configuration: configuration) shouldBeSentInAnotherProcess.
	(pool at: 2) value state should equal: #running.
	(pool at: 3) key stub should not receive
		dependenciesOfRepository: repository
		configuration: configuration.
	(pool at: 3) value state should equal: #ready.
	proceed signal.
	finished wait.
	(pool at: 1) value state should equal: #ready.
	(pool at: 2) value state should equal: #running.
	(pool at: 3) key stub should not receive
		dependenciesOfRepository: repository
		configuration: configuration.
	(pool at: 3) value state should equal: #ready.
	proceed signal.
	finished wait.
	(pool at: 1) value state should equal: #ready.
	(pool at: 2) value state should equal: #ready.
	(pool at: 3) key stub should not receive
		dependenciesOfRepository: repository
		configuration: configuration.
	(pool at: 3) value state should equal: #ready.
	running isEmpty should be: true.
	proceed isEmpty should be: true.
	finished isEmpty should be: true
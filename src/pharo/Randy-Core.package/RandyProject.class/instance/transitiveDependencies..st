accessing
transitiveDependencies: aVersion
	self ensureProjectLoaded.
	^ ((self directDependencies: aVersion) flatCollect: [ :dependency | dependency deepCollect: [ :version | version projects collect: #version ] as: Set ] as: Set) reject: #isNil
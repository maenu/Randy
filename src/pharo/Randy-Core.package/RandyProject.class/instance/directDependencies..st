accessing
directDependencies: aVersion
	self ensureProjectLoaded.
	^ (aVersion projects collect: #version as: Set) reject: #isNil
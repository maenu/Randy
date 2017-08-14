accessing
transitiveDependencies: aVersion
	self ensureProjectLoaded.
	^ (self directDependencies: aVersion)
		flatCollect: [ :dependency | 
			dependency
				deepCollectAsSet: [ :dependencyProject | 
					| dependencyVersion |
					dependencyVersion := dependencyProject version.
					dependencyVersion ifNil: [ #() ] ifNotNil: [ dependencyVersion projects  ] ] ]
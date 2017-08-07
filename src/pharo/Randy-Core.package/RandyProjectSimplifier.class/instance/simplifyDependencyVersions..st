as yet unclassified
simplifyDependencyVersions: aCollection
	^ aCollection
		collect: [ :dependencyVersion | 
			{(#project -> dependencyVersion projectLabel).
			(#version -> dependencyVersion versionString)} asDictionary ] 
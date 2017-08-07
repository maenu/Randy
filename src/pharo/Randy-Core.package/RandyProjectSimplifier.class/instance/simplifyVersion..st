as yet unclassified
simplifyVersion: aVersion
	| dictionary |
	dictionary := Dictionary new.
	dictionary at: #version put: aVersion versionString.
	dictionary at: #timestamp put: aVersion timestamp.
	[ dictionary
		addAll:
			{(#groups
				->
					(self simplifyGroups: aVersion groups)).
			(#directDependencies -> (self simplifyDependencyVersions: (project directDependencies: aVersion))).
			(#transitiveDependencies -> (self simplifyDependencyVersions: (project transitiveDependencies: aVersion)))} asDictionary ] ifError: [ :error | dictionary at: #error put: error asString ].
	^ dictionary
as yet unclassified
simplifyDependencyVersions: aCollection
	^ aCollection
		collect: [ :dependency | 
			{(#project -> dependency className).
			(#repository -> (dependency repositories collect: [ :repository | repository description ]) first).
			(#version -> dependency versionString)} asDictionary ]
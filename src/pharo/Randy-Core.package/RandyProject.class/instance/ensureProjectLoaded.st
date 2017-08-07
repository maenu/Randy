loading
ensureProjectLoaded
	project
		ifNil: [ Gofer new
				url: repository;
				package: configuration;
				load.
			project := (Smalltalk at: configuration asSymbol) project ]
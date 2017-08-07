as yet unclassified
simplifyProject
	^ project versions collect: [ :version | self simplifyVersion: version ]
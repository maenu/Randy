as yet unclassified
handleRequest: aRequest with: aHypervisor
	| repository configuration result |
	aRequest method = #GET
		ifFalse: [ ^ ZnResponse methodNotAllowed: aRequest ].
	repository := aRequest uri query at: #repository.
	configuration := aRequest uri query at: #configuration.
	repository ifNil: [ ^ ZnResponse badRequest: aRequest entity: 'query parameter ''repository'' required' ].
	configuration ifNil: [ ^ ZnResponse badRequest: aRequest entity: 'query parameter ''configuration'' required' ].
	[ result := self dependenciesOfRepository: repository configuration: configuration with: aHypervisor ]
		ifError:
			[ :error | ^ ZnResponse serverErrorWithEntity: (ZnStringEntity with: (NeoJSONWriter toString:{('error' -> error)} asDictionary) type: ZnMimeType applicationJson setCharSetUTF8) ].
	^ ZnResponse ok: (ZnStringEntity with: result type: ZnMimeType applicationJson setCharSetUTF8)
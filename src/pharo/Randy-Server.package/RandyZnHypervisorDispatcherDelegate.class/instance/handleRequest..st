public
handleRequest: request
	| handler |
	handler := routes at: request uri pathPrintString ifAbsent: [ ^ ZnResponse notFound: request uri ].
	^ handler value: request value: hypervisor
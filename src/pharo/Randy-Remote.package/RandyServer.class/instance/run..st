meta-data
run: aString
	^ ZnClient new post: 'http://localhost:8080/cgi-bin/run' contents: aString
meta-data
run: aString
	^ ZnClient new
		beOneShot;
		timeout: 360;
		post: 'http://localhost:8080/cgi-bin/run' contents: aString
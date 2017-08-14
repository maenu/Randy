as yet unclassified
run: aString
	^ ZnClient new
		beOneShot;
		timeout: 360;
		post: 'http://localhost:',port asString,'/cgi-bin/run' contents: aString
accessing
start
	| copied |
	"ensure old process is stopped"
	process ifNotNil: [ self stop ].
	"run new process"
	copied := OSSUnixSubprocess new
		command: 'cp';
		arguments:
			{image.
			(image , '.' , port asString)};
		run;
		waitForExit.
	copied = 0
		ifFalse: [ self error: 'Copy of snapshot image failed with exit status ' , copied asString ].
	process := OSSUnixSubprocess new
		command: 'qemu-system-i386';
		arguments:
			{'-nographic'.
			'-hda'.
			(image , '.' , port asString).
			'-loadvm'.
			'randy-installed'.
			'-device'.
			'e1000,netdev=net0'.
			'-netdev'.
			('user,id=net0,hostfwd=tcp::' , port asString , '-:80').
			'-m'.
			'512'.
			'-smp'.
			'1'.
			'-localtime'};
		terminateOnShutdown;
		redirectStdout;
		redirectStderr;
		yourself.
	[ process
		runAndWaitOnExitDo: [ :process0 :out :err | 
			Transcript
				show: 'RandyVm qemu exit with status: ' , process exitStatusInterpreter printString;
				cr;
				show: 'RandyVm qemu stdout: ' , out;
				cr;
				show: 'RandyVm qemu stderr: ' , err;
				cr ] ] fork.
	"wait until reachable"
	ZnClient new
		numberOfRetries: 30;
		retryDelay: 1;
		head: 'http://localhost:' , port asString
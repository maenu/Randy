meta-data
start
	| installBlock installOutput |
	"ensure old process is stopped"
	process ifNotNil: [ self stop ].
	"run new process"
	process := OSSUnixSubprocess new
		command: 'qemu-system-i386';
		arguments:
			{'-nographic'.
			'-snapshot'.
			'-hda'.
			image.
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
		head: 'http://localhost:' , port asString.
	"install randy"
	installBlock := [ :installedMarker | 
	Metacello new
		baseline: #Randy;
		repository: 'github://maenu/Randy:master/src/pharo';
		load: 'Core'.
	SmalltalkImage current saveSession.
	Transcript show: installedMarker ].
	installOutput := self run: installBlock sourceNode formattedCode , ' value: ''' , InstalledMarker , ''''.
	(installOutput endsWith: InstalledMarker)
		ifFalse: [ RandyRunFailed signal: installOutput ].
	^ installOutput
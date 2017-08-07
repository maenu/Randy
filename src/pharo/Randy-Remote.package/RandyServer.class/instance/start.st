meta-data
start
	| installBlock |
	"ensure old process is stopped"
	process ifNotNil: [ self stop ].
	"run new process"
	process := OSSUnixSubprocess new
		command: 'qemu-system-i386';
		arguments: #('-nographic' '-snapshot' '-hda' '../qemu-setup/pharo.img' '-device' 'e1000,netdev=net0' '-netdev' 'user,id=net0,hostfwd=tcp::8080-:80' '-m' '1024' '-smp' '1' '-localtime');
		run;
		yourself.
	"wait until reachable"
	ZnClient new
		numberOfRetries: 61;
		retryDelay: 5;
		head: 'http://localhost:8080'.
	"install randy"
	installBlock := [ Metacello new
		baseline: #Randy;
		repository: 'github://maenu/Randy:master/src/pharo';
		load.
	SmalltalkImage current saveSession ].
	^ self run: installBlock sourceNode formattedCode , ' value'
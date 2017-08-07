meta-data
start
	| installBlock |
	process := OSProcess command: 'qemu-system-i386 -nographic -snapshot -hda ../qemu-setup/pharo.img -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::8080-:80 -m 512 -smp 1 -localtime'.
	installBlock := [ Metacello new
		configuration: 'Randy';
		repository: 'github://maenu/pharo-randy';
		load: 'VM'.
	SmalltalkImage current saveSession ].
	self run: installBlock sourceNode source , ' value'
initialization
setUp
	poolSize := 5.
	hot := 2.
	image := 'image'.
	port := 8080.
	hypervisor := RandyHypervisor
		poolSize: poolSize
		hot: hot
		image: image
		port: port
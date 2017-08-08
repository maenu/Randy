as yet unclassified
runFailedWith: anError
	events at: #runFailed put: DateAndTime now.
	events at: #runFailedLog put: anError.
	self lastRun: false.
	state := #ready
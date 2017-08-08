as yet unclassified
startFailedWith: anError
	events at: #startFailed put: DateAndTime now.
	events at: #startFailedResult put: anError.
	state := #startFailed
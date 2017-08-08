as yet unclassified
stopFailedWith: anError
	events at: #stopFailed put: DateAndTime now.
	events at: #stopFailedResult put: anError.
	state := #stopFailed
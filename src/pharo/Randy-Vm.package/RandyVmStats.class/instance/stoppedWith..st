as yet unclassified
stoppedWith: aString
	events at: #stopped put: DateAndTime now.
	events at: #stoppedResult put: aString.
	state := #created
as yet unclassified
startedWith: aString
	events at: #started put: DateAndTime now.
	events at: #startedResult put: aString.
	state := #ready
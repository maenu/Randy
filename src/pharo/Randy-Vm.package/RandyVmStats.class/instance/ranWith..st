as yet unclassified
ranWith: aString
	events at: #ran put: DateAndTime now.
	events at: #ranResult put: aString.
	self lastRun: true.
	state := #ready
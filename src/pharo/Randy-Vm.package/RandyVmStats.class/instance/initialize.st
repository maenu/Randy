initialization
initialize
	super initialize.
	events := Dictionary new.
	lastRuns := OrderedCollection new. 
	lastRunsSize := 5. 
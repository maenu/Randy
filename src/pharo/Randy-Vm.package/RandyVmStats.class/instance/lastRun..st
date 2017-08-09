accessing
lastRun: aBoolean
	lastRuns size >= lastRunsSize
		ifTrue: [ lastRuns := lastRuns last: lastRunsSize - 1 ].
	lastRuns add: aBoolean
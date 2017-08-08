testing
isBroken
	"TODO what if stop failed?"

	| now |
	now := DateAndTime now.
	^ (((state == #added and: [ now - (events at: #added) > 5 minutes ]) or: [ state == #startFailed ]) or: [ state == #running and: [ now - (events at: #running) > 10 minutes ] ]) or: [ state == #ready and: [ lastRuns reduce: [ :a :b| a or: b ] ] ]
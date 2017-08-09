accessing
image: aString
	poolMonitor
		critical: [ self assert: (image isNil or: aString isNotNil).
			image := aString ]
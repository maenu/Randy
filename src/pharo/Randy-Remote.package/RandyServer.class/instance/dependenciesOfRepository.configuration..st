meta-data
dependenciesOfRepository: aString configuration: anotherString
	| block response start end |
	block := [ :repository :configuration :startMarker :endMarker | 
	| project simplifier json |
	project := RandyProject repository: repository configuration: configuration.
	simplifier := RandyProjectSimplifier project: project.
	json := simplifier asJson.
	Transcript show: startMarker , json , endMarker ].
	response := self run: block sourceNode source , ' value: ''' , aString , ''' value: ''' , anotherString , ''' value: ''' , StartMarker , ''' value: ''' , EndMarker , ''''..
start := response findString: StartMarker .
end := response findString: EndMarker startingAt: start.
^ response copyFrom: start + 1 to: end - 1
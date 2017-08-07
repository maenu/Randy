as yet unclassified
simplifyGroups: aCollection
	^ aCollection
						collect: [ :group | 
							{(#name -> group name).
							(#includes -> group includes)} asDictionary ]
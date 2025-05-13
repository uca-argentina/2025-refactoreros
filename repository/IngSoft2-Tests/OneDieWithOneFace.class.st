"
Creates a template of two dices with six faces and returns them in an ordered collection. 
"
Class {
	#name : 'OneDieWithOneFace',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'action' }
OneDieWithOneFace >> createCollection [

	| aDiceCollection |
	aDiceCollection := OrderedCollection new.
	aDiceCollection addLast: (Die withFaces: 1).
	^ aDiceCollection
]

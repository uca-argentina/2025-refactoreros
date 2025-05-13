"
Creates a template of two dices with six faces and returns them in an ordered collection. 
"
Class {
	#name : 'TwoDiceWithSixFaces',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'action' }
TwoDiceWithSixFaces >> createCollection [

	| aDiceCollection |
	aDiceCollection := OrderedCollection new.
	aDiceCollection addLast: (Die withFaces: 6).
	aDiceCollection addLast: (Die withFaces: 6).
	^ aDiceCollection
]

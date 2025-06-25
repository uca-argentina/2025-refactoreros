"
A measure of distance for board
"
Class {
	#name : 'Parsec',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
Parsec class >> amount: aNumberOfParsecs [

	self validateDistance: aNumberOfParsecs.

	^ self new initializeWithDistanceOf: aNumberOfParsecs
]

{ #category : 'instance creation' }
Parsec class >> validateDistance: aNumberOfParsecs [

	aNumberOfParsecs < 0 ifTrue: [
		Error signal: 'Distance should be positive' ]
]

{ #category : 'initialization' }
Parsec >> initializeWithDistanceOf: aNumberOfParsecs [

	distance := aNumberOfParsecs
]

{ #category : 'actions' }
Parsec >> toParsecs [

	^ distance
]

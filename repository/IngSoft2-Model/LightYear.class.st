Class {
	#name : 'LightYear',
	#superclass : 'Object',
	#instVars : [
		'distance'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
LightYear class >> amount: aNumberOfParsecs [

	self validateDistance: aNumberOfParsecs.

	^ self new initializeWithDistanceOf: aNumberOfParsecs
]

{ #category : 'instance creation' }
LightYear class >> validateDistance: aNumberOfParsecs [

	aNumberOfParsecs < 0 ifTrue: [
		Error signal: 'Distance should be positive' ]
]

{ #category : 'initialization' }
LightYear >> initializeWithDistanceOf: aNumberOfParsecs [

	distance := aNumberOfParsecs
]

{ #category : 'actions' }
LightYear >> toParsecs [

	^ distance // 3
]

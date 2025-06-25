"
A die of N > 3 faces. It returns a random result between 1 and N. 
"
Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'faces'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
Die class >> withFaces: aNumber [

	^ self new initializeWithFaces: aNumber
]

{ #category : 'initialization' }
Die >> initializeWithFaces: aNumberOfFaces [

	(aNumberOfFaces isInteger and: [ aNumberOfFaces > 0 ]) ifFalse: [
		self error: 'Invalid number of faces' ].
	faces := aNumberOfFaces
]

{ #category : 'action' }
Die >> roll [

	^ (1 to: faces) atRandom
]

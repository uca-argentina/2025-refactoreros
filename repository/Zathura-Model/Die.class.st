Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'faces'
	],
	#category : 'Zathura-Model',
	#package : 'Zathura-Model'
}

{ #category : 'as yet unclassified' }
Die class >> withFaces: aNumber [
	^ self new initializeWithFaces: aNumber
]

{ #category : 'initialization' }
Die >> initializeWithFaces: aNumber [

	(aNumber isInteger and: [ aNumber > 0 ]) ifFalse: [ self error: 'Invalid number of faces' ].
	faces := aNumber
]

{ #category : 'as yet unclassified' }
Die >> roll [
	^ (1 to: faces) atRandom
]

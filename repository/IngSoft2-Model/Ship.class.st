"
A ship represents a player in the Board Game. It knows its position, and so it's responsible for moving accross the board itself.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> newPlayer [

	^ self new initializeAtSquareOne
]

{ #category : 'initialization' }
Ship >> initializeAtSquareOne [

	position := 1
]

{ #category : 'accessing' }
Ship >> isLocatedAt: aSquare [

	^ position = aSquare
]

{ #category : 'actions' }
Ship >> moveBackwards: aNumberOfSquares [

	position := position - aNumberOfSquares
]

{ #category : 'actions' }
Ship >> moveForward: aNumberOfSquares [

	position := position + aNumberOfSquares
]

{ #category : 'actions' }
Ship >> moveOneStepForward [

	position := position + 1
]

"
A ship represents a player in the Board Game. It knows its position, and so it's responsible for moving accross the board itself.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> newPlayerWithName: aName [

	^ self new initializeAtSquareOneWithName: aName
]

{ #category : 'actions' }
Ship >> getName [
	^ name asString
]

{ #category : 'initialization' }
Ship >> initializeAtSquareOne [

	position := 1
]

{ #category : 'initialization' }
Ship >> initializeAtSquareOneWithName: aName [

	name := aName asString.
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
Ship >> moveForward: aNumberOfSquares withLimit: aLimit [

	position := position + aNumberOfSquares <= aLimit
		            ifTrue: [ position + aNumberOfSquares ]
		            ifFalse: [ aLimit ]
]

{ #category : 'actions' }
Ship >> moveOneStepForward [

	position := position + 1
]

{ #category : 'actions' }
Ship >> transformIfLandedAt: wormhole [
	position := wormhole getOppositeEnd: position
]

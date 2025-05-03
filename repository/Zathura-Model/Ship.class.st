"
Esta es la clase de la nave, el objeto con el cual se juega el Zathura
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'Zathura-Model',
	#package : 'Zathura-Model'
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
Ship >> moveForward: aNumberOfSquares [

	position := position + aNumberOfSquares
]

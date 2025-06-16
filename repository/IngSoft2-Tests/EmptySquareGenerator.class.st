"
Returns a List of EmptySquares for testing.
"
Class {
	#name : 'EmptySquareGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'actions' }
EmptySquareGenerator >> createSquares: aSquareCount [

	| squareList |
	squareList := OrderedCollection new.

	aSquareCount timesRepeat: [ squareList add: EmptySquare new].

	^ squareList
]

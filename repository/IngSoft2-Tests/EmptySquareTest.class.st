Class {
	#name : 'EmptySquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EmptySquareTest >> testWhenAnEmptySquareReturnsTheSameDictionaryItRecivedThenIsValid [

	| anEmptySquare aDictionaryOfPositions |
	aDictionaryOfPositions := Dictionary new.
	aDictionaryOfPositions at: 'Player 1' put: 1.

	anEmptySquare := EmptySquare withPositionAt: 1.

	self assert: ((anEmptySquare
			 applyEffectTo: aDictionaryOfPositions
			 forShip: 'Player 1') = aDictionaryOfPositions)
]

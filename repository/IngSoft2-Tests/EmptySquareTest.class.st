Class {
	#name : 'EmptySquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'tests' }
EmptySquareTest >> testB01WhenAShipLandsOnAnEmptySquareAndItsPositionRemainsTheSameThenValid [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	anEmptySquare := EmptySquare new.
	anEmptySquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
	self assert: (shipsPositions at: 'Player 1') equals: 1
]

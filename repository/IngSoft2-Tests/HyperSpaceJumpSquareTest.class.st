Class {
	#name : 'HyperSpaceJumpSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
HyperSpaceJumpSquareTest >> testB01WhenAShipLandsOnAHyperJumpSquareAndItsPositionIncreasesBy4ThenValid [

	| aHyperSpaceJumpSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperSpaceJumpSquare := HyperSpaceJumpSquare new.

	aHyperSpaceJumpSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 6
]

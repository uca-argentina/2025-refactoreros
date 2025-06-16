Class {
	#name : 'HyperSpaceJumpSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'testing' }
HyperSpaceJumpSquareTest >> testB01WhenAShipLandsOnAHyperJumpSquareAndItsPositionIncreasesBy4ThenValid [

	| aHyperSpaceJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperSpaceJumpSquare := HyperSpaceJumpSquare new.

	aHyperSpaceJumpSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
	self assert: (shipsPositions at: 'Player 1') equals: 6
]

{ #category : 'tests' }
HyperSpaceJumpSquareTest >> testB02WhenAShipLandsOnAHyperJumpSquareAndLoseOneShieldThenValid [

	| aHyperSpaceJumpSquare shipsShields |
	shipsShields := Dictionary new.
	shipsShields at: 'Player 1' put: 3.

	aHyperSpaceJumpSquare := HyperSpaceJumpSquare new.

	aHyperSpaceJumpSquare
		applyShieldEffectTo: shipsShields
		forShip: 'Player 1'.
	self assert: (shipsShields at: 'Player 1') equals: 2
]

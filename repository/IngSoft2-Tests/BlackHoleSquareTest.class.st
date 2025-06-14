Class {
	#name : 'BlackHoleSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleSquareTest >> testB01WhenAShipLandsOnABlackHoleSquareAndItsPositionDecreasesBy4ThenValid [

	| aBlackHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.

	aBlackHoleSquare := BlackHoleSquare new.

	aBlackHoleSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
	self assert: (shipsPositions at: 'Player 1') equals: 2
]

{ #category : 'tests' }
BlackHoleSquareTest >> testB02WhenAShipLandsOnBlackHoleThatForcesItToLoseALapAndLapDecreasesThenValid [

	| aBlackHoleSquare aShipList aShipManager aShipResultingLap |
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShipManager := ShipManager
		                withShips: aShipList
		                andLapLenght: 10
		                andDice: (LoadedDice withSetNumbers: #( 0 )).

	aBlackHoleSquare := BlackHoleSquare new.

	aShipManager moveShip: (aShipList at: 1) to: 12.
	aShipManager landShip: (aShipList at: 1) atSquare: aBlackHoleSquare.
	aShipResultingLap := aShipManager shipLap: 'Player 1'.
	self assert: aShipResultingLap equals: 0.
	self assert: (aShipManager shipPosition: 'Player 1') equals: 8
]

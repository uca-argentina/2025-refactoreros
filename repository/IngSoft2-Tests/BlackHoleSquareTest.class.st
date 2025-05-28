Class {
	#name : 'BlackHoleSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BlackHoleSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
BlackHoleSquareTest >> testB01WhenAShipLandsOnABlackHoleSquareAndItsPositionDecreasesBy4ThenValid [

	| aBlackHoleSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.

	aBlackHoleSquare := BlackHoleSquare withPositionAt: 6.

	aBlackHoleSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 2
]

{ #category : 'tests' }
BlackHoleSquareTest >> testB02WhenABlackHoleSquareIsCreatedWithInvalidPositionThenFails [

	| aBlackHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ aBlackHoleSquare := BlackHoleSquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

{ #category : 'tests' }
BlackHoleSquareTest >> testB03WhenAShipLandsOnBlackHoleThatForcesItToLoseALapAndLapDecreasesThenValid [

	| aBlackHoleSquare aShipList aShipManager aShipResultingLap |
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShipManager := ShipManager withShips: aShipList andLapLenght: 10 andDice: (LoadedDice withSetNumbers: #(0)).
	
	aBlackHoleSquare := BlackHoleSquare withPositionAt: 2.

	aShipManager moveShip: (aShipList at: 1) to: 12.
	aShipManager landShip:(aShipList at: 1)  atSquare: aBlackHoleSquare.
	aShipResultingLap := aShipManager getShipLap: 'Player 1'.

	self assert: (aShipResultingLap = 0 ).
	self assert: ((aShipManager getShipPosition: 'Player 1' )= 8)
]

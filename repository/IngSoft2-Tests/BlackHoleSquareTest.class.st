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
BlackHoleSquareTest >> test01BWhenAShipLandsOnABlackHoleSquareAndItsPositionDecreasesBy4ThenValid [

	| aBlackHoleSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.

	aBlackHoleSquare := BlackHoleSquare withPositionAt: 6.

	aBlackHoleSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 2
]

{ #category : 'tests' }
BlackHoleSquareTest >> test02BWhenABlackHoleSquareIsCreatedWithInvalidPositionThenFails [

	| aBlackHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ aBlackHoleSquare := BlackHoleSquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

{ #category : 'tests' }
BlackHoleSquareTest >> test03BWhenAShipLandsOnBlackHoleThatForcesItToLoseALapAndLapDecreasesThenValid [

	| aBlackHoleSquare aShipList aShipManager aShipResultingLap |
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShipManager := ShipManager withShips: aShipList.
	aBlackHoleSquare := BlackHoleSquare withPositionAt: 2.

	aShipManager
		placeTheShip: (aShipList at: 1)
		position: 12
		withLapLength: 10.

	"aShipManager landShip: (aShipList at: 1) atSquare: aBlackHoleSquare ."
	aShipManager
		placeTheShip: (aShipList at: 1)
		position: (aShipManager getShipPosition: (aShipList at: 1)) - 4
		withLapLength: 10.
	aShipResultingLap := aShipManager getShipLap: 'Player 1'.

	self assert: aShipResultingLap = 0
]

{ #category : 'tests' }
BlackHoleSquareTest >> test04BWhenAShipLandsOnBlackHoleAtASquareBeforeNumber5AndResultingPositionIsAtPreviousLapThenValid [

	| aBlackHoleSquare aShipList aShipManager aShipResultingPosition |
	aShipList := OrderedCollection withAll: #( 'Player 1' ).
	aShipManager := ShipManager withShips: aShipList.
	aBlackHoleSquare := BlackHoleSquare withPositionAt: 2.

	aShipManager
		placeTheShip: (aShipList at: 1)
		position: 12
		withLapLength: 10.

	"aShipManager landShip: (aShipList at: 1) atSquare: aBlackHoleSquare ."
	aShipManager
		placeTheShip: (aShipList at: 1)
		position: (aShipManager getShipPosition: (aShipList at: 1)) - 4
		withLapLength: 10.
	aShipResultingPosition := aShipManager getShipPosition: 'Player 1'.

	self assert: aShipResultingPosition = 8
]

Class {
	#name : 'WormHoleSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
WormHoleSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
WormHoleSquareTest >> testA01WhenAWormHoleRecivesItsEntrancePositionThenItReturnsItsExitPosition [

	| aWormHole aPosition |
	aWormHole := WormHoleSquare withEntranceAt: 2 andExitAt: 4.
	aPosition := 2.
	self assert: (aWormHole oppositeEnd: aPosition) equals: 4
]

{ #category : 'tests' }
WormHoleSquareTest >> testA02WhenAWormHoleRecivesItsExitPositionThenItReturnsItsEntrancePosition [

	| aWormHole aPosition |
	aWormHole := WormHoleSquare withEntranceAt: 2 andExitAt: 4.
	aPosition := 4.
	self assert: (aWormHole oppositeEnd: aPosition) equals: 2
]

{ #category : 'tests' }
WormHoleSquareTest >> testA04WhenAWormholeHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHoleSquare withEntranceAt: 0 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Positions should be numbers above zero'
]

{ #category : 'tests' }
WormHoleSquareTest >> testA05WhenWormHoleIsCreatedWithExitBeforeEntranceThenItFails [

	self
		should: [ WormHoleSquare withEntranceAt: 3 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Entrace should be located before exit'
]

{ #category : 'tests' }
WormHoleSquareTest >> testB01WhenAShipLandsOnEntrancePositionOfWormHoleAndMovesToExitPositionThenValid [

	| aWormHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aWormHoleSquare := WormHoleSquare withEntranceAt: 2 andExitAt: 4.

	aWormHoleSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
		
	self assert: (shipsPositions at: 'Player 1') equals: 4

]

{ #category : 'tests' }
WormHoleSquareTest >> testB02WhenAShipLandsOnExitPositionOfWormHoleAndMovesToEntrancePositionThenValid [

	| aWormHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 4.

	aWormHoleSquare := WormHoleSquare withEntranceAt: 2 andExitAt: 4.

	aWormHoleSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') equals: 2

]

{ #category : 'tests' }
WormHoleSquareTest >> testB03WhenAShipsLandsOnAWormHoleSquareAndRemainsWithTheSameShieldsThenValid [

	| aWormHoleSquare shipsShields |
	shipsShields := Dictionary new.
	shipsShields at: 'Player 1' put: 3.

	aWormHoleSquare := WormHoleSquare withEntranceAt: 2 andExitAt: 4.

	aWormHoleSquare applyShieldEffectTo: shipsShields forShip: 'Player 1'.

	self assert: shipsShields values equals: #( 3 )

]

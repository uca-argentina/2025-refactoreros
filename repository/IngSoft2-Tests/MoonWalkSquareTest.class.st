Class {
	#name : 'MoonWalkSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
MoonWalkSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB01WhenAShipLandsOnAMoonWalkSquareAndAllOtherShipsGoBackwardsThenValid [

	| aMoonWalkSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.
	shipsPositions at: 'Player 2' put: 5.
	shipsPositions at: 'Player 3' put: 7.

	aMoonWalkSquare := MoonWalkSquare withPositionAt: 6 andBackwardsPush: 4.

	aMoonWalkSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions values) = #(6 1 3).
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB02WhenAShipLandsOnAMoonWalkSquareAndShipDoesNotMoveThenValid [

	| aMoonWalkSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.
	shipsPositions at: 'Player 2' put: 5.

	aMoonWalkSquare := MoonWalkSquare withPositionAt: 6 andBackwardsPush: 4.

	aMoonWalkSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 6
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB03WhenAMoonWalkSquareIsCreatedWithInvalidPositionThenFails [

	| aMoonWalkSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ aMoonWalkSquare := MoonWalkSquare withPositionAt: -1 andBackwardsPush: 1]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

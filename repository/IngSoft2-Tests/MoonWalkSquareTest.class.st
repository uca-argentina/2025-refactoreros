Class {
	#name : 'MoonWalkSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
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

	| aMoonWalkSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.
	shipsPositions at: 'Player 2' put: 5.
	shipsPositions at: 'Player 3' put: 7.

	aMoonWalkSquare := MoonWalkSquare withBackwardsPush: 4.

	aMoonWalkSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
	self assert: shipsPositions values equals: #( 6 1 3 )
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB02WhenAShipLandsOnAMoonWalkSquareAndShipDoesNotMoveThenValid [

	| aMoonWalkSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.
	shipsPositions at: 'Player 2' put: 5.

	aMoonWalkSquare := MoonWalkSquare withBackwardsPush: 4.

	aMoonWalkSquare
		applyPositionEffectTo: shipsPositions
		forShip: 'Player 1'.
	self assert: (shipsPositions at: 'Player 1') equals: 6
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB03WhenAMoonWalkSquareIsCreatedWithInvalidSquaresToPushBackwardsThenFails [

	| aMoonWalkSquare |

	self
		should: [ aMoonWalkSquare := MoonWalkSquare withBackwardsPush: -2]
		raise: Error
		withMessageText: 'Squares to push backwards must be equal or higher than 1'
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB04WhenAShipLandsAloneOnAMoonWalkSquareAndItsShieldsRemainTheSameThenValid [

	| aMoonWalkSquare shipsShields |
	shipsShields := Dictionary new.
	shipsShields at: 'Player 1' put: 3.

	aMoonWalkSquare := MoonWalkSquare withBackwardsPush: 2.

	aMoonWalkSquare applyShieldEffectTo: shipsShields forShip: 'Player 1'.
	self assert: shipsShields values equals: #( 3 )
]

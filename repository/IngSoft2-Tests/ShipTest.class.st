Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipAtSquare5MovesBackwards3StepsThenLandsAtSquare2 [

	| aShip |
	aShip := Ship newPlayer.

	aShip moveForward: 4.
	aShip moveBackwards: 3.

	self assert: (aShip isLocatedAt: 2)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenItStartsAtSquareOne [

	| aShip |
	aShip := Ship newPlayer.

	self assert: (aShip isLocatedAt: 1)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesForwardOneStepTwiceThenLandsAtSquareThree [

	| aShip |
	aShip := Ship newPlayer.

	aShip moveOneStepForward.
	aShip moveOneStepForward.

	self assert: (aShip isLocatedAt: 3)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesForwardTwoSquaresThenItLandsAtSquareThree [

	| aShip |
	aShip := Ship newPlayer.

	aShip moveForward: 2.

	self assert: (aShip isLocatedAt: 3)
]

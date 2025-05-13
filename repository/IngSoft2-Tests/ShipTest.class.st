Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenItStartsAtSquareOne [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	self assert: (aShip isLocatedAt: 1)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesForwardOneStepTwiceThenLandsAtSquareThree [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	aShip moveOneStepForward.
	aShip moveOneStepForward.

	self assert: (aShip isLocatedAt: 3)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesForwardTwoSquaresThenItLandsAtSquareThree [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	aShip moveForward: 2 withLimit: 10.

	self assert: (aShip isLocatedAt: 3)
]

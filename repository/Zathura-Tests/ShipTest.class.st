Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'Zathura-Tests',
	#package : 'Zathura-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenItStartsAtSquareOne [

	| aShip |
	aShip := Ship newPlayer.

	self assert: (aShip isLocatedAt: 1)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesForwardTwoSquaresThenItLandsAtSquareThree [

	| aShip |
	aShip := Ship newPlayer.

	aShip moveForward: 2.

	self assert: (aShip isLocatedAt: 3)
]

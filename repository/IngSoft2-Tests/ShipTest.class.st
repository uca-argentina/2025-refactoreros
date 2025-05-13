Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedAndNameIsDifferentThenInvalid [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	self deny: (aShip getName = 'Player 2')
]

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedAndNameIsEqualThenValid [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	self assert: (aShip getName = 'Player test')
]

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenItStartsAtSquareOne [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	self assert: (aShip isLocatedAt: 1)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipLandsAtASquareDifferentFromWormholeAndPositionRemainsTheSameThenValid [

	| aShip aWormhole|
	aShip := Ship newPlayerWithName: 'Player test'.
	aWormhole := WormHole withEntranceAt: 2 andExitAt: 5.

	aShip moveForward: 1 withLimit: 10.
	aShip transformIfLandedAt: aWormhole .

	self assert: (aShip isLocatedAt: 5)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipLandsAtAWormholeAndPositionRemainsTheSameThenInvalid [

	| aShip aWormhole |
	aShip := Ship newPlayerWithName: 'Player test'.
	aWormhole := WormHole withEntranceAt: 2 andExitAt: 5.

	aShip moveForward: 1 withLimit: 10.
	aShip transformIfLandedAt: aWormhole.

	self deny: (aShip isLocatedAt: 2)
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

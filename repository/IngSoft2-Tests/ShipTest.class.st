Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ShipTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
ShipTest >> testWhenAShipAtSquare5MovesBackwards3StepsThenLandsAtSquare2 [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	aShip moveForward: 4 withLimit: 10.
	aShip moveBackwards: 3.

	self assert: (aShip isLocatedAt: 2)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipAtSquare5MovesBackwards5StepsThenIsInvalid [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	aShip moveForward: 4 withLimit: 10.
	
	self
		should: [ aShip moveBackwards: 5 ]
		raise: Error
		withMessageText: 'There is no position below 1 in the board'
]

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenItStartsAtSquareOne [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.

	self assert: (aShip isLocatedAt: 1)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesBackwardsBeforeMovingForwardThenIsInvalid [

	| aShip |
	aShip := Ship newPlayerWithName: 'Player test'.
	
	self
		should: [ aShip moveBackwards: 1 ]
		raise: Error
		withMessageText: 'There is no position below 1 in the board'
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

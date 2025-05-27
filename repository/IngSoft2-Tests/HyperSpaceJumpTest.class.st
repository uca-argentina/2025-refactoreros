Class {
	#name : 'HyperSpaceJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperSpaceJumpTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
HyperSpaceJumpTest >> test01BWhenAShipLandsOnAHyperJumpSquareAndItsPositionIncreasesBy4ThenValid [

	| aHyperSpaceJumpSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperSpaceJumpSquare := HyperSpaceJumpSquare withPositionAt: 2.

	aHyperSpaceJumpSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 6
]

{ #category : 'tests' }
HyperSpaceJumpTest >> test02BWhenAHyperSpaceJumpSquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

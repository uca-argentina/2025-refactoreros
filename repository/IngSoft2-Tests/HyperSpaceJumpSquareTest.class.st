Class {
	#name : 'HyperSpaceJumpSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperSpaceJumpSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpSquareTest >> test01BWhenAShipLandsOnAHyperJumpSquareAndItsPositionIncreasesBy4ThenValid [

	| aHyperSpaceJumpSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 2.

	aHyperSpaceJumpSquare := HyperSpaceJumpSquare withPositionAt: 2.

	aHyperSpaceJumpSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 6
]

{ #category : 'as yet unclassified' }
HyperSpaceJumpSquareTest >> test02BWhenAHyperSpaceJumpSquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

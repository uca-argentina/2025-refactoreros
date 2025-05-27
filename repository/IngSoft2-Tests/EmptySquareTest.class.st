Class {
	#name : 'EmptySquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
EmptySquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
EmptySquareTest >> test01BWhenAShipLandsOnAnEmptySquareAndItsPositionRemainsTheSameThenValid [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	anEmptySquare := EmptySquare withPositionAt: 1.
	anEmptySquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 1
]

{ #category : 'tests' }
EmptySquareTest >> test02BWhenAnEmptySquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText:
		'A square must be initialized with a position integer equal or higher than 1'
]

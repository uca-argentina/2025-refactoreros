Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BlackHoleTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
BlackHoleTest >> test01BWhenAShipLandsOnABlackHoleSquareAndItsPositionDecreasesBy4ThenValid [

	| aBlackHoleSquare shipsPositions  |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 6.

	aBlackHoleSquare := BlackHoleSquare withPositionAt: 6.

	aBlackHoleSquare
		applyEffectTo: shipsPositions
		forShip: 'Player 1'.

	self assert: (shipsPositions at: 'Player 1') = 2
]

{ #category : 'tests' }
BlackHoleTest >> test02BWhenABlackHoleSquareIsCreatedWithInvalidPositionThenFails [

	| aBlackHoleSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ aBlackHoleSquare := BlackHoleSquare withPositionAt: -1 ]
		raise: Error
		withMessageText: 'A square must be initialized with a position integer equal or higher than 1'
]

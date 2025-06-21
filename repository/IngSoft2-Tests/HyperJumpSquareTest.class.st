Class {
	#name : 'HyperJumpSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
HyperJumpSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
HyperJumpSquareTest >> testB03WhenAHyperJumpSquareIsCreatedWithInvalidParsecsPerSquareThenFails [

	| aHyperJumpSquare shipsPositions |
	shipsPositions := Dictionary new.
	shipsPositions at: 'Player 1' put: 1.

	self
		should: [ aHyperJumpSquare := HyperJumpSquare withParsecsPerSquare: -1 andParsecsRewards: #(10 5 2)]
		raise: Error
		withMessageText: 'Parsecs per square must be equal or higher than 1'
]

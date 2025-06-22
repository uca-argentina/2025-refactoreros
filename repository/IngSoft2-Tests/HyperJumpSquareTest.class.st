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

	self
		should: [ HyperJumpSquare withParsecsRewards: #(  ) ]
		raise: Error
		withMessageText: 'Parsec rewards cannot be empty'
]

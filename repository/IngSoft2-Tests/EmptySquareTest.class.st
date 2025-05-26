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
EmptySquareTest >> test01BWhenAnEmptySquareReturnsTheSameDictionaryItRecivedThenIsValid [

	| anEmptySquare aDictionaryOfPositions |
	aDictionaryOfPositions := Dictionary new.
	aDictionaryOfPositions at: 'Player 1' put: 1.

	anEmptySquare := EmptySquare withPositionAt: 1.

	self assert: ((anEmptySquare
			 applyEffectTo: aDictionaryOfPositions
			 forShip: 'Player 1') = aDictionaryOfPositions)
]

{ #category : 'tests' }
EmptySquareTest >> test02BWhenAnEmptySquareIsCreatedWithInvalidPositionThenFails [

	| anEmptySquare aDictionaryOfPositions |
	aDictionaryOfPositions := Dictionary new.
	aDictionaryOfPositions at: 'Player 1' put: 1.

	self
		should: [ anEmptySquare := EmptySquare withPositionAt: -1 ]
		raise: Error
		withMessageText:
		'A square must be initialized with a position integer equal or higher than 1'
]

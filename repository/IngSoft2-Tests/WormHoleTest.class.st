Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormHoleTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
WormHoleTest >> testWhenBlackHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHole withEntranceAt: -1 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Positions should be numbers above zero'
]

{ #category : 'tests' }
WormHoleTest >> testWhenBlackHoleIsCreatedWithExitBeforeEntranceThenItFails [

	self
		should: [ WormHole withEntranceAt: 3 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Entrace should be located before exit'
]

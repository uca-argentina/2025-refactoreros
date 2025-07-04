Class {
	#name : 'WormHoleSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
WormHoleSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
WormHoleSquareTest >> testA04WhenAWormholeHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHoleSquare withEntranceAt: 0 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Positions should be numbers above zero'
]

{ #category : 'tests' }
WormHoleSquareTest >> testA05WhenWormHoleIsCreatedWithExitBeforeEntranceThenItFails [

	self
		should: [ WormHoleSquare withEntranceAt: 3 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Entrace should be located before exit'
]

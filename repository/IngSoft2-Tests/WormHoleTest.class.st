Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
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
WormHoleTest >> testA01WhenAWormHoleRecivesItsEntrancePositionThenItReturnsItsExitPosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 2.
	self assert: (aWormHole oppositeEnd: aPosition) equals: 4
]

{ #category : 'tests' }
WormHoleTest >> testA02WhenAWormHoleRecivesItsExitPositionThenItReturnsItsEntrancePosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 4.
	self assert: (aWormHole oppositeEnd: aPosition) equals: 2
]

{ #category : 'tests' }
WormHoleTest >> testA04WhenBlackHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHole withEntranceAt: 0 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Positions should be numbers above zero'
]

{ #category : 'tests' }
WormHoleTest >> testA05WhenBlackHoleIsCreatedWithExitBeforeEntranceThenItFails [

	self
		should: [ WormHole withEntranceAt: 3 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Entrace should be located before exit'
]

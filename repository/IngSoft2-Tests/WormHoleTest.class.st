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
WormHoleTest >> testWhenAWormHoleRecivesAPositionThatIsntEntranceNorExitThenItReturnsItsTheSamePosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 1.


	self assert: (aWormHole getOppositeEnd: aPosition) = 1
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleRecivesItsEntrancePositionThenItReturnsItsExitPosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 2.


	self assert: (aWormHole getOppositeEnd: aPosition) = 4
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleRecivesItsExitPositionThenItReturnsItsEntrancePosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 4.


	self assert: (aWormHole getOppositeEnd: aPosition) = 2
]

{ #category : 'tests' }
WormHoleTest >> testWhenBlackHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHole withEntranceAt: 0 andExitAt: 1 ]
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

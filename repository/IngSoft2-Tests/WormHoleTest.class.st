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
WormHoleTest >> test01AWhenAWormHoleRecivesItsEntrancePositionThenItReturnsItsExitPosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 2.


	self assert: (aWormHole oppositeEnd: aPosition) = 4
]

{ #category : 'tests' }
WormHoleTest >> test02AWhenAWormHoleRecivesItsExitPositionThenItReturnsItsEntrancePosition [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 4.


	self assert: (aWormHole oppositeEnd: aPosition) = 2
]

{ #category : 'tests' }
WormHoleTest >> test04AWhenBlackHoleIsCreatedWithAPositionBelowZeroThenItFails [

	self
		should: [ WormHole withEntranceAt: 0 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Positions should be numbers above zero'
]

{ #category : 'tests' }
WormHoleTest >> test05AWhenBlackHoleIsCreatedWithExitBeforeEntranceThenItFails [

	self
		should: [ WormHole withEntranceAt: 3 andExitAt: 1 ]
		raise: Error
		withMessageText: 'Entrace should be located before exit'
]

{ #category : 'tests' }
WormHoleTest >> test06AWhenAWormholeValidatesItsEntrancePositionThenValid [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 2.


	self assert: (aWormHole isAWormHoleEnd: aPosition)
]

{ #category : 'tests' }
WormHoleTest >> test07AWhenAWormholeValidatesItsExitPositionThenValid [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 4.


	self assert: (aWormHole isAWormHoleEnd: aPosition)
]

{ #category : 'tests' }
WormHoleTest >> test08AWhenAWormholeValidatesANonEndPositionThenInvalid [

	| aWormHole aPosition |
	aWormHole := WormHole withEntranceAt: 2 andExitAt: 4.
	aPosition := 3.


	self deny: (aWormHole isAWormHoleEnd: aPosition)
]

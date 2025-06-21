Class {
	#name : 'MoonWalkSquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
MoonWalkSquareTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
MoonWalkSquareTest >> testB03WhenAMoonWalkSquareIsCreatedWithInvalidSquaresToPushBackwardsThenFails [

	| aMoonWalkSquare |

	self
		should: [ aMoonWalkSquare := MoonWalkSquare withBackwardsPush: -2]
		raise: Error
		withMessageText: 'Squares to push backwards must be equal or higher than 1'
]

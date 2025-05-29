Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DieTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
DieTest >> testA01WhenADieRollItFallsOnAValidNumber [

	| aDie value |
	aDie := Die withFaces: 6.
	value := aDie roll.

	self assert:
		(value between: 1 and: 6)
]

{ #category : 'tests' }
DieTest >> testA02WhenADieHasOneFaceThenAlwaysReturnsOne [

	| aDie value |
	aDie := Die withFaces: 1.
	value := aDie roll.
	
	self assert: value equals: 1
]

{ #category : 'tests' }
DieTest >> testA03WhenADieHasZeroFacesThenCreationFails [

	self
		should: [ Die withFaces: 0 ]
		raise: Error
		withMessageText: 'Invalid number of faces'

]

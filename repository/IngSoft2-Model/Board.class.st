"
Contains collaborators that can be used for creating multiple games. 
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
Board class >> populatedBy: aSquareGenerator anAmountOf: aNumberOfSquares withTotalDistanceOf: aNumberOfParsecs [

	| aSetOfSquares |
	aSetOfSquares := aSquareGenerator createSquares: aNumberOfSquares.

	^ self new
		  initializePopulatedOf: aSetOfSquares
		  withDistanceOf: aNumberOfParsecs
]

{ #category : 'instance creation' }
Board class >> populatedOf: aSetOfSquares withTotalDistanceOf: aNumberOfParsecs [

	^ self new
		  initializePopulatedOf: aSetOfSquares
		  withDistanceOf: aNumberOfParsecs
]

{ #category : 'initialization' }
Board >> initializePopulatedOf: aSetOfSquares withDistanceOf: aNumberOfParsecs [

	squares := aSetOfSquares deepCopy.
	parsecs := aNumberOfParsecs.
]

{ #category : 'accessing' }
Board >> numberOfSquares [

	^ squares size
]

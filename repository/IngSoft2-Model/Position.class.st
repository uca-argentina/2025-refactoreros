Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'lap',
		'lapLength',
		'square'
	],
	#category : 'IngSoft2-Model-game',
	#package : 'IngSoft2-Model',
	#tag : 'game'
}

{ #category : 'accessing' }
Position class >> at: aPosition and: aLap and: aLapLegth [

	^ self new initializeWith: aPosition and: aLap and: aLapLegth
]

{ #category : 'accessing' }
Position class >> atStartWith: aLapLegth [

	^ self new initializeWith: 1 and: 0 and: aLapLegth
]

{ #category : 'arithmetic' }
Position >> decreaseBy: aPosition [

	| newPosition newLap lapsGoneBackwards squaresGoneBackwards |
	
	newPosition := square - aPosition square.
	newLap := lap.
	
	
	newPosition <= 0 ifTrue: [ 
			lapsGoneBackwards := (newPosition // lapLength) abs.
			squaresGoneBackwards := newPosition abs % lapLength.

			newPosition := lapLength - squaresGoneBackwards.
			newLap := lap - lapsGoneBackwards.
			
			squaresGoneBackwards = 0 ifFalse: [
				newLap := lap - 1 ].
			
			newLap <= 0 ifTrue:[
				newLap := 0.
				newPosition := 1.
				].

		 ].


	^ (self class at: newPosition and: newLap and: lapLength)
]

{ #category : 'actions' }
Position >> goToStartOfLap [
	
	| newPosition |
	newPosition := 1.
	
	
	^ (self class at: newPosition and: lap and: lapLength)
]

{ #category : 'comparing' }
Position >> hasEqualPosition: aPositon [

	^ square = (aPositon square)
]

{ #category : 'arithmetic' }
Position >> incrementBy: aPosition [

	| newPosition newLap |
	
	newPosition := ((aPosition square) + square ) % lapLength.
	newLap := lap + (aPosition square // lapLength).

	^ (self class at: newPosition and: newLap and: lapLength)
]

{ #category : 'initialization' }
Position >> initializeWith: aSquare and: aLap and: aLapLength [

	square := aSquare.
	lap := aLap.
	lapLength := aLapLength
]

{ #category : 'accessing' }
Position >> lap [

	^ lap
]

{ #category : 'accessing' }
Position >> square [

	^ square
]

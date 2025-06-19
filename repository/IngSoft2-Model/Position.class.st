Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'position',
		'lap',
		'lapLength'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Position class >> at: aPosition and: aLap and: aLapLegth [

	^ self new initializeWith: aPosition and: aLap and: aLapLegth
]

{ #category : 'arithmetic' }
Position >> + aPosition [

	| newPosition newLap |
	
	newPosition := (position + aPosition position) % lapLength.
	newLap := lap + (aPosition position // lapLength).

	^ (self class at: newPosition and: newLap and: lapLength)
]

{ #category : 'arithmetic' }
Position >> - aPosition [

	| newPosition newLap lapsGoneBackwards squaresGoneBackwards |
	
	newPosition := position - aPosition position.
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

{ #category : 'comparing' }
Position >> = aPositon [

	^ position = (aPositon position)
]

{ #category : 'actions' }
Position >> goToStartOfLap [
	
	| newPosition |
	newPosition := 1.
	
	
	^ (self class at: newPosition and: lap and: lapLength)
]

{ #category : 'initialization' }
Position >> initializeWith: aPosition and: aLap and: aLapLength [

	position := aPosition.
	lap := aLap.
	lapLength := aLapLength
]

{ #category : 'accessing' }
Position >> position [

	^ position
]

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

{ #category : 'initialization' }
Position >> initializeWith: aPosition and: aLap and: aLapLength [

	position := aPosition.
	lap := aLap.
	lapLength := aLapLength
]

{ #category : 'accessing' }
Position >> lap [

	^ lap
]

{ #category : 'actions' }
Position >> modifyBy: aPosition [

	| newPosition newLap |
	
	newPosition := (position + aPosition position) % lapLength.
	newLap := lap + (aPosition position // lapLength).

	^ (self class at: newPosition and: newLap and: lapLength)
]

{ #category : 'accessing' }
Position >> position [

	^ position
]

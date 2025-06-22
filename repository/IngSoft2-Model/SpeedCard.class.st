Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'instance creation' }
SpeedCard class >> ownedBy: aShip [
	^ self new initializeOwnedBy: aShip
]

{ #category : 'instance creation' }
SpeedCard class >> withoutOwner [
	^ self new initializeOwnedBy: NullShip new
]

{ #category : 'actions' }
SpeedCard >> applyThrowEffectFor: aShip [

	aShip = owner ifTrue: [ ^ 1 ].
	^ 0
]

{ #category : 'initialization' }
SpeedCard >> initializeOwnedBy: aShip [
	owner := aShip
]

{ #category : 'accessing' }
SpeedCard >> name [

	^ 'Speed Card'
]

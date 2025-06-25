"
A permanent card that increases the total die roll of a selected ship by 1 (affects the total result, not individual die values)
"
Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'target'
	],
	#category : 'IngSoft2-Model-Card-Permanent',
	#package : 'IngSoft2-Model',
	#tag : 'Card-Permanent'
}

{ #category : 'instance creation' }
SpeedCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip
]

{ #category : 'instance creation' }
SpeedCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new
]

{ #category : 'actions' }
SpeedCard >> applyMercenaryEffectFor: aShip in: aListMercenaries [
]

{ #category : 'actions' }
SpeedCard >> applyThrowEffectFor: aShip [

	aShip = target ifTrue: [ ^ 1 ].
	^ 0
]

{ #category : 'initialization' }
SpeedCard >> initializeOwnedBy: aShip targetedTo: anotherShip [

	owner := aShip.
	target := anotherShip 
]

{ #category : 'testing' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'accessing' }
SpeedCard >> name [

	^ 'Speed Card'
]

{ #category : 'accessing' }
SpeedCard >> ownerName [

	^ owner playerName
]

{ #category : 'accessing' }
SpeedCard >> playIn: aGame alongWith: activeCards targetedAt: aTarget [

	activeCards add: self.
	aGame updateLastPlayedCard: self.
]

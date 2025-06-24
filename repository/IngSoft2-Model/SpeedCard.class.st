Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'target'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
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

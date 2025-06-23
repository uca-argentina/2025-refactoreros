Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'instance creation' }
AccelerationCard class >> ownedBy: aShip [

	^ self new initializeOwnedBy: aShip
]

{ #category : 'instance creation' }
AccelerationCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new
]

{ #category : 'actions' }
AccelerationCard >> applyThrowEffectFor: aShip [

	^ 1
]

{ #category : 'initialization' }
AccelerationCard >> initializeOwnedBy: aShip [

	owner := aShip
]

{ #category : 'testing' }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : 'accessing' }
AccelerationCard >> name [

	^ 'Acceleration Card'
]

Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'instance creation' }
CancellationCard class >> ownedBy: aShip [

	^ self new initializeOwnedBy: aShip
]

{ #category : 'instance creation' }
CancellationCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new
]

{ #category : 'actions' }
CancellationCard >> applyEffectIn: aGame for: aTarget [

	aGame applyCancellationTo: aTarget
]

{ #category : 'initialization' }
CancellationCard >> initializeOwnedBy: aShip [

	owner := aShip
]

{ #category : 'testing' }
CancellationCard >> isPermanent [

	^ false
]

{ #category : 'accessing' }
CancellationCard >> name [

	^ 'Cancellation Card'
]

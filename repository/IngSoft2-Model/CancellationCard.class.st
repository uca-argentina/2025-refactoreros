Class {
	#name : 'CancellationCard',
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
CancellationCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip 
]

{ #category : 'instance creation' }
CancellationCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new 
]

{ #category : 'actions' }
CancellationCard >> applyEffectIn: aGame for: aTarget [

	aGame applyCancellationTo: aTarget
]

{ #category : 'initialization' }
CancellationCard >> initializeOwnedBy: aShip targetedTo: anotherShip [

	owner := aShip.
	target := anotherShip 
]

{ #category : 'testing' }
CancellationCard >> isPermanent [

	^ false
]

{ #category : 'accessing' }
CancellationCard >> name [

	^ 'Cancellation Card'
]

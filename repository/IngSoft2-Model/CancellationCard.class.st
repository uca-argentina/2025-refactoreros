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

{ #category : 'accessing' }
CancellationCard >> playIn: aGame alongWith: activeCards targetedAt: aTarget [

	aGame applyCancellationTo: aTarget.
	aGame updateLastPlayedCard: self.
]

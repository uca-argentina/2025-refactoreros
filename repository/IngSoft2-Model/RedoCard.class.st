"
A card that mimics the effect of the last played card, regardless of its type (instant or permanent)
"
Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'target'
	],
	#category : 'IngSoft2-Model-Card-NonPermanent',
	#package : 'IngSoft2-Model',
	#tag : 'Card-NonPermanent'
}

{ #category : 'instance creation' }
RedoCard class >> ownedBy: aShip [

	^ self new initializeOwnedBy: aShip targetedTo: NullShip new 
]

{ #category : 'instance creation' }
RedoCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip 
]

{ #category : 'instance creation' }
RedoCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new 
]

{ #category : 'initialization' }
RedoCard >> initializeOwnedBy: aShip targetedTo: anotherShip [

	owner := aShip.
	target := anotherShip 
]

{ #category : 'testing' }
RedoCard >> isPermanent [

	^ false
]

{ #category : 'accessing' }
RedoCard >> name [

	^ 'Redo Card'
]

{ #category : 'accessing' }
RedoCard >> playIn: aGame alongWith: activeCards targetedAt: aTarget [

	aGame applyRedoTo: aTarget from: owner
]

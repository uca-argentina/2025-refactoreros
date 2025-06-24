Class {
	#name : 'RedoCard',
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

{ #category : 'actions' }
RedoCard >> applyEffectIn: aGame for: aTarget [

	aGame applyRedoTo: aTarget from: owner

	
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

	self applyEffectIn: aGame for: aTarget
]

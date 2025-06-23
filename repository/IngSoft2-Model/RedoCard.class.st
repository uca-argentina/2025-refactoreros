Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#instVars : [
		'owner'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'instance creation' }
RedoCard class >> ownedBy: aShip [

	^ self new initializeOwnedBy: aShip
]

{ #category : 'instance creation' }
RedoCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new
]

{ #category : 'actions' }
RedoCard >> applyEffectIn: aGame for: aTarget [

	aGame applyRedoTo: aTarget from: owner

	
]

{ #category : 'initialization' }
RedoCard >> initializeOwnedBy: aShip [

	owner := aShip
]

{ #category : 'testing' }
RedoCard >> isPermanent [

	^ false
]

{ #category : 'accessing' }
RedoCard >> name [

	^ 'Redo Card'
]

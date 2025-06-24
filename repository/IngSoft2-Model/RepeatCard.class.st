Class {
	#name : 'RepeatCard',
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
RepeatCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip
]

{ #category : 'instance creation' }
RepeatCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new
]

{ #category : 'initialization' }
RepeatCard >> initializeOwnedBy: aShip targetedTo: anotherShip [
	owner := aShip.
	target := anotherShip.
	
]

{ #category : 'testing' }
RepeatCard >> isPermanent [

	^ false
]

{ #category : 'accessing' }
RepeatCard >> name [

	^ 'Repeat Card'
]

{ #category : 'accessing' }
RepeatCard >> playIn: aGame alongWith: activeCards targetedAt: aTarget [

	aGame applyRepeatTo: aTarget
]

"
An instant card that reapplies the last effect used in the game to a selected ship
"
Class {
	#name : 'RepeatCard',
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
RepeatCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip
]

{ #category : 'instance creation' }
RepeatCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new
]

{ #category : 'checking' }
RepeatCard >> checkIfPresent [
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

	aGame applyRepeatTo: aTarget.
	aGame updateLastPlayedCard: self
]

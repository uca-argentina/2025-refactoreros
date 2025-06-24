Class {
	#name : 'MercenaryCard',
	#superclass : 'Object',
	#instVars : [
		'owner',
		'target'
	],
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'as yet unclassified' }
MercenaryCard class >> ownedBy: aShip targetedTo: aTargetShip [

	^ self new initializeOwnedBy: aShip targetedTo: aTargetShip
]

{ #category : 'instance creation' }
MercenaryCard class >> withoutOwner [

	^ self new initializeOwnedBy: NullShip new targetedTo: NullShip new
]

{ #category : 'as yet unclassified' }
MercenaryCard >> applyMercenaryEffectFor: aShip in: aListMercenaries [
	(aShip = owner) ifTrue: [ aListMercenaries add: target].
]

{ #category : 'actions' }
MercenaryCard >> applyThrowEffectFor: aShip [

	^ 0
]

{ #category : 'initialization' }
MercenaryCard >> initializeOwnedBy: aShip targetedTo: anotherShip [

	owner := aShip.
	target := anotherShip 
]

{ #category : 'testing' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'accessing' }
MercenaryCard >> name [

	^ 'Mercenary Card'
]

{ #category : 'accessing' }
MercenaryCard >> playIn: aGame alongWith: activeCards targetedAt: aTarget [

	activeCards add: self.
	aGame updateLastPlayedCard: self.
]

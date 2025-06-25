"
A permanent card that allows the ship to hire a mercenary ship as an ally
"
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

{ #category : 'actions' }
MercenaryCard >> applyMercenaryEffectFor: aShip in: aListMercenaries [

	aShip = owner ifTrue: [ aListMercenaries add: target ]
]

{ #category : 'actions' }
MercenaryCard >> applyThrowEffectFor: aShip [

	^ 0
]

{ #category : 'testing' }
MercenaryCard >> hasTarget: aTarget [

	^ target playerName = aTarget shipName
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

	| activeMercenaryCards |
	activeMercenaryCards := activeCards select: [ :aCard | aCard name = 'Mercenary Card' ]. 
	(activeMercenaryCards anySatisfy: [ :aCard | aCard hasTarget: aTarget ]) ifTrue: [ Error signal: 'Ship has already been hired as mercenary' ].

	activeCards add: self.
	aGame updateLastPlayedCard: self.
]

Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-Card',
	#package : 'IngSoft2-Model',
	#tag : 'Card'
}

{ #category : 'actions' }
AccelerationCard >> activatePermanentCardTo: aGame [

	aGame useAcceleration.
]

{ #category : 'accessing' }
AccelerationCard >> name [

	^ 'Acceleration Card'
]

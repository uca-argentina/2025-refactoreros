"
A loaded dice where we can force the number of the dice we want in our benefit.
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'numbers'
	],
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'initialization' }
LoadedDie class >> withSetNumbers: aCollectionOfNumbers [

	^ self new initializeLoadedDice: aCollectionOfNumbers
]

{ #category : 'initialization' }
LoadedDie >> initializeLoadedDice: aCollectionOfNumbers [

	numbers := OrderedCollection withAll: aCollectionOfNumbers
]

{ #category : 'action' }
LoadedDie >> roll [

	^ numbers removeFirst
]

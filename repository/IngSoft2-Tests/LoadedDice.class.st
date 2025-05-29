"
A loaded dice where we can force the number of the dice we want in our benefit.
"
Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'numbers'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
LoadedDice class >> withSetNumbers: aCollectionOfNumbers [

	^ self new initializeLoadedDice: aCollectionOfNumbers
]

{ #category : 'initialization' }
LoadedDice >> initializeLoadedDice: aCollectionOfNumbers [

	numbers := OrderedCollection withAll: aCollectionOfNumbers.



]

{ #category : 'action' }
LoadedDice >> roll [

	^ numbers removeFirst
]

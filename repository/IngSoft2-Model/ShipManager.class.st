"
Responsible for maintaining and managing ships lap and current lap position information as dictionaries. 
"
Class {
	#name : 'ShipManager',
	#superclass : 'Object',
	#instVars : [
		'shipsPositions',
		'shipsLaps',
		'shipList',
		'lapLength',
		'battleManager',
		'shipTurnSkips'
	],
	#category : 'IngSoft2-Model-game',
	#package : 'IngSoft2-Model',
	#tag : 'game'
}

{ #category : 'initialization' }
ShipManager class >> withShips: aShipList andLapLenght: aLapLength andDice: aDice [

	^ self new initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice
]

{ #category : 'actions' }
ShipManager >> checkBattles: aShip [

	| loser |
	shipsPositions keysAndValuesDo: [ :anotherShip :position |
		(shipsPositions at: anotherShip) = (shipsPositions at: aShip)
			ifTrue: [
				anotherShip = aShip ifFalse: [
					loser := battleManager battle: anotherShip with: aShip.
					shipsPositions at: loser put: 1.
					(battleManager hasShields: loser) ifFalse: [
						shipTurnSkips at: loser put: 2 ] ] ] ]
]

{ #category : 'testing' }
ShipManager >> hasAnyShipReachedLaps: lapsGoal [

	^ shipsLaps anySatisfy: [ :currentLap | currentLap >= lapsGoal ]
]

{ #category : 'testing' }
ShipManager >> hasTurnSkips: aShip [

	| currentTurnSkips |
	currentTurnSkips := shipTurnSkips at: aShip.

	(currentTurnSkips = 1 ) ifTrue: [
			battleManager rechargeShields: aShip ].

	(currentTurnSkips > 0) ifTrue: [
		shipTurnSkips at: aShip put: currentTurnSkips - 1.
		^ true ].

	^ false
]

{ #category : 'intialization' }
ShipManager >> initializeWithShips: aShipList andLapLength: aLapLength andDice: aDice [

	shipList := aShipList.
	lapLength := aLapLength.
	shipsPositions := Dictionary new.
	shipList do: [ :aShip | shipsPositions at: aShip put: 1 ].
	shipsLaps := Dictionary new.
	shipList do: [ :aShip | shipsLaps at: aShip put: 0 ].
	shipTurnSkips := Dictionary new.
	shipList do: [ :aShip | shipTurnSkips at: aShip put: 0 ].
	battleManager := BattleManager with: aShipList and: aDice
]

{ #category : 'actions' }
ShipManager >> landShip: aShip atSquare: nextSquare [

	| newShipsPositions |
	newShipsPositions := shipsPositions copy.
	nextSquare applyPositionEffectTo: newShipsPositions forShip: aShip.
	battleManager applyShieldEffectOf: nextSquare forShip: aShip.

	newShipsPositions := self recalculateBackwardsMovement:
		                     newShipsPositions.

	shipsPositions := newShipsPositions
]

{ #category : 'actions' }
ShipManager >> moveShip: aShip to: nextPosition [

	| shipCurrentPosition shipCurrentLaps lastTurnCompletedLaps |
	shipCurrentPosition := shipsPositions at: aShip.
	shipCurrentLaps := shipsLaps at: aShip.
	lastTurnCompletedLaps := nextPosition // lapLength.

	shipsLaps at: aShip put: shipCurrentLaps + lastTurnCompletedLaps.

	shipsPositions
		at: aShip
		put: nextPosition - (lastTurnCompletedLaps * lapLength)
]

{ #category : 'accessing' }
ShipManager >> obtainNextPositionFor: aShip with: diceResult [

	^ (shipsPositions at: aShip) + diceResult
]

{ #category : 'actions' }
ShipManager >> recalculateBackwardsMovement: newShipsPositions [

	| lapsGoneBackwards squaresGoneBackwards |
	newShipsPositions keysAndValuesDo: [ :ship :position |
		position <= 0 ifTrue: [
			lapsGoneBackwards := (position // lapLength) abs.
			squaresGoneBackwards := position abs % lapLength.

			newShipsPositions at: ship put: lapLength - squaresGoneBackwards.

			shipsLaps at: ship put: (shipsLaps at: ship) - lapsGoneBackwards.

			squaresGoneBackwards = 0 ifFalse: [
				shipsLaps at: ship put: (shipsLaps at: ship) - 1 ].

			(shipsLaps at: ship) <= 0 ifTrue: [
				shipsLaps at: ship put: 0.
				shipsPositions at: ship put: 1 ] ] ].

	^ newShipsPositions
]

{ #category : 'accessing' }
ShipManager >> shipLap: aShip [

	^ shipsLaps at: aShip
]

{ #category : 'accessing' }
ShipManager >> shipPosition: aShip [

	^ shipsPositions
		  at: aShip
		  ifAbsent: [ Error signal: 'There is no ship with such name' ]
]

{ #category : 'actions' }
ShipManager >> skipTurnAndRechargeShields: aShip [

	shipTurnSkips at: aShip put: 1.
	battleManager rechargeShields: aShip
]

{ #category : 'accessing' }
ShipManager >> winner [

	| rankedShips |
	rankedShips := shipsLaps associations asSortedCollection: [
		               :aShip
		               :anotherShip | aShip value > anotherShip value ].
	^ (rankedShips at: 1) key
]

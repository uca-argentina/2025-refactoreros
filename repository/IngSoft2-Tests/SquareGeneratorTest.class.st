Class {
	#name : 'SquareGeneratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
SquareGeneratorTest >> count: aSquareClass in: aSquareList closeTo: aRatio precision: aPrecision [
	| count |
	count := 0.
	1 to: aSquareList size do:[ :i|
		(((aSquareList at: i) class) = aSquareClass ) ifTrue: [ 
			count := count + 1.
			 ]
		].
	
	self assert: count/(aSquareList size) closeTo: aRatio  precision: aPrecision 
]

{ #category : 'tests' }
SquareGeneratorTest >> testB01WhenASquareGeneratorCreatesSquareAndSquareListSizeMatchesSquareCountThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 100.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put: 0.4.
	squaresWithProbability at: BlackHoleSquare new  put: 0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put: 0.2.
	squaresWithProbability at: (MoonWalkSquare withBackwardsPush: 1) put: 0.1.
	squaresWithProbability at: (HyperJumpSquare withParsecsPerSquare: 5 andParsecsRewards: #( 10 5 2 )) put: 0.08.
	squaresWithProbability at: AtomicBombSquare new put: 0.02.


	squareGenerator := SquareGenerator with: squaresWithProbability.

	squareList := squareGenerator createSquares: squareCount.
	self assert: squareList size equals: squareCount
]

{ #category : 'tests' }
SquareGeneratorTest >> testB02WhenSquaresCreatedFollowTheProbabilityDistributionThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 1000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put:0.4.
	squaresWithProbability at: BlackHoleSquare new  put:0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put:0.2.
	squaresWithProbability at: (MoonWalkSquare withBackwardsPush:1) put:0.1.
	squaresWithProbability at: (HyperJumpSquare withParsecsPerSquare: 5 andParsecsRewards: #( 10 5 2 )) put:0.08.
	squaresWithProbability at: AtomicBombSquare new put:0.02.

	squareGenerator := SquareGenerator with: squaresWithProbability.
	squareList := squareGenerator createSquares: squareCount.
	
	self count: EmptySquare in: squareList closeTo: 0.4 precision: 0.05.
	self count: BlackHoleSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: HyperSpaceJumpSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: MoonWalkSquare in: squareList closeTo: 0.1 precision: 0.05.
	self count: HyperJumpSquare in: squareList closeTo: 0.08 precision: 0.05.
	self count: AtomicBombSquare in: squareList closeTo: 0.02 precision: 0.05
	

]

{ #category : 'tests' }
SquareGeneratorTest >> testB03WhenProbabilitiesDoNotAddUpToOneAndTheRemainingAreFilledWithEmptySquaresThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 1000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put:0.4.
	squaresWithProbability at: BlackHoleSquare new  put:0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put:0.2.

	squareGenerator := SquareGenerator with: squaresWithProbability.
	squareList := squareGenerator createSquares: squareCount.
	
	self count: EmptySquare in: squareList closeTo: 0.6 precision: 0.05.
	self count: BlackHoleSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: HyperSpaceJumpSquare in: squareList closeTo: 0.2 precision: 0.05.


	

]

{ #category : 'tests' }
SquareGeneratorTest >> testB04WhenProbabilitiesDoNotAddUpToOneAndThereIsNoProbabilityForEmptySquareAndTheRemainingAreFilledWithEmptySquaresThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 1000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: BlackHoleSquare new  put: 0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put: 0.2.

	squareGenerator := SquareGenerator with: squaresWithProbability.
	squareList := squareGenerator createSquares: squareCount.
	
	self count: EmptySquare in: squareList closeTo: 0.6 precision: 0.05.
	self count: BlackHoleSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: HyperSpaceJumpSquare in: squareList closeTo: 0.2 precision: 0.05.


	

]

Class {
	#name : 'SquareGeneratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-gameTest',
	#package : 'IngSoft2-Tests',
	#tag : 'gameTest'
}

{ #category : 'asserting' }
SquareGeneratorTest >> count: aSquareClass in: aSquareList closeTo: aRatio precision: aPrecision [

	| count total actualRatio tolerance |
	count := aSquareList count: [ :square | square class = aSquareClass ].
	total := aSquareList size.
	actualRatio := count asFloat / total asFloat.
	tolerance := aRatio < 0.05
		             ifTrue: [ 0.01 ]
		             ifFalse: [ aPrecision ].

	self assert:
		(actualRatio between: aRatio - tolerance and: aRatio + tolerance)
]

{ #category : 'asserting' }
SquareGeneratorTest >> should: anErrorBlock raise: errorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: errorClass
		withExceptionDo: [ :error |
		self assert: (error messageText) equals: errorMessage ]
]

{ #category : 'tests' }
SquareGeneratorTest >> testB01WhenASquareGeneratorCreatesSquareAndSquareListSizeMatchesSquareCountThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 10000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put: 0.4.
	squaresWithProbability at: BlackHoleSquare new  put: 0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put: 0.2.
	squaresWithProbability at: (MoonWalkSquare withBackwardsPush: 1) put: 0.1.
	squaresWithProbability at: (HyperJumpSquare withParsecsRewards: #( 10 5 2 )) put: 0.08.
	squaresWithProbability at: AtomicBombSquare new put: 0.02.


	squareGenerator := SquareGenerator with: squaresWithProbability.

	squareList := squareGenerator createSquares: squareCount.
	self assert: squareList size equals: squareCount
]

{ #category : 'tests' }
SquareGeneratorTest >> testB02WhenSquaresCreatedFollowTheProbabilityDistributionThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 10000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put:0.3.
	squaresWithProbability at: DrawCardSquare new put:0.1.
	squaresWithProbability at: BlackHoleSquare new  put:0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put:0.2.
	squaresWithProbability at: (MoonWalkSquare withBackwardsPush:1) put:0.1.
	squaresWithProbability at: (HyperJumpSquare withParsecsRewards: #( 10 5 2 )) put:0.08.
	squaresWithProbability at: AtomicBombSquare new put:0.02.

	squareGenerator := SquareGenerator with: squaresWithProbability.
	squareList := squareGenerator createSquares: squareCount.
	
	self count: EmptySquare in: squareList closeTo: 0.3 precision: 0.05.
	self count: DrawCardSquare in: squareList closeTo: 0.1 precision: 0.05.
	self count: BlackHoleSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: HyperSpaceJumpSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: MoonWalkSquare in: squareList closeTo: 0.1 precision: 0.05.
	self count: HyperJumpSquare in: squareList closeTo: 0.08 precision: 0.05.
	self count: AtomicBombSquare in: squareList closeTo: 0.02 precision: 0.05
	

]

{ #category : 'tests' }
SquareGeneratorTest >> testB03WhenProbabilitiesDoNotAddUpToOneAndTheRemainingAreFilledWithEmptySquaresThenValid [

	| squareCount squareGenerator squareList squaresWithProbability |
	squareCount := 10000.
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
	squareCount := 10000.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: BlackHoleSquare new  put: 0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put: 0.2.

	squareGenerator := SquareGenerator with: squaresWithProbability.
	squareList := squareGenerator createSquares: squareCount.
	
	self count: EmptySquare in: squareList closeTo: 0.6 precision: 0.05.
	self count: BlackHoleSquare in: squareList closeTo: 0.2 precision: 0.05.
	self count: HyperSpaceJumpSquare in: squareList closeTo: 0.2 precision: 0.05.


	

]

{ #category : 'tests' }
SquareGeneratorTest >> testB05WhenTotalProbabilityIsLargerThanOneThenItFails [

	| squareCount squareGenerator squaresWithProbability |
	squareCount := 100.
	squaresWithProbability := Dictionary new.
	squaresWithProbability at: EmptySquare new put: 0.4.
	squaresWithProbability at: BlackHoleSquare new put: 0.2.
	squaresWithProbability at: HyperSpaceJumpSquare new put: 0.2.
	squaresWithProbability at: (MoonWalkSquare withBackwardsPush: 1) put: 0.1.
	squaresWithProbability at: (HyperJumpSquare withParsecsRewards: #( 10 5 2 )) put: 0.8.
	squaresWithProbability at: AtomicBombSquare new put: 0.9.




	self
		should: [
		squareGenerator := SquareGenerator with: squaresWithProbability ]
		raise: Error
		withMessageText: 'Total Probability should not be larger than 1'
]

!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/4/2022 18:49:32'!
test01StartsAtLandingPositionAndDirection

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/4/2022 22:40:03'!
test02AtLandingIsNotInOtherPositionAndDirection

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	
	self assert: (marsRover isInPosition: (1@1) andDirection: #S) not.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:38:23'!
test03MovingForwardFacingNorthIncreasePositionsYCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover moveForward.
	
	self assert: (marsRover isInPosition: (0@1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:38:35'!
test04MovingForwardFacingSouthDecreasePositionsYCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover moveForward.
	
	self assert: (marsRover isInPosition: (0@-1) andDirection: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:38:44'!
test05MovingForwardFacingEastIncreasePositionsXCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #E.
	marsRover moveForward.
	
	self assert: (marsRover isInPosition: (1@0) andDirection: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:33:32'!
test06MovingForwardFacingWestDecreasePositionsYCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #W.
	marsRover moveForward.
	
	self assert: (marsRover isInPosition: (-1@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:38:54'!
test07MovingBackwardsFacingNorthDecreasePositionsYCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover moveBackwards.
	
	self assert: (marsRover isInPosition: (0@-1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:39:53'!
test08MovingBackwardsFacingSouthIncreasePositionsYCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover moveBackwards.
	
	self assert: (marsRover isInPosition: (0@1) andDirection: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:37:07'!
test09MovingBackwardsFacingEastDecreasePositionsXCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #E.
	marsRover moveBackwards.
	
	self assert: (marsRover isInPosition: (-1@0) andDirection: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:40:08'!
test10MovingBackwardsFacingWestIncreasePositionsXCoordinate

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #W.
	marsRover moveBackwards.
	
	self assert: (marsRover isInPosition: (1@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/4/2022 23:49:04'!
test11RotatingLeftFacingNorthChangesDirectionToWest

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover rotateLeft.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/4/2022 23:50:14'!
test12RotatingRightFacingNorthChangesDirectionToEast

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover rotateRight.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/4/2022 23:53:55'!
test13RotatingLeftFacingSouthChangesDirectionToEast

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover rotateLeft.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #E).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/5/2022 00:00:06'!
test14RotatingRightFacingSouthChangesDirectionToWest

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover rotateRight.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/5/2022 00:00:40'!
test15RotatingLeftFacingEastChangesDirectionToNorth

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #E.
	marsRover rotateLeft.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/5/2022 00:06:18'!
test16RotatingRightFacingEastChangesDirectionToSouth

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #E.
	marsRover rotateRight.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/5/2022 00:06:28'!
test17RotatingLeftFacingWestChangesDirectionToSouth

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #W.
	marsRover rotateLeft.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SR 10/5/2022 00:06:48'!
test18RotatingRightFacingWestChangesDirectionToNorth

	| marsRover |
	
	marsRover := MarsRover withPosition: (0@0) andDirection: #W.
	marsRover rotateRight.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:25:23'!
test19ReceivingAnFMakesRoverMoveForwards

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'f'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:25:56'!
test20ReceivingABMakesRoverMoveBackwards

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'b'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@-1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 16:37:28'!
test21ReceivingAnLMakesRoverRotateLeft

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'l'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 16:37:23'!
test22ReceivingAnRMakesRoverRotateLeft

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'r'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 16:40:53'!
test23ReceivingTwoValidInstructionsThatMakeRoverStayAtStartingPoint

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'fb'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #S.
	marsRover receiveInstructionString: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #S).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 17:23:57'!
test24ReceivingThreeValidInstructionsThatMakeRoverMoveAndRotate

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'ff'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveInstructionString: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@2) andDirection: #N).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'SR 10/4/2022 23:31:18'!
initializeWithPosition: aPosition andDirection: aDirection

	direction := aDirection.	
	position := aPosition.! !


!MarsRover methodsFor: 'state' stamp: 'SR 10/4/2022 23:25:36'!
isInPosition: aPosition andDirection: aDirection 
	
	^position = aPosition and: [ direction = aDirection ].! !


!MarsRover methodsFor: 'actions' stamp: 'SR 10/4/2022 23:46:32'!
moveBackwards

	(MarsRoverState for: self with: direction) moveBackwards.! !

!MarsRover methodsFor: 'actions' stamp: 'SR 10/4/2022 23:35:24'!
moveForward 

	(MarsRoverState for: self with: direction) moveForward.! !

!MarsRover methodsFor: 'actions' stamp: 'cde 10/5/2022 17:16:32'!
receiveInstructionString: anInstruction
	
	anInstruction do: [:aSingleInstruction | self receiveSingleInstruction: aSingleInstruction]! !

!MarsRover methodsFor: 'actions' stamp: 'cde 10/5/2022 17:21:18'!
receiveSingleInstruction: anInstruction
	
	anInstruction = 'f' ifTrue: [^ self moveForward].
	anInstruction = 'b' ifTrue: [^ self moveBackwards].
	anInstruction = 'l' ifTrue: [^ self rotateLeft].
	anInstruction = 'r' ifTrue: [^ self rotateRight].! !

!MarsRover methodsFor: 'actions' stamp: 'SR 10/5/2022 00:18:34'!
rotateLeft
	
	(MarsRoverState for: self with: direction) rotateLeft.! !

!MarsRover methodsFor: 'actions' stamp: 'SR 10/5/2022 00:18:39'!
rotateRight
	
	(MarsRoverState for: self with: direction) rotateRight.! !


!MarsRover methodsFor: 'private' stamp: 'cde 10/5/2022 17:30:47'!
moveEast

	position := position + (1@0)! !

!MarsRover methodsFor: 'private' stamp: 'cde 10/5/2022 17:30:54'!
moveNorth

	position := position + (0@1)! !

!MarsRover methodsFor: 'private' stamp: 'cde 10/5/2022 17:31:00'!
moveSouth

	position := position - (0@1)! !

!MarsRover methodsFor: 'private' stamp: 'cde 10/5/2022 17:31:06'!
moveWest

	position := position - (1@0)! !

!MarsRover methodsFor: 'private' stamp: 'SR 10/5/2022 00:18:07'!
rotateEast

	direction := #E.! !

!MarsRover methodsFor: 'private' stamp: 'SR 10/5/2022 00:17:55'!
rotateNorth

	direction := #N.! !

!MarsRover methodsFor: 'private' stamp: 'SR 10/5/2022 00:18:03'!
rotateSouth

	direction := #S.! !

!MarsRover methodsFor: 'private' stamp: 'SR 10/5/2022 00:18:11'!
rotateWest

	direction := #W.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'SR 10/4/2022 18:43:36'!
withPosition: aPosition andDirection: aDirection

	^self new initializeWithPosition: aPosition andDirection: aDirection.! !


!classDefinition: #MarsRoverState category: 'MarsRover'!
Object subclass: #MarsRoverState
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverState methodsFor: 'initialization' stamp: 'SR 10/4/2022 23:45:33'!
initializeWith: aMarsRover

	marsRover := aMarsRover! !


!MarsRoverState methodsFor: 'actions' stamp: 'SR 10/4/2022 22:51:42'!
moveBackwards

	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'SR 10/4/2022 22:51:45'!
moveForward

	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'SR 10/5/2022 00:08:52'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'SR 10/5/2022 00:08:57'!
rotateRight

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverState class' category: 'MarsRover'!
MarsRoverState class
	instanceVariableNames: ''!

!MarsRoverState class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:40:10'!
canHandle: aDirection

	self subclassResponsibility ! !

!MarsRoverState class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:45:34'!
createFor: aMarsRover

	^self new initializeWith: aMarsRover! !

!MarsRoverState class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:45:06'!
for: aMarsRover with: aDirection

	^(self subclasses detect: [ :aSubclass | aSubclass canHandle: aDirection ]) createFor: aMarsRover.! !


!classDefinition: #MarsRoverEast category: 'MarsRover'!
MarsRoverState subclass: #MarsRoverEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverEast methodsFor: 'actions' stamp: 'SR 10/4/2022 22:57:29'!
moveBackwards
	
	marsRover moveWest.! !

!MarsRoverEast methodsFor: 'actions' stamp: 'SR 10/4/2022 22:57:16'!
moveForward
	
	marsRover moveEast.! !

!MarsRoverEast methodsFor: 'actions' stamp: 'SR 10/5/2022 00:16:41'!
rotateLeft

	marsRover rotateNorth.! !

!MarsRoverEast methodsFor: 'actions' stamp: 'SR 10/5/2022 00:16:36'!
rotateRight
	
	marsRover rotateSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverEast class' category: 'MarsRover'!
MarsRoverEast class
	instanceVariableNames: ''!

!MarsRoverEast class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:40:34'!
canHandle: aDirection

	^aDirection = #E! !


!classDefinition: #MarsRoverNorth category: 'MarsRover'!
MarsRoverState subclass: #MarsRoverNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverNorth methodsFor: 'actions' stamp: 'SR 10/4/2022 22:57:46'!
moveBackwards
	
	marsRover moveSouth.! !

!MarsRoverNorth methodsFor: 'actions' stamp: 'SR 10/4/2022 22:57:54'!
moveForward
	
	marsRover moveNorth.! !

!MarsRoverNorth methodsFor: 'actions' stamp: 'SR 10/5/2022 00:14:54'!
rotateLeft

	marsRover rotateWest.! !

!MarsRoverNorth methodsFor: 'actions' stamp: 'SR 10/5/2022 00:15:13'!
rotateRight

	marsRover rotateEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverNorth class' category: 'MarsRover'!
MarsRoverNorth class
	instanceVariableNames: ''!

!MarsRoverNorth class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:40:43'!
canHandle: aDirection

	^aDirection = #N! !


!classDefinition: #MarsRoverSouth category: 'MarsRover'!
MarsRoverState subclass: #MarsRoverSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverSouth methodsFor: 'actions' stamp: 'SR 10/4/2022 22:58:03'!
moveBackwards
	
	marsRover moveNorth.! !

!MarsRoverSouth methodsFor: 'actions' stamp: 'SR 10/4/2022 22:58:06'!
moveForward
	
	marsRover moveSouth.! !

!MarsRoverSouth methodsFor: 'actions' stamp: 'SR 10/5/2022 00:15:56'!
rotateLeft

	marsRover rotateEast.! !

!MarsRoverSouth methodsFor: 'actions' stamp: 'SR 10/5/2022 00:16:03'!
rotateRight

	marsRover rotateWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverSouth class' category: 'MarsRover'!
MarsRoverSouth class
	instanceVariableNames: ''!

!MarsRoverSouth class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:40:47'!
canHandle: aDirection

	^aDirection = #S! !


!classDefinition: #MarsRoverWest category: 'MarsRover'!
MarsRoverState subclass: #MarsRoverWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverWest methodsFor: 'actions' stamp: 'SR 10/4/2022 22:58:14'!
moveBackwards
	
	marsRover moveEast.! !

!MarsRoverWest methodsFor: 'actions' stamp: 'SR 10/4/2022 22:58:20'!
moveForward
	
	marsRover moveWest.! !

!MarsRoverWest methodsFor: 'actions' stamp: 'SR 10/5/2022 00:16:16'!
rotateLeft

	marsRover rotateSouth.! !

!MarsRoverWest methodsFor: 'actions' stamp: 'SR 10/5/2022 00:16:22'!
rotateRight

	marsRover rotateNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWest class' category: 'MarsRover'!
MarsRoverWest class
	instanceVariableNames: ''!

!MarsRoverWest class methodsFor: 'as yet unclassified' stamp: 'SR 10/4/2022 23:40:51'!
canHandle: aDirection

	^aDirection = #W! !

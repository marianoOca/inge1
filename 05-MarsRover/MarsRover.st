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

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 18:00:42'!
test19ReceivingAnFMakesRoverMoveForwards

	| marsRover instructionFromEarth|
	
	instructionFromEarth := $f.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 18:00:49'!
test20ReceivingABMakesRoverMoveBackwards

	| marsRover instructionFromEarth|
	
	instructionFromEarth := $b.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@-1) andDirection: #N).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 18:00:56'!
test21ReceivingAnLMakesRoverRotateLeft

	| marsRover instructionFromEarth|
	
	instructionFromEarth := $l.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveSingleInstruction: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@0) andDirection: #W).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 18:01:03'!
test22ReceivingAnRMakesRoverRotateLeft

	| marsRover instructionFromEarth|
	
	instructionFromEarth := $r.				
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

!MarsRoverTest methodsFor: 'tests' stamp: 'cde 10/5/2022 18:00:06'!
test24ReceivingThreeValidInstructionsThatMakeRoverMoveAndRotate

	| marsRover instructionFromEarth|
	
	instructionFromEarth := 'ffr'.				
	marsRover := MarsRover withPosition: (0@0) andDirection: #N.
	marsRover receiveInstructionString: instructionFromEarth.
	
	self assert: (marsRover isInPosition: (0@2) andDirection: #E).! !

!MarsRoverTest methodsFor: 'tests'!

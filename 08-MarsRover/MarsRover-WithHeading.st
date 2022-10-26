!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:11:38'!
test17MarsRoverHasNoMovementLogsWhenInitialized
	
	self assert: ( (MovementLogBook for: (MarsRover at: 0@0 heading: MarsRoverHeadingNorth)) isEmpty )
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:06'!
test18MarsRoverMovementLogsSinglePositionInLogBook
	
	
	| aMarsRover aLogBook |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := MovementLogBook for: aMarsRover. 
	
	aMarsRover process: 'f'. 
	
	self assert: (aLogBook logBookEntries at: 1) equals: '0@1'.
	self assert: (aLogBook size) equals: 1
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:14'!
test19MarsRoverMovementLogsSingleRotationInLogBook
	
	
	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := MovementLogBook for: aMarsRover. 
	
	aMarsRover process: 'r'.
	
	self assert: (aLogBook logBookEntries at: 1) equals: 'East'.
	self assert: (aLogBook size) equals: 1
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:21'!
test20MarsRoverMovementLogsMoreThanOnePositionInLogBook

	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := MovementLogBook for: aMarsRover. 

	aMarsRover process: 'flbr'. 

	self assert: (aLogBook logBookEntries at: 1) equals: '0@1'.
	self assert: (aLogBook logBookEntries at: 2) equals: 'West'.
	self assert: (aLogBook logBookEntries at: 3) equals: '1@1'.
	self assert: (aLogBook logBookEntries at: 4) equals: 'North'.
	self assert: (aLogBook size) equals: 4
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:28'!
test21MarsRoverHasNoHeadingLogsWhenInitialized
	
	self assert: ( (HeadingLogBook for: (MarsRover at: 0@0 heading: MarsRoverHeadingNorth)) isEmpty )
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:34'!
test22MarsRoverHasNoHeadingLogsWhenMovingFowardOrBackwards
	
	| aMarsRover aLogBook |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := HeadingLogBook for: aMarsRover. 
	
	aMarsRover process: 'fb'.
	
	self assert: aLogBook isEmpty
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:43'!
test23MarsRoverHeadingLogsSingleRotationInLogBook
	
	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := HeadingLogBook for: aMarsRover. 
	
	aMarsRover process: 'r'. 
	
	self assert: (aLogBook logBookEntries at: 1) equals: 'East'.
	self assert: (aLogBook size) equals: 1
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:50'!
test24MarsRoverHeadingLogsMoreThanOneHeadingInLogBook

	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := HeadingLogBook for: aMarsRover. 

	aMarsRover process: 'flbr'. 

	self assert: (aLogBook logBookEntries at: 1) equals: 'West'.
	self assert: (aLogBook logBookEntries at: 2) equals: 'North'.
	self assert: (aLogBook size) equals: 2
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:12:57'!
test25MarsRoverHasNoPositionsLogsWhenInitialized
	
	self assert: ( (PositionsLogBook for: (MarsRover at: 0@0 heading: MarsRoverHeadingNorth)) isEmpty )
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:13:06'!
test26MarsRoverHasNoPositionsLogsWhenMovingFowardOrBackwards
	
	| aMarsRover aLogBook |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := PositionsLogBook for: aMarsRover. 
	
	aMarsRover process: 'rl'.
	
	self assert: aLogBook isEmpty! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:13:14'!
test27MarsRoverPositionsLogsSinglePositionInLogBook
	
	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := PositionsLogBook for: aMarsRover. 
	
	aMarsRover process: 'f'. 
	
	self assert: (aLogBook logBookEntries at: 1) equals: '0@1'.
	self assert: (aLogBook size) equals: 1! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:13:27'!
test28MarsRoverPositionsLogsMoreThanOnePositionsInLogBook

	| aMarsRover aLogBook |

	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogBook := PositionsLogBook for: aMarsRover. 

	aMarsRover process: 'flbr'. 

	self assert: (aLogBook logBookEntries at: 1) equals: '0@1'.
	self assert: (aLogBook logBookEntries at: 2) equals: '1@1'.
	self assert: (aLogBook size) equals: 2! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:08'!
test29MarsRoverWindowPositionTrackerShowsCorrectPositionAfterFCommand
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowPositionTracker for: aMarsRover. 
	aMarsRover process: 'f'. 

	self assert: (aTracker currentPosition) equals: '0@1'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:14'!
test30MarsRoverWindowPositionTrackerShowsCorrectPositionAfterFBCommand
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowPositionTracker for: aMarsRover. 
	aMarsRover process: 'fb'. 

	self assert: (aTracker currentPosition) equals: '0@0'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:26'!
test31MarsRoverWindowPositionTrackerIgnoresRotation
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowPositionTracker for: aMarsRover. 
	aMarsRover process: 'frf'. 

	self assert: (aTracker currentPosition) equals: '1@1'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:32'!
test32MarsRoverWindowHeadingTrackerShowsCorrectHeadingAfterRCommand
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowHeadingTracker for: aMarsRover. 
	aMarsRover process: 'r'. 

	self assert: (aTracker currentHeading) equals: 'East'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:38'!
test33MarsRoverWindowHeadingTrackerShowsCorrectHeadingAfterRRCommand
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowHeadingTracker for: aMarsRover. 
	aMarsRover process: 'rr'. 

	self assert: (aTracker currentHeading) equals: 'South'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:47'!
test34MarsRoverWindowHeadingTrackerIgnoresPosition
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowHeadingTracker for: aMarsRover. 
	aMarsRover process: 'frf'. 

	self assert: (aTracker currentHeading) equals: 'East'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:09:58'!
test35MarsRoverWindowMovementTrackerShowsCorrectPositionAndHeading
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowMovementTracker for: aMarsRover. 
	aMarsRover process: 'frf'. 

	self assert: (aTracker currentPosition) equals: '1@1'.
	self assert: (aTracker currentHeading) equals: 'East'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MO 10/26/2022 13:10:10'!
test36MarsRoverWindowMovementTrackerShowsCorrectPositionAndHeadingAfterMultipleCommands
	
	
	| aMarsRover aTracker |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aTracker := WindowMovementTracker for: aMarsRover. 
	aMarsRover process: 'frflf'.

	self assert: (aTracker currentPosition) equals: '1@2'.
	self assert: (aTracker currentHeading) equals: 'North'.
	! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #LogBook category: 'MarsRover-WithHeading'!
Object subclass: #LogBook
	instanceVariableNames: 'logBookEntries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogBook methodsFor: 'initialization' stamp: 'SR 10/26/2022 00:17:36'!
initializeFor: aMarsRover
	
	logBookEntries := OrderedCollection new.
	aMarsRover addRecipient: self.
	"TranscriptWindow openTranscript.
	Transcript clear.				"! !


!LogBook methodsFor: 'receive' stamp: 'cde4 10/24/2022 20:44:42'!
addEntry: anEntry

	logBookEntries add: anEntry! !

!LogBook methodsFor: 'receive' stamp: 'cde4 10/24/2022 22:01:35'!
receiveHeading: aHeading

	self subclassResponsibility ! !

!LogBook methodsFor: 'receive' stamp: 'cde4 10/24/2022 22:01:50'!
receivePosition: aPosition

	self subclassResponsibility! !

!LogBook methodsFor: 'receive' stamp: 'SR 10/26/2022 00:17:27'!
saveLog: aNotification

	self addEntry: aNotification. 
	
	"Transcript show: aNotification."! !


!LogBook methodsFor: 'content' stamp: 'cde4 10/24/2022 20:51:06'!
isEmpty

	 ^ logBookEntries isEmpty.! !

!LogBook methodsFor: 'content' stamp: 'MO 10/26/2022 13:15:24'!
logBookEntries

	^ logBookEntries! !

!LogBook methodsFor: 'content' stamp: 'MO 10/26/2022 13:15:29'!
size

	^ logBookEntries size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LogBook class' category: 'MarsRover-WithHeading'!
LogBook class
	instanceVariableNames: ''!

!LogBook class methodsFor: 'as yet unclassified' stamp: 'cde4 10/24/2022 20:54:46'!
for: aMarsRover
	
	^ self new initializeFor: aMarsRover.! !


!classDefinition: #HeadingLogBook category: 'MarsRover-WithHeading'!
LogBook subclass: #HeadingLogBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogBook methodsFor: 'receive' stamp: 'SR 10/26/2022 00:18:00'!
receiveHeading: aHeading

	self saveLog: aHeading. 
	
	"Transcript show: aHeading."! !

!HeadingLogBook methodsFor: 'receive' stamp: 'cde4 10/24/2022 22:01:08'!
receivePosition: aPosition! !


!classDefinition: #MovementLogBook category: 'MarsRover-WithHeading'!
LogBook subclass: #MovementLogBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MovementLogBook methodsFor: 'receive' stamp: 'SR 10/26/2022 00:17:20'!
receiveHeading: aHeading

	self saveLog: aHeading! !

!MovementLogBook methodsFor: 'receive' stamp: 'SR 10/26/2022 00:17:20'!
receivePosition: aPosition

	self saveLog: aPosition! !


!classDefinition: #PositionsLogBook category: 'MarsRover-WithHeading'!
LogBook subclass: #PositionsLogBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionsLogBook methodsFor: 'receive' stamp: 'cde4 10/24/2022 22:01:18'!
receiveHeading: aHeading! !

!PositionsLogBook methodsFor: 'receive' stamp: 'SR 10/26/2022 00:18:15'!
receivePosition: aPosition

	self saveLog: aPosition. 
	
	"Transcript show: aPosition."! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head recipients'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'cde4 10/24/2022 21:17:06'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	recipients := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'cde4 10/24/2022 22:09:13'!
rotateLeft
	
	head rotateLeft.
	self notifyHeading: (head asString).! !

!MarsRover methodsFor: 'heading' stamp: 'cde4 10/24/2022 22:09:17'!
rotateRight
	
	head rotateRight.
	self notifyHeading: (head asString).! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'recipients' stamp: 'cde4 10/24/2022 21:17:59'!
addRecipient: aRecipient

	recipients add: aRecipient! !

!MarsRover methodsFor: 'recipients' stamp: 'SR 10/26/2022 00:17:20'!
notify: aNotification

	recipients do: [ :aRecipient | aRecipient saveLog: aNotification ]! !

!MarsRover methodsFor: 'recipients' stamp: 'cde4 10/24/2022 22:00:52'!
notifyHeading: aHeading

	recipients do: [ :aRecipient | aRecipient receiveHeading: aHeading ]! !

!MarsRover methodsFor: 'recipients' stamp: 'cde4 10/24/2022 22:00:31'!
notifyPosition: aPosition

	recipients do: [ :aRecipient | aRecipient receivePosition: aPosition ]! !


!MarsRover methodsFor: 'moving' stamp: 'cde4 10/24/2022 22:08:50'!
moveBackward
	
	head moveBackward.
	
	self notifyPosition: position asString.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'cde4 10/24/2022 22:08:55'!
moveForward
	
	head moveForward.
	
	self notifyPosition: position asString.! !

!MarsRover methodsFor: 'moving' stamp: 'cde4 10/24/2022 20:26:36'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'printing' stamp: 'cde4 10/24/2022 21:31:55'!
asString
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'printing' stamp: 'cde4 10/24/2022 21:32:42'!
asString

	^ 'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'printing' stamp: 'cde4 10/24/2022 21:32:55'!
asString

	^ 'North'! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'printing' stamp: 'cde4 10/24/2022 21:33:12'!
asString

	^ 'South'! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'printing' stamp: 'cde4 10/24/2022 21:33:25'!
asString

	^ 'West'! !


!classDefinition: #WindowTracker category: 'MarsRover-WithHeading'!
Object subclass: #WindowTracker
	instanceVariableNames: 'currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:56:11'!
currentHeading

	^currentHeading.! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:56:16'!
currentPosition

	^currentPosition ! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:58:58'!
initializeFor: aMarsRover
	
	aMarsRover addRecipient: self.
	currentPosition := ''.
	currentHeading := ''.
	TranscriptWindow openTranscript.
	Transcript clear.! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:57:53'!
printCurrentTrack

	Transcript clear.
	Transcript show: currentPosition.
	Transcript show: currentHeading.! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:55:45'!
printLoggs

	Transcript clear.
	Transcript show: currentPosition.
	Transcript show: currentHeading.! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:57:50'!
printTrack

	Transcript clear.
	Transcript show: currentPosition.
	Transcript show: currentHeading.! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:54:09'!
receiveHeading: aHeading

	self subclassResponsibility .! !

!WindowTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:54:20'!
receivePosition: aPosition

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WindowTracker class' category: 'MarsRover-WithHeading'!
WindowTracker class
	instanceVariableNames: ''!

!WindowTracker class methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:51:03'!
for: aMarsRover
	
	^ self new initializeFor: aMarsRover.! !


!classDefinition: #WindowHeadingTracker category: 'MarsRover-WithHeading'!
WindowTracker subclass: #WindowHeadingTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowHeadingTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:58:10'!
receiveHeading: aHeading

	currentHeading := aHeading.
	self printCurrentTrack.! !

!WindowHeadingTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:41:40'!
receivePosition: aPosition

	! !


!classDefinition: #WindowMovementTracker category: 'MarsRover-WithHeading'!
WindowTracker subclass: #WindowMovementTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowMovementTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:58:14'!
receiveHeading: aHeading

	currentHeading := aHeading.
	self printCurrentTrack.! !

!WindowMovementTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:58:17'!
receivePosition: aPosition

	currentPosition := aPosition.
	self printCurrentTrack.! !


!classDefinition: #WindowPositionTracker category: 'MarsRover-WithHeading'!
WindowTracker subclass: #WindowPositionTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowPositionTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:40:36'!
receiveHeading: aHeading

	! !

!WindowPositionTracker methodsFor: 'as yet unclassified' stamp: 'SR 10/26/2022 00:58:21'!
receivePosition: aPosition

	currentPosition := aPosition.
	self printCurrentTrack.! !

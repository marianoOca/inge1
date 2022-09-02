!classDefinition: #I category: 'Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'ErrorDescriptors' stamp: 'MO 9/2/2022 17:28:01'!
canNotDivideByBiggerNumberErrorDescription

	^ 'In natural numbers, can not divide a number with a bigger number'! !

!I class methodsFor: 'ErrorDescriptors' stamp: 'MO 9/2/2022 17:25:04'!
negativeNumbersNotSupportedErrorDescription

	^ 'In natural numbers, can not substract a number minus a bigger or equal number'! !


!I class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:09:02'!
* aFactor

	^ aFactor! !

!I class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:08:04'!
+ anAdder

	^ anAdder next.! !

!I class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:22:09'!
- aSubtrahend

	self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:34:37'!
/ aDivisor

	aDivisor = I ifTrue:[^self].

	self error: self canNotDivideByBiggerNumberErrorDescription! !

!I class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:50:48'!
> aNumber
	
	^ false! !

!I class methodsFor: 'Operations' stamp: 'MO 8/29/2022 20:50:16'!
subtractFrom: aMinuend
	
	^aMinuend previous! !


!I class methodsFor: 'Next' stamp: 'M0 8/25/2022 21:29:09'!
next
	next ifNil:[next _ self cloneNamed: self name, 'I'].
	^next.
	"la flechita se hace con _ es equivalente a :="! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:08:35'!
* aFactor

	^ (self previous * aFactor) + aFactor! !

!II class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:07:56'!
+ anAdder

	^ self previous + anAdder next! !

!II class methodsFor: 'Operations' stamp: 'MO 8/29/2022 20:51:40'!
- aSubtrahend

	"aSubtrahend = I ifTrue:[^self previous].
	
	self previous - aSubtrahend previous"
	
	^ aSubtrahend subtractFrom: self! !

!II class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:57:27'!
/ aDivisor

	aDivisor = self ifTrue:[^I].
	
	aDivisor > self ifTrue:[self error: self canNotDivideByBiggerNumberErrorDescription].

	^ ((self - aDivisor) / aDivisor) next
	! !

!II class methodsFor: 'Operations' stamp: 'MO 9/2/2022 17:51:27'!
> aNumber
	
	aNumber = I ifTrue:[^true].
	
	^ self previous > aNumber previous
	! !

!II class methodsFor: 'Operations' stamp: 'MO 8/29/2022 20:58:03'!
subtractFrom: aMinuend
	
	^aMinuend previous - self previous! !


!II class methodsFor: 'NextAndPrevious' stamp: 'MO 9/2/2022 17:07:36'!
nameOfNext

	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	
	^ self name, 'I'! !

!II class methodsFor: 'NextAndPrevious' stamp: 'MO 9/2/2022 17:07:39'!
next

	next ifNil:[
		next _ II createChildNamed: self nameOfNext.
		next previous: self.
		].
	^next.! !

!II class methodsFor: 'NextAndPrevious' stamp: 'MO 9/2/2022 17:07:49'!
previous

	^ previous! !

!II class methodsFor: 'NextAndPrevious' stamp: 'MO 9/2/2022 17:07:46'!
previous: aNumber

	previous := aNumber! !


!II class methodsFor: 'ErrorDescriptors' stamp: 'MO 9/2/2022 17:30:27'!
canNotDivideByBiggerNumberErrorDescription

	^ 'In natural numbers, can not divide a number with a bigger number'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Naturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Naturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #IX category: 'Naturales'!
II subclass: #IX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IX class' category: 'Naturales'!
IX class
	instanceVariableNames: ''!

!IX class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := X.
	previous := VIII.! !


!classDefinition: #V category: 'Naturales'!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: 'Naturales'!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !


!classDefinition: #VI category: 'Naturales'!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: 'Naturales'!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !


!classDefinition: #VII category: 'Naturales'!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: 'Naturales'!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:13'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !


!classDefinition: #VIII category: 'Naturales'!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: 'Naturales'!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IX.
	previous := VIII.! !


!classDefinition: #X category: 'Naturales'!
II subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'X class' category: 'Naturales'!
X class
	instanceVariableNames: ''!

!X class methodsFor: '--** private fileout/in **--' stamp: 'MO 9/2/2022 17:58:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IX.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
IX initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!
X initializeAfterFileIn!

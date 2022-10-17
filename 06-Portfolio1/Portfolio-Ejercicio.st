!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:04:55'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:11:03'!
test02PortfolioWithOneAccountEqualsItsBalance 

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
		
	self assert: account balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:38:29'!
test03PortfolioWithVariousAccountsEqualsTheSumOfItsBalances

	| portfolio account1 account2 account3|
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	account3 := ReceptiveAccount  new.
	
	portfolio add: account1; add: account2; add: account3.
	Deposit register: 100 on: account1.
	Deposit register: 2 on: account2.
	Deposit register: 1020 on: account3.
		
	self assert: 1122 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:39:36'!
test04PortfolioWithVariousAccountsEqualsTheSumOfItsBalancesWhenSomeAreNegative

	| portfolio account1 account2 account3|
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	account3 := ReceptiveAccount  new.
	
	portfolio add: account1; add: account2; add: account3.
	Withdraw register: 100 on: account1.
	Withdraw register: 20 on: account2.
	Deposit register: 1120 on: account3.
		
	self assert: 1000 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:43:47'!
test05PortfolioWithPortfolioGivesCorrectBalance

	| portfolio1 portfolio2 account1 account2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	portfolio2 add: account1; add: account2.
	portfolio1 add: portfolio2.
	Deposit register: 100 on: account1.
	Deposit register: 20 on: account2.
		
	self assert: 120 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:47:05'!
test06PortfolioWithVariousPortfolioGivesCorrectBalance

	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	account3 := ReceptiveAccount  new.
	
	portfolio2 add: account1; add: account2.
	portfolio3 add: account3.
	portfolio1 add: portfolio2; add: portfolio3; add: portfolio4.
	Deposit register: 100 on: account1.
	Deposit register: 20 on: account2.
	Deposit register: 30 on: account3.
		
	self assert: 150 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'MO 10/6/2022 21:48:33'!
test07PortfolioWithPortfolioAndAccountGivesCorrectBalance

	| portfolio1 portfolio2 account1 account2 account3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	account3 := ReceptiveAccount  new.
	
	portfolio2 add: account1; add: account2.
	portfolio1 add: portfolio2; add: account3.
	Deposit register: 100 on: account1.
	Deposit register: 20 on: account2.
	Deposit register: 30 on: account3.
		
	self assert: 150 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 01:28:18'!
test08CantAddAnAccountToAPortfolioThatHasThatAccount

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	portfolio add: account.
	portfolio add: account.
		
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/15/2022 22:34:24'!
test09CantAddAnAccountToAPortfolioThatHasAPortfolioWithThatAccount

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	portfolio1 add: account.
		
	self assert: 100 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/15/2022 20:10:38'!
test10CantAddAPortfolioToItself

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	portfolio add: account.
	portfolio add: portfolio.
		
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/15/2022 20:15:54'!
test11CantAddAPortfolioWithAnAccountToAPortfolioThatHasThatAccount

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio1 add: account.
	portfolio2 add: account.
	
	portfolio1 add: portfolio2.
		
	self assert: 100 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 01:36:33'!
test12CantAddAnAccountToAPortfolioInsideAPortfolioWithThatAccount

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio1 add: account.
	portfolio1 add: portfolio2.
	portfolio2 add: account.
		
	self assert: 100 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 03:31:53'!
test13CantAddAnAccountToAPortfolioInsideAPortfolioTreeWithThatAccount

	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio1 add: account.
	portfolio1 add: portfolio2.
	portfolio2 add: portfolio3.
	portfolio3 add: account.
		
	self assert: 100 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 23:19:26'!
test14TransactionsOfEmptyPortfolioIsEmpty

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio transactions size.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 23:20:36'!
test15TransactionsOfPortfolioWithOneAccountEqualsAccountTransactions

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	portfolio add: account.

	self assert: account transactions equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/17/2022 00:03:44'!
test16TransactionsOfPortfolioWithTwoAccountsEqualsThoseAccountsTransactions

	| portfolio account1 account2 result |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	result := OrderedCollection new.
	result addAll: account1 transactions.
	result addAll: account2 transactions.

	self assert: portfolio transactions equals: result.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/16/2022 23:41:18'!
test17TransactionsOfPortfolioWithPortfoliosAndAccountEqualsThoseServicesTransactions

	| account1 account2 portfolio1 portfolio2 result |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio1 add: portfolio2.
	
	result := OrderedCollection new.
	result addAll: account1 transactions.
	result addAll: account2 transactions.

	self assert: portfolio1 transactions equals: result.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/17/2022 00:08:04'!
test18PortfolioWithAnAccountHasRegisteredTransactionsOfThatAccount

	| account portfolio |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	portfolio add: account.

	self assert: (portfolio hasRegistered: account transactions first).! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/17/2022 00:12:40'!
test19EmptyPortfolioDoesntHaveRegisteredTransactions

	| account portfolio |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.

	self assert: (portfolio hasRegistered: account transactions first) not.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/17/2022 00:22:09'!
test20PortfolioWithAccountsDoesntHaveRegisteredTransactionsOfOtherAccounts

	| account1 account2 portfolio |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
	
	portfolio add: account1.

	self assert: (portfolio hasRegistered: account2 transactions first) not.! !

!PortfolioTest methodsFor: 'test' stamp: 'SR 10/17/2022 00:25:17'!
test21PortfolioWithPortfoliosAndAccountsHasRegisteredTransactionsOfThoseServices

	| account1 account2 portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio1 add: portfolio2.

	self assert: (portfolio1 hasRegistered: account1 transactions first).
	self assert: (portfolio1 hasRegistered: account2 transactions first).! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MO 10/6/2022 20:43:38'!
value

	^ value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'MO 10/6/2022 20:42:04'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MO 10/6/2022 20:38:59'!
for: aValue

	^ self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MO 10/6/2022 20:47:26'!
register: aValue on: account
	
	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'applyToBalance' stamp: 'MO 10/6/2022 21:25:23'!
applyToBalance: aBalance

	^ aBalance + value! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'applyToBalance' stamp: 'MO 10/6/2022 21:25:42'!
applyToBalance: aBalance

	^ aBalance - value! !


!classDefinition: #FinancialService category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialService methodsFor: 'as yet unclassified' stamp: 'cde 10/13/2022 21:12:27'!
balance

	self subclassResponsibility ! !

!FinancialService methodsFor: 'as yet unclassified' stamp: 'cde 10/13/2022 21:38:25'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!FinancialService methodsFor: 'as yet unclassified' stamp: 'cde 10/13/2022 21:12:41'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialService subclass: #Portfolio
	instanceVariableNames: 'financialServices parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'cde 10/13/2022 21:28:59'!
balance
	
	^ financialServices inject: 0 into: [ :balance :aService | balance + (aService balance) ].! !


!Portfolio methodsFor: 'initialization' stamp: 'SR 10/16/2022 02:38:03'!
initialize

	financialServices := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'SR 10/16/2022 04:42:48'!
add: aFinancialService
	
	(self canRootsAdd: aFinancialService) ifTrue: [
		financialServices add: aFinancialService.
		(aFinancialService isKindOf: Portfolio) ifTrue: [ aFinancialService addParent: self ].
		].! !

!Portfolio methodsFor: 'adding' stamp: 'SR 10/16/2022 02:47:47'!
addParent: aPortfolio

	parents add: aPortfolio.! !

!Portfolio methodsFor: 'adding' stamp: 'SR 10/16/2022 04:39:13'!
canAdd: aFinancialService
	
	| response |
	
	response := (self = aFinancialService) not.
	
	"probar double dispatch"
	(aFinancialService isKindOf: Portfolio) ifTrue: [
			aFinancialService financialServices do: [ :aService |
				response := response and: [ self canAdd: aService ].
				].
		] ifFalse: [
			financialServices do: [ :aService |
			response := response and: [
				(aService isKindOf: Portfolio) ifTrue: [ aService canAdd: aFinancialService ] ifFalse: [ (aService = aFinancialService) not ].
				].
			].
		].
	
	"response := parents inject: response into: [ :res :aPortfolio | res and: [ aPortfolio canAdd: aFinancialService ] ]."
	
	^response! !

!Portfolio methodsFor: 'adding' stamp: 'SR 10/16/2022 04:41:59'!
canRootsAdd: aFinancialService
	
	| roots canAdd |
	
	roots := self rootPortfolios.
	
	canAdd := roots inject: true into: [ :res :aPortfolio | res and: [ aPortfolio canAdd: aFinancialService ] ].
	
	^canAdd! !


!Portfolio methodsFor: 'transactions' stamp: 'SR 10/17/2022 00:29:14'!
transactions

	"retorna todas las transacciones de las cuentas del portfolio"
	
	| result |
	
	result := OrderedCollection new.
	
	financialServices do: [ :aService | result addAll: aService transactions ].
	
	^result! !


!Portfolio methodsFor: 'testing' stamp: 'SR 10/17/2022 00:31:05'!
hasRegistered: aTransaction

	"retorna verdadero si alguna de las cuentas del portfolio registró la transtacción"
	
	^self transactions includes: aTransaction.! !


!Portfolio methodsFor: 'private' stamp: 'SR 10/16/2022 01:25:48'!
financialServices

	^financialServices ! !

!Portfolio methodsFor: 'private' stamp: 'SR 10/16/2022 04:26:28'!
rootPortfolios

	| portfolios |
	
	portfolios := Set new.
	
	parents isEmpty ifTrue: [
			portfolios add: self.
		] ifFalse: [
			parents do: [ :parentPortfolio | portfolios addAll: (parentPortfolio rootPortfolios) ].
		].
	
	^portfolios! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialService subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MO 10/6/2022 21:32:43'!
balance
	
	^ transactions inject: 0 into: [ :balance :aTransaction | aTransaction applyToBalance: balance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

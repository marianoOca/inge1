!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/21/2022 15:33:14'!
test16AccountCanTransferToAnotherAccountCorrectly

	| anotherFuckingAccount aMothefuckingAccount |
	
	aMothefuckingAccount := ReceptiveAccount new.
	anotherFuckingAccount := ReceptiveAccount new.
	
	Transfer register: 50 from: aMothefuckingAccount to: anotherFuckingAccount.
	
	self assert: aMothefuckingAccount balance equals: (-50).
	self assert: anotherFuckingAccount balance equals: 50! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/21/2022 16:15:23'!
test17AccountCanTransferToAnotherAccountThatIsWIthinAPortfolioCorrectly

	| aSenderAccount aReceiverAccount portfolio |
	
	aSenderAccount := ReceptiveAccount new.
	aReceiverAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: aReceiverAccount.

	Transfer register: 50 from: aSenderAccount to: aReceiverAccount.
	
	self assert: aSenderAccount balance equals: (-50).
	self assert: aReceiverAccount balance equals: 50! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/21/2022 16:15:46'!
test18AccountTransferenceIsRegisteredCorrectlyInSendingAccount

	| aSenderAccount aReceiverAccount aTransfer |
	
	aSenderAccount := ReceptiveAccount new.
	aReceiverAccount := ReceptiveAccount new.
	
	aTransfer := Transfer register: 50 from: aSenderAccount to: aReceiverAccount.
	
	self assert: (aSenderAccount transactions includes: aTransfer)
! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/21/2022 16:16:23'!
test19AccountTransferenceIsRegisteredCorrectlyInReceivingAccount

	| aSenderAccount aReceiverAccount aTransfer |
	
	aSenderAccount := ReceptiveAccount new.
	aReceiverAccount := ReceptiveAccount new.
	
	aTransfer := Transfer register: 50 from: aSenderAccount to: aReceiverAccount.
	
	self assert: (aReceiverAccount transactions includes: aTransfer)! !

!PortfolioTest methodsFor: 'tests' stamp: 'cde 10/20/2022 20:31:26'!
test20AccountSummaryReturnsListWithNoBalanceInAccountWithNoMovements

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	self assert: (anAccount accountSummary at: 1) equals: 'Balance = 0.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'cde 10/20/2022 20:16:22'!
test21AccountSummaryReturnsListWithOneDeposit

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount. 
	
	self assert: (anAccount accountSummary at: 1) equals: 'Deposito por 50.'.
	self assert: (anAccount accountSummary at: 2) equals: 'Balance = 50.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'cde 10/20/2022 20:16:16'!
test22AccountSummaryReturnsListWithOneDepositAndOneWithdrawal

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 25 on: anAccount. 
	
	self assert: (anAccount accountSummary at: 1) equals: 'Deposito por 100.'.
	self assert: (anAccount accountSummary at: 2) equals: 'Extraccion por 25.'.
	self assert: (anAccount accountSummary at: 3) equals: 'Balance = 75.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 21:59:55'!
test23AccountSummaryReturnsListWithOneDepositOneWithdrawalAndOneOutgoingTransference

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 10 on: anAccount.
	Withdraw register: 5 on: anAccount.
	Transfer register: 10 from: anAccount to: anotherAccount.
	
	self assert: (anAccount accountSummary at: 1) equals: 'Deposito por 10.'.
	self assert: (anAccount accountSummary at: 2) equals: 'Extraccion por 5.'.
	self assert: (anAccount accountSummary at: 3) equals: 'Salida por transferencia de 10.'.
	self assert: (anAccount accountSummary at: 4) equals: 'Balance = -5.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 22:17:27'!
test24AccountSummaryReturnsListWithOneOutgoingTransferenceAndOneIncomingTransference

	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer register: 10 from: anAccount to: anotherAccount.
	Transfer register: 01 from: anotherAccount to: anAccount.
	
	self assert: (anAccount accountSummary at: 1) equals: 'Salida por transferencia de 10.'.
	self assert: (anAccount accountSummary at: 2) equals: 'Entrada por transferencia de 1.'.
	self assert: (anAccount accountSummary at: 3) equals: 'Balance = -9.'! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 23:15:32'!
test25AccountSummaryOnPortfolioReturnsListWithNoBalanceWhenEmpty
	
	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assert: (aPortfolio accountSummary at: 1) equals: 'Balance = 0.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 23:19:37'!
test26AccountSummaryOnPortfolioReturnsListWithOneDeposit

	| aPortfolio anAccount |

	anAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount.
	Deposit register: 50 on: anAccount.

	self assert: (aPortfolio accountSummary at: 1) equals: 'Deposito por 50.'.
	self assert: (aPortfolio accountSummary at: 2) equals: 'Balance = 50.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 23:37:29'!
test27AccountSummaryOnPortfolioReturnsListWithOneDepositAndOneWithdrawal

	| aPortfolio anAccount anotherAccount |

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 25 on: anotherAccount. 
	
	self assert: (aPortfolio accountSummary at: 1) equals: 'Deposito por 100.'.
	self assert: (aPortfolio accountSummary at: 2) equals: 'Extraccion por 25.'.
	self assert: (aPortfolio accountSummary at: 3) equals: 'Balance = 75.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 23:59:33'!
test28AccountSummaryOnPortfolioReturnsListWithOneDepositOneWithdrawalAndOneOutgoingTransference

	| aPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	Deposit register: 10 on: anAccount.
	Withdraw register: 5 on: anAccount.
	Transfer register: 10 from: anAccount to: anotherAccount.
	
	self assert: (aPortfolio accountSummary at: 1) equals: 'Deposito por 10.'.
	self assert: (aPortfolio accountSummary at: 2) equals: 'Extraccion por 5.'.
	self assert: (aPortfolio accountSummary at: 3) equals: 'Salida por transferencia de 10.'.
	self assert: (aPortfolio accountSummary at: 4) equals: 'Entrada por transferencia de 10.'.
	self assert: (aPortfolio accountSummary at: 5) equals: 'Balance = 5.'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/23/2022 23:16:35'!
test29AccountNetTrasferReportIsCorrectWithTwoTransactions

	| anAccount anotherAccount |

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	Deposit register: 10 on: anAccount.
	Withdraw register: 5 on: anAccount.
	Transfer register: 10 from: anAccount to: anotherAccount.
	Transfer register: 01 from: anotherAccount to: anAccount.

	self assert: (anAccount netTransferReport) equals: 'De reporte de neto de transferencias de -9.'! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 00:03:44'!
test30AccountNetTrasferReportOnPortfolioIsCorrectWithTwoTransactions

	| aPortfolio anAccount anotherAccount anExternalAccount |

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	anExternalAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount .

	Deposit register: 10 on: anAccount.
	Withdraw register: 5 on: anAccount.
	Transfer register: 10 from: anAccount to: anotherAccount.
	Transfer register: 01 from: anotherAccount to: anAccount.
	Transfer register: 01 from: anExternalAccount to: anAccount.

	self assert: (aPortfolio netTransferReport) equals: 'De reporte de neto de transferencias de 1.'! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 14:56:56'!
test31NamedAccountHasCorrectName

	| account |
	
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	
	self assert: account accountName equals: 'Cuenta de Juan'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 14:57:09'!
test32NamedPortfolioHasCorrectName

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio familiar'.
	
	self assert: portfolio accountName equals: 'Portfolio familiar'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 15:13:28'!
test33UnnamedAccountHasNoName

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [ account accountName ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Account accountHasNoName equals: anError messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 15:13:20'!
test34UnnamedPortfolioHasNoName

	| portfolio |
	
	portfolio := Portfolio new.
	
	self 
		should: [ portfolio accountName ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Account accountHasNoName equals: anError messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 15:23:09'!
test35NamedPortfolioReportsItself

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio familiar'.
	
	self assert: (portfolio structureReport at: 1) equals: 'Portfolio familiar'! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 15:35:34'!
test36NamedPortfolioReportsWithOneAccountReportCorrectly

	| account portfolio |

	account := ReceptiveAccount named: 'vacio'.
	portfolio := Portfolio named: 'Portfolio familiar' with: account.

	self assert: (portfolio structureReport at: 1) equals: 'Portfolio familiar'.
	self assert: (portfolio structureReport at: 2) equals: '   vacio'! !

!PortfolioTest methodsFor: 'tests' stamp: 'MO 10/24/2022 15:35:23'!
test37NamedPortfolioReportsWithTwoAccountsReportCorrectly

	| anAccount anotherAccount portfolio |

	anAccount := ReceptiveAccount named: 'Hijo Prodigio'.
	anotherAccount := ReceptiveAccount named: 'El Otro'.
	portfolio := Portfolio named: 'Portfolio familiar' with: anAccount with: anotherAccount.

	self assert: (portfolio structureReport at: 1) equals: 'Portfolio familiar'.
	self assert: (portfolio structureReport at: 2) equals: '   Hijo Prodigio'.
	self assert: (portfolio structureReport at: 3) equals: '   El Otro'! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'MO 10/24/2022 15:17:20'!
accountName
	
	accountName ifNil: [ self error: self class accountHasNoName ].
	
	^ accountName! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'MO 10/24/2022 15:50:46'!
initializeNamed: aName 

	accountName := aName asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'MO 10/24/2022 15:01:16'!
named: aName 

	^self new initializeNamed: aName! !


!Account class methodsFor: 'error messages' stamp: 'MO 10/24/2022 15:14:31'!
accountHasNoName
	
	^ 'No se puede obtener el nombre de la cuenta porque no tiene'! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'MO 10/23/2022 23:33:39'!
accountSummary
	
	|summary |
	
	summary := self collectTransactions.
	
	summary add: 'Balance = ', (self balance) asString, '.'.
	
	^ summary! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/23/2022 23:54:17'!
collectTransactions
	
	| currentSummary |
	
	currentSummary := OrderedCollection new.
	
	accounts do: [ :anAccount | currentSummary addAll: (anAccount collectTransactions) ].
	
	^ currentSummary! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/24/2022 00:08:22'!
collectTransfers
	
	^ accounts sum: [ :anAccount | anAccount collectTransfers ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/24/2022 15:51:24'!
indentar: anAccountNamesCollection

	anAccountNamesCollection collect: [ :aName | '   ' asString , aName]! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/24/2022 00:07:22'!
netTransferReport
	
	^ 'De reporte de neto de transferencias de ', self collectTransfers asString, '.'! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/24/2022 15:55:13'!
structureReport
	
	^ self treeStructureWithIndent: 0! !

!Portfolio methodsFor: 'reports' stamp: 'MO 10/24/2022 15:54:22'!
treeStructureWithIndent: indentCount

	| result accName |

	result := OrderedCollection new.
	
	accName := ''.
	
	indentCount timesRepeat: [ accName := accName , '   ' ].
	
	accName := accName , accountName.
	
	result add: accName.
	
	accounts do: [ :account | result addAll: (account treeStructureWithIndent: (indentCount + 1)) ].
	
	^result! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'MO 10/24/2022 15:03:18'!
named: aName with: anAccount

	^ self new initializeNamed: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MO 10/24/2022 15:04:02'!
named: aName with: anAccount with: anotherAccount

	^ self new initializeNamed: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MO 10/23/2022 23:05:41'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MO 10/21/2022 15:51:10'!
balance

	^ transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance forAccount: self ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'MO 10/23/2022 23:27:48'!
accountSummary
	
	|summary |
	
	summary := self collectTransactions.
	
	summary add: 'Balance = ', (self balance) asString, '.'.
	
	^ summary.
	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MO 10/23/2022 23:28:45'!
collectTransactions
	
	|summary |
	
	summary := OrderedCollection new.
	
	transactions do: [:aTransaction | summary add: (aTransaction asStringForAccount: self)].
	
	^ summary.
	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MO 10/24/2022 00:06:09'!
collectTransfers
	
	^ transactions
		inject: 0
		into: [ :currentNetTransfer :aTransaction | aTransaction affectNetTransfer: currentNetTransfer forAccount: self ].! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MO 10/24/2022 00:05:26'!
netTransferReport
	
	^ 'De reporte de neto de transferencias de ', self collectTransfers asString, '.'! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'MO 10/24/2022 15:54:40'!
treeStructureWithIndent: indentCount

	| result |
	
	result := ''.
	
	indentCount timesRepeat: [ result := result , '   ' ].
	
	result := result , accountName.
	
	^(OrderedCollection with: result)! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'MO 10/21/2022 16:08:01'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'MO 10/21/2022 16:05:46'!
affectBalance: aBalance forAccount: anAccount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'MO 10/21/2022 16:09:45'!
asString

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MO 10/20/2022 21:47:43'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MO 10/23/2022 22:08:57'!
asStringForAccount: anAccount

	^ 'Deposito por ', value asString, '.'. ! !


!Deposit methodsFor: 'balance' stamp: 'MO 10/21/2022 15:47:10'!
affectBalance: aBalance forAccount: anAccount

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'MO 10/23/2022 22:44:35'!
affectNetTransfer: aNetTransfer forAccount: anAccount 
	
	^ aNetTransfer! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'senderAccount receiverAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'MO 10/21/2022 15:30:01'!
initializeForValue: aValue forSender: aSenderAccount forReceiver: aReceiverAccount

	value := aValue.
	senderAccount  := aSenderAccount.
	receiverAccount := aReceiverAccount! !


!Transfer methodsFor: 'balance' stamp: 'MO 10/21/2022 15:49:49'!
affectBalance: aBalance forAccount: anAccount

	(anAccount = senderAccount)   ifTrue: [^ aBalance - value].
	(anAccount = receiverAccount) ifTrue: [^ aBalance + value].
	^ 0! !

!Transfer methodsFor: 'balance' stamp: 'MO 10/23/2022 22:47:26'!
affectNetTransfer: aNetTransfer forAccount: anAccount 

	^ self affectBalance: aNetTransfer forAccount: anAccount! !


!Transfer methodsFor: 'printing' stamp: 'MO 10/23/2022 22:13:04'!
asStringForAccount: anAccount

	(anAccount = senderAccount)   ifTrue: [^ 'Salida por transferencia de ', value asString , '.'.].
	(anAccount = receiverAccount) ifTrue: [^ 'Entrada por transferencia de ', value asString , '.'.].
	
	^ 'Cuenta no conocida'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MO 10/21/2022 15:56:52'!
register: aValue from: aSenderAccount to: aReceiverAccount

	| transaction |
	
	transaction := self new 	initializeForValue: aValue forSender: aSenderAccount forReceiver: aReceiverAccount.
	
	aSenderAccount register: transaction.
	aReceiverAccount register: transaction.
	
	^ transaction! !


!Transfer class methodsFor: 'error messages' stamp: 'MO 10/17/2022 22:02:32'!
canNotTransferToItselfErrorMessage

	^ 'no maquina, como te vas a transferir a vos mismo, estas re loco'! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MO 10/23/2022 22:09:31'!
asStringForAccount: anAccount

	^ 'Extraccion por ', value asString , '.'! !


!Withdraw methodsFor: 'balance' stamp: 'MO 10/21/2022 15:51:51'!
affectBalance: aBalance forAccount: anAccount
	
	^ aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'MO 10/23/2022 22:44:52'!
affectNetTransfer: aNetTransfer forAccount: anAccount 
	
	^ aNetTransfer! !

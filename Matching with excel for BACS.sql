-- HEADER DETAILS
	'AUTOABSORBSTART' --AUTO_START_LINE
	'APPLICATION=HTBPAYS' --APPLICATION_LINE
	'ADATASTART' --DATA_START_LINE


-- DATA RECORDS
	 BankSortCode as Destination_Sort_Code -- 6 chars, 1- 6 position
	,BankAccountNumber as Destination_Account_Number --  8 chars, 7 - 14 position
	,'0' as Destination_Account_Type -- fixed value 1 char, 15-15 position
	,'99' as Transaction_Code --  fixed value 2 char, 16- 17 position
	,'608997' as Orginating_Sort_Code -- NSANDI sort code 6 chars, 19-23 position
	,'10029575' as Orginating_Account_Number -- NSANDI account number 8 chars, 24-31 position
	,'0000' as Numeric_Reference_Not_Validated -- 4 chars, 32 - 35 position
	,BonusAmount as Amount_of_Payment_in_Pence --  padded amount in pence no decimal (.) 11 char, 36 - 46 position
	,BonusOrderNo as Service_User_Name -- 18 chars, 47 - 64 position
	,PaymentReference as Service_User_Reference -- 18 char, 65 - 82 position
	,BankAccountName as Destination_Account_Name -- 18 char, 83 - 100 position
	-- Now require to put today's date
	,getdate() as Processing_Date -- bYYDDD year then julian date, 101 - 106 position

-- THE CONTRA RECORD
	'608997' as NSANDI_DESITNATION_SORT_CODE -- DESTINATION_SORT_CODE, 1 - 6 position
	,'10029575' as NSANDI_DESTINATION_ACC -- DESTINAATION_ACC, 7 - 14 position
	,'0' as NSANDI_DESTIATNION_ACC_TYPE -- 15-15 position
	,'17' as NSANDI_TRANSACTION_CODE -- 17 TO ALLOW FOR CREDITS, 16 - 17 position
	,'608997' as NSANDI_ORIGINATING_SORT_CODE -- DESTINATION_SORT_CODE, 18 - 23 position
	,'10029575' as NSANDI_ORIGINATING_ACC -- DESTINAATION_ACC, 24 - 31 position
	,'0000' as FREE_FORMAT -- 32 - 35 position
	, sum (BonusAmount) as sum_Amount_of_Payment_in_Pence -- 36 - 46 position
	,'NS HTB PAYMENT' as  NARRATIVE -- 47 - 64 position
	,'CONTRA' as  CONTRA -- 65 - 82 position
	,'HTB' as ABBR_ORIGINATING_ACC_NAME -- 83 - 100 position

-- TRAILER
'ADATAEND' --DATA_END_LINE
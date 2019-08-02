GO

-- create rep data 
SELECT DISTINCT REP_MONTH
into REP_DATA
FROM [dbo].[MGS_EUR_DYN] MED

-- pop temp table TEMP_MGS_DYN_ACCOUNT approx time on dev 2 mins. will increase as we get more data. 
SELECT CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN md.[FILEID]  end fileid
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN md.[Record_type] end record_type
      ,md.[Policy_Number]
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN md.[Rep_Month] ELSE RD.REP_MONTH END rep_month
      ,md.[Amend_Date]
      ,md.[Lender]
      ,md.[Brand]
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Dynamic_Data_Id] END Dynamic_Data_Id
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Current_Balance] END Current_Balance
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Current_Exposure] END Current_Exposure
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Remaining_Term_Months] END Remaining_Term_Months
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[CMS] END CMS
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Paid_In_Month] END Paid_In_Month
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Current_Interest_Rate] END Current_Interest_Rate
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Interest_Rate_Type] END Interest_Rate_Type
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Current_Indexed_Valuation] END Current_Indexed_Valuation
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Current_LTV] END Current_LTV
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Behavioural_PD] END Behavioural_PD
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Behavioural_EAD] END Behavioural_EAD
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Behavioural_LGD] END Behavioural_LGD
      ,md.[Account_Status]
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Collection_Status] END Collection_Status
      ,md.[Redemption_Date] Redemption_Date
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[MIA] END MIA
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Arrears_Balance] END Arrears_Balance
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_repayment_type] END Chg_repayment_type
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_transfer_of_equity] END Chg_transfer_of_equity
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_consent_to_let] END Chg_consent_to_let
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_payment_holiday] END Chg_payment_holiday
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_term_extension] END Chg_term_extension
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_deal_switch] END Chg_deal_switch
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Chg_capitalisation] END Chg_capitalisation
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Default_Date] END Default_Date
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Recovered_After_Claim] END Recovered_After_Claim
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Possession_Date] END Possession_Date
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[MGS_EUR_DYN_GUID] END MGS_EUR_DYN_GUID
      ,md.[Row_Start_Date]
      ,md.[Row_End_Date]
      ,md.[Latest_Indicator]
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN md.[Record_Created] ELSE GETDATE() END Record_Created
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN md.[Record_Updated] ELSE GETDATE() END Record_Updated
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN 0 ELSE 1 END Insert_By_SP
      ,CASE WHEN RD.REP_MONTH = md.Rep_Month  THEN  md.[Rep_Month_Date] ELSE CAST(CONCAT(RD.REP_MONTH,'01') as date ) END Rep_Month_Date
      ,md.[Rep_Month_Date] src_rep_month_date
      ,md.REP_MONTH SRC_REP_MONTH
                ---PREV MONTH VALUES
   ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN PREV_ACC_REP_MONTH  
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) <= CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN md.[Rep_Month_Date]
   END prev_rep_month_date
   ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN PREV_ACC_STATUS
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) <= CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN md.[Account_Status]
   END prev_account_status
   ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Current_Balance
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Current_Balance
   END Prev_Current_Balance
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Indexed_Valuation
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Current_Indexed_Valuation
   END Prev_Indexed_Valuation
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_LTV
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Current_LTV
   END Prev_LTV
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Remaining_Term
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Remaining_Term_Months
   END Prev_Remaining_Term
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_CMS
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN CMS
   END Prev_CMS
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_PAID
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Paid_In_Month
   END Prev_PAID
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Arrears_Balance
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Arrears_Balance
   END Prev_Arrears_Balance
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_MIA
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN MIA
   END Prev_MIA
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Interest_Rate
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Current_Interest_Rate
   END Prev_Interest_Rate
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Interest_Rate_Type
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Interest_Rate_Type
   END Prev_Interest_Rate_Type
  ,CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) = CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_Behavioural_PD
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) = CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN Behavioural_PD
   END Prev_Behavioural_PD,
   CASE WHEN DATEADD(month,1,PREV_ACC_REP_MONTH) <= CAST(CONCAT(RD.REP_MONTH,'01') as date ) 
                  AND md.REP_MONTH_DATE = CAST(CONCAT(RD.REP_MONTH,'01') as date)
        THEN Prev_MIA
        WHEN DATEADD(month,1,md.REP_MONTH_DATE) <= CAST(CONCAT(RD.REP_MONTH,'01') as date )
        THEN MIA
   END last_valid_mia
into TEMP_MGS_DYN_ACCOUNT
FROM (
SELECT ATP.Account_Number,
       -- current month values --
       MED.*
          -- previous month values --
          ,LAG(MED.Current_Balance) over (partition by MED.policy_number order by MED.rep_month) Prev_Current_Balance
          ,LAG(MED.[Current_Indexed_Valuation]) over (partition by  MED.policy_number order by MED.rep_month) Prev_Indexed_Valuation
          ,LAG(MED.[Current_LTV]) over (partition by MED.policy_number order by MED.rep_month) Prev_LTV
          ,LAG(MED.[Remaining_Term_Months]) over (partition by  MED.policy_number order by MED.rep_month) Prev_Remaining_Term
          ,LAG(MED.account_status) over (partition by MED.policy_number order by MED.rep_month) PREV_ACC_STATUS
          ,LAG(MED.[CMS] ) over (partition by MED.policy_number order by MED.rep_month) Prev_CMS
          ,LAG(MED.[Paid_In_Month] ) over (partition by MED.policy_number order by MED.rep_month) Prev_PAID
          ,LAG(MED.[Arrears_Balance] ) over (partition by MED.policy_number order by MED.rep_month) Prev_Arrears_Balance
          ,LAG(MED.MIA) over (partition by MED.policy_number order by MED.rep_month) Prev_MIA
          ,LAG(MED.[Current_Interest_Rate]) over (partition by MED.policy_number order by MED.rep_month) Prev_Interest_Rate
           ,LAG(MED.[Interest_Rate_Type]) over (partition by MED.policy_number order by MED.rep_month) Prev_Interest_Rate_Type
           ,LAG(MED.Behavioural_PD) over (partition by MED.policy_number order by MED.rep_month) Prev_Behavioural_PD
       --- join and decision data required
        ,CAST(CONCAT(MED.REP_MONTH,'01') as date ) rep_month_date,   
          LEAD(MED.account_status) over (partition by MED.policy_number order by MED.rep_month) NEXT_ACC_STATUS, 
          CAST(CONCAT(ISNULL((LEAD(MED.rep_month) over (partition by MED.policy_number order by MED.rep_month)),'205001'),'01')  as date ) NEXT_ACC_REP_MONTH,
          CAST(CONCAT(ISNULL((LAG(MED.rep_month) over (partition by MED.policy_number order by MED.rep_month)),MED.rep_month),'01')  as date ) PREV_ACC_REP_MONTH
FROM [dbo].[MGS_EUR_DYN]  MED 
JOIN [dbo].[MGS_ACCOUNT_TO_POLICY] ATP
ON ATP.Policy_Number = MED.Policy_Number
WHERE med.Latest_Indicator = 1 
) md
JOIN REP_DATA RD
  ON CAST(CONCAT(RD.REP_MONTH,'01') as date ) = rep_month_date
  OR(--will create months where there is a gap between this month and the next. 
      CAST(CONCAT(RD.REP_MONTH,'01') as date ) < NEXT_ACC_REP_MONTH
       AND  CAST(CONCAT(RD.REP_MONTH,'01') as date ) > rep_month_date)

-- empty the mgs_dyn_account
-- not really needed by there. 
       DELETE 
       from [dbo].[MGS_DYN_ACCOUNT]

-- perform insert. 
INSERT INTO [dbo].[MGS_DYN_ACCOUNT]
           ([fileid]
      ,[record_type]
      ,[Policy_Number]
      ,[rep_month]
      ,[Amend_Date]
      ,[Lender]
      ,[Brand]
      ,[Dynamic_Data_Id]
      ,[Current_Balance]
      ,[Current_Exposure]
      ,[Remaining_Term_Months]
      ,[CMS]
      ,[Paid_In_Month]
      ,[Current_Interest_Rate]
      ,[Interest_Rate_Type]
      ,[Current_Indexed_Valuation]
      ,[Current_LTV]
      ,[Behavioural_PD]
      ,[Behavioural_EAD]
      ,[Behavioural_LGD]
      ,[Account_Status]
      ,[Collection_Status]
      ,[Redemption_Date]
      ,[MIA]
      ,[Arrears_Balance]
      ,[Chg_repayment_type]
      ,[Chg_transfer_of_equity]
      ,[Chg_consent_to_let]
      ,[Chg_payment_holiday]
      ,[Chg_term_extension]
      ,[Chg_deal_switch]
      ,[Chg_capitalisation]
      ,[Default_Date]
      ,[Recovered_After_Claim]
      ,[Possession_Date]
      ,[MGS_EUR_DYN_GUID]
      ,[Row_Start_Date]
      ,[Row_End_Date]
      ,[Latest_Indicator]
      ,[Record_Created]
      ,[Record_Updated]
      ,[Insert_By_SP]
      ,[Rep_Month_Date]
      ,[src_rep_month_date]
      ,[SRC_REP_MONTH]
      ,[prev_rep_month_date]
      ,[prev_account_status]
      ,[Prev_Current_Balance]
      ,[Prev_Indexed_Valuation]
      ,[Prev_LTV]
      ,[Prev_Remaining_Term]
      ,[Prev_CMS]
      ,[Prev_PAID]
      ,[Prev_Arrears_Balance]
      ,[Prev_MIA]
      ,[Prev_Interest_Rate]
      ,[Prev_Interest_Rate_Type]
      ,[Prev_Behavioural_PD]
                  ,[last_valid_mia]) SELECT [fileid]
      ,[record_type]
      ,[Policy_Number]
      ,[rep_month]
      ,[Amend_Date]
      ,[Lender]
      ,[Brand]
      ,[Dynamic_Data_Id]
      ,[Current_Balance]
      ,[Current_Exposure]
      ,[Remaining_Term_Months]
      ,[CMS]
      ,[Paid_In_Month]
      ,[Current_Interest_Rate]
      ,[Interest_Rate_Type]
      ,[Current_Indexed_Valuation]
      ,[Current_LTV]
      ,[Behavioural_PD]
      ,[Behavioural_EAD]
      ,[Behavioural_LGD]
      ,[Account_Status]
      ,[Collection_Status]
      ,[Redemption_Date]
      ,[MIA]
      ,[Arrears_Balance]
      ,[Chg_repayment_type]
      ,[Chg_transfer_of_equity]
      ,[Chg_consent_to_let]
      ,[Chg_payment_holiday]
      ,[Chg_term_extension]
      ,[Chg_deal_switch]
      ,[Chg_capitalisation]
      ,[Default_Date]
      ,[Recovered_After_Claim]
      ,[Possession_Date]
      ,[MGS_EUR_DYN_GUID]
      ,[Row_Start_Date]
      ,[Row_End_Date]
      ,[Latest_Indicator]
      ,[Record_Created]
      ,[Record_Updated]
      ,[Insert_By_SP]
      ,[Rep_Month_Date]
      ,[src_rep_month_date]
      ,[SRC_REP_MONTH]
      ,[prev_rep_month_date]
      ,[prev_account_status]
      ,[Prev_Current_Balance]
      ,[Prev_Indexed_Valuation]
      ,[Prev_LTV]
      ,[Prev_Remaining_Term]
      ,[Prev_CMS]
      ,[Prev_PAID]
      ,[Prev_Arrears_Balance]
      ,[Prev_MIA]
      ,[Prev_Interest_Rate]
      ,[Prev_Interest_Rate_Type]
      ,[Prev_Behavioural_PD]
                  ,[last_valid_mia]
  FROM [dbo].[TEMP_MGS_DYN_ACCOUNT]
  
  
drop table TEMP_MGS_DYN_ACCOUNT  
drop table  REP_DATA

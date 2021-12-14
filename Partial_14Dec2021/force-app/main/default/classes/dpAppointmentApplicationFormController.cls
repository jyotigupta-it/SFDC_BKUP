public with sharing class dpAppointmentApplicationFormController {
    
    @AuraEnabled 
    public static PassAccountObjectDetails getAccountRecordDetails(String recordId){
        PassAccountObjectDetails passDetails;
        try{
            passDetails = new PassAccountObjectDetails();
            passDetails = getWrapperValue(recordId);
        }catch(Exception e){
            passDetails = new PassAccountObjectDetails();
            System.debug('passDetails-->'+passDetails);
            System.debug('Exception-->'+e.getStackTraceString()+' and '+e.getMessage());
            throw new AuraHandledException('Please contact to your Admin! '+e.getStackTraceString()+' and '+e.getMessage());
        }
        RETURN passDetails;
    }
    
    public static PassAccountObjectDetails getWrapperValue(String recordId){
        
        System.debug('recordId-->'+recordId);
        Account account = new Account();
        if(recordId!=null){
            account = [SELECT id,name,Business_Line__c,Type_of_Partner__c,Contact_Number_Phone__c,Primary_Contact_Person_Name__c,Contact_Number_Mobile__c,Contact_Email__c,
                       BillingAddress,BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry,No_of_Projects_Handled__c,City_for_Distributorship__c,Cluster_for_Distributorship__c,Town_for_Distributorship__c,Town_for_Godown__c,City_for_Godown__c,Pin_Code_for_Godown__c,Constitution_of_Firm__c,City_for_Current_Business__c,Town_for_Current_Business__c,District_for_Current_Business__c,State_for_Current_Business__c,PAN_Number__c,Professional_Tax_Registration_No__c,Shop_Establishment_Regn_No__c,Is_Your_Company_Account_Audited__c,Name_of_Auditor__c,Address_of_Auditer__c,VAT_CST_Number__c,gst_legal__c FROM Account WHERE id=:recordId];
        }
        
        Schema.sObjectType objType = Account.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > values = fieldMap.get('Business_Line__c').getDescribe().getPickListValues();
        list<String> businessLineValues = new list<String>();
        for (Schema.PicklistEntry a: values) {
            businessLineValues.add(a.getValue());
        }
        businessLineValues.sort();
        list < Schema.PicklistEntry > partyType = fieldMap.get('Type_of_Partner__c').getDescribe().getPickListValues();
        list<String> partyTypeValues = new list<String>();
        for (Schema.PicklistEntry a: partyType) {
            partyTypeValues.add(a.getValue());
        }
        partyTypeValues.sort();
        
        //get Map of RecordType Name and Id
        Map<String,Id> mapofpartnerDetailRecordTypeNameandId = new Map<String,Id>();
        mapofpartnerDetailRecordTypeNameandId = passMapOf_RecordTypeNameandId('Partner_Detail__c');
        mapofpartnerDetailRecordTypeNameandId.putAll(new map<String,Id>(passMapOf_RecordTypeNameandId('Contact'))); 
        mapofpartnerDetailRecordTypeNameandId.putAll(new map<String,Id>(passMapOf_RecordTypeNameandId('DP_Detail__c')));
        mapofpartnerDetailRecordTypeNameandId.putAll(new map<String,Id>(passMapOf_RecordTypeNameandId('Bank_Details__c')));
        mapofpartnerDetailRecordTypeNameandId.putAll(new map<String,Id>(passMapOf_RecordTypeNameandId('Sales_Projection__c')));
        mapofpartnerDetailRecordTypeNameandId.putAll(new map<String,Id>(passMapOf_RecordTypeNameandId('DP_SAP_Foreign_Key__c')));
        
        
        PassAccountObjectDetails passDetails = new PassAccountObjectDetails();
        if(recordId!=null){
            System.debug('account.VAT_CST_Number__c'+account.VAT_CST_Number__c);
            if((account.VAT_CST_Number__c!=null)){
                passDetails.getGSTValidated = true;
            }else{
                passDetails.getGSTValidated = false;
            }
            
            passDetails.accountRef = account;
            
            list<Partner_Detail__c> listPartnerDetailsObject = new list<Partner_Detail__c>();
            Id distributionPartnerRecordTypeId = recordTypeIDbyName('Partner_Detail__c','Distribution Partner');
            listPartnerDetailsObject = [SELECT Id,name,District__c,No_of_Dealers__c FROM Partner_Detail__c WHERE Distributor__c =:recordId AND RecordTypeId=:distributionPartnerRecordTypeId WITH SECURITY_ENFORCED];
            
            list<Partner_Detail__c> listProjectPartnerDetailsObject = new list<Partner_Detail__c>();
            Id projectPartnerRecordTypeId = recordTypeIDbyName('Partner_Detail__c','Project Partner');
            listProjectPartnerDetailsObject = [SELECT Id,name,Name_of_the_Project_Handled__c,Value__c FROM Partner_Detail__c WHERE Distributor__c =:recordId AND RecordTypeId=:projectPartnerRecordTypeId WITH SECURITY_ENFORCED];
            
            list<Contact> listProprietorPartnersDirector = new list<Contact>();
            Id proprietorPartnersDirectorRecordTypeId = recordTypeIDbyName('Contact','Proprietor Details');
            listProprietorPartnersDirector = [SELECT Id,Name,Salutation,FirstName,LastName,Contact_Type__c,Age__c,Education_Qualification__c,MailingStreet,MailingCity,MailingCountry,MailingState,MailingPostalCode FROM Contact WHERE AccountId=:recordId AND RecordTypeId=:proprietorPartnersDirectorRecordTypeId WITH SECURITY_ENFORCED];
            
            list<Business_Activity_History__c> listBusinessActivityAndHistory = new list<Business_Activity_History__c>();
            listBusinessActivityAndHistory = [SELECT ID,name,Product_Category__c,Type__c,Dealing_Since_When__c,Average_Annual_Turn_Over__c,Projected_Sales_In_Lacs__c FROM Business_Activity_History__c WHERE Distributor__c=:recordId WITH SECURITY_ENFORCED];
            
            list<DP_Detail__c> totalTurnOver = new list<DP_Detail__c>();
            Id totalTurnOverRecordTypeId = recordTypeIDbyName('DP_Detail__c','Turnover Details');
            totalTurnOver = [SELECT Id,name,Year_1__c,Year_2__c,Year_3__c FROM DP_Detail__c WHERE Distributor__c=:recordId AND RecordTypeId=:totalTurnOverRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<Partner_Detail__c> listSisterConcerns = new list<Partner_Detail__c>();
            Id sisterConcernsRecordTypeId = recordTypeIDbyName('Partner_Detail__c','Sister Concern');
            listSisterConcerns = [SELECT Id,name,Name__c,Year_1__c,Year_2__c,Year_3__c FROM Partner_Detail__c WHERE Distributor__c=:recordId AND RecordTypeId=:SisterConcernsRecordTypeId WITH SECURITY_ENFORCED];
            
            list<DP_Detail__c> businessAreaAndStaffDetails = new list<DP_Detail__c>();
            Id businessAreaAndStaffDetailsRecordTypeId = recordTypeIDbyName('DP_Detail__c','Staff Details');
            businessAreaAndStaffDetails = [SELECT Id,name,Managerial__c,Sales__c,Administrative__c,Network_Details_Total_number_of_Dealer__c,Present_Shop_Showroom_Area_in_Sq__c,Godown_Space_Area_In_Sq_Ft__c FROM DP_Detail__c WHERE Distributor__c=:recordId AND RecordTypeId=:businessAreaAndStaffDetailsRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<Bank_Details__c> financialDetail = new list<Bank_Details__c>();
            Id financialDetailRecordTypeId = recordTypeIDbyName('Bank_Details__c','Financial Details');
            financialDetail = [SELECT Id,name,Name_of_your_Bank__c,Full_Address_of_the_Bank_with_Pin_Code__c,LandLine__c,Mobile_Number__c,Bank_Account_Number__c,Date_on_Which_this_Account_was_Opened__c FROM Bank_Details__c WHERE Distributor__c=:recordId AND RecordTypeId=:financialDetailRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<Bank_Details__c> loanDetails = new list<Bank_Details__c>();
            Id loanDetailsRecordTypeId = recordTypeIDbyName('Bank_Details__c','Loan Details');
            loanDetails = [SELECT Id,name,Type_of_Loan__c,Amount__c,Security_Provided__c FROM Bank_Details__c WHERE Distributor__c=:recordId AND RecordTypeId=:loanDetailsRecordTypeId WITH SECURITY_ENFORCED];
            
            list<DP_Detail__c> businessProposalQuestions = new list<DP_Detail__c>();
            Id businessProposalQuestionsRecordTypeId = recordTypeIDbyName('DP_Detail__c','Business Proposal Questionaries');
            businessProposalQuestions = [SELECT Id,name,In_your_showroom_how_much_space_you_can__c,Size_of_Dedicated_Godown_for_Ashirvad__c,Sales_Staff_You_Can_Allocate_to_Ashirvad__c,Working_Capital__c,Can_You_Increase_the_Capital__c,Can_you_Provide_Bank_Gu__c,Billing_Software_Using__c,No_Objection_in_using_Secondary_Software__c,Proposed_date_to_start_with_Ashirvad__c FROM DP_Detail__c WHERE Distributor__c=:recordId AND RecordTypeId=:businessProposalQuestionsRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<Sales_Projection__c> billingCommitmentSales = new list<Sales_Projection__c>();
            Id billingCommitmentSalesRecordTypeId = recordTypeIDbyName('sales_Projection__c','Billing Commitment');
            billingCommitmentSales = [SELECT Id,name,Month_1_Rs_in_Lac__c,Month_2_Rs_In_Lacks__c,Month_3_Rs_In_Lacks__c,Month_4_Rs_In_Lacks__c,Month_5_Rs_In_Lacks__c,Month_6_Rs_In_Lacks__c FROM sales_Projection__c WHERE Distributer__c=:recordId AND RecordTypeId=:billingCommitmentSalesRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<Sales_Projection__c> dealerNetworkAdditionSales = new list<Sales_Projection__c>();
            Id dealerNetworkAdditionSalesRecordTypeId = recordTypeIDbyName('sales_Projection__c','Dealer Network Addition');
            dealerNetworkAdditionSales = [SELECT Id,name,Dealer_Network_Addition__c,Dealer_Network_Addition_2__c,Dealer_Network_Addition_3__c,Dealer_Network_Addition_4__c,Dealer_Network_Addition_5__c,Dealer_Network_Addition_6__c FROM sales_Projection__c WHERE Distributer__c=:recordId AND RecordTypeId=:dealerNetworkAdditionSalesRecordTypeId WITH SECURITY_ENFORCED ORDER BY ID DESC LIMIT 1];
            
            list<sales_Projection__c> salesProjectionInstance = new list<sales_Projection__c>();
            Id salesProjectionInstanceRecordTypeId = recordTypeIDbyName('sales_Projection__c','Sales Projection');
            salesProjectionInstance = [SELECT Id,name,Product_Type__c,X1st_Year__c,X2nd_Year__c,X3rd_Year__c FROM sales_Projection__c WHERE Distributer__c=:recordId AND RecordTypeId=:salesProjectionInstanceRecordTypeId WITH SECURITY_ENFORCED];
            
            list<Contact> detailsOfSelfandFamily = new list<Contact>();
            Id detailsOfSelfandFamilyRecordTypeId = recordTypeIDbyName('Contact','Data of Self and Family Deatails');
            detailsOfSelfandFamily = [SELECT Id,name,Salutation,FirstName,LastName,RelationShip__c,Education_Qualification__c,Birthdate,Date_of_Marriage__c FROM Contact WHERE AccountID=:recordId AND RecordTypeId=:detailsOfSelfandFamilyRecordTypeId WITH SECURITY_ENFORCED];
            
            //DP SAP Foreign Key Masters
            List<DP_SAP_Foreign_Key__c> listAccountAssignmentGroup = new List<DP_SAP_Foreign_Key__c>();
            Id listAccountAssignmentGroupRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Account Assignment Group');
            listAccountAssignmentGroup = [SELECT ID,Name,Account_Assignment_Group__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listAccountAssignmentGroupRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listCreditControlArea = new List<DP_SAP_Foreign_Key__c>();
            Id listCreditControlAreaRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Credit Control Area');
            listCreditControlArea = [SELECT ID,Name,Credit_Control_Area__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listCreditControlAreaRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listCusGroup = new List<DP_SAP_Foreign_Key__c>();
            Id listCusGroupRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Cus Group');
            listCusGroup = [SELECT ID,Name,Cus_Group__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listCusGroupRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listCusPricingProcedure = new List<DP_SAP_Foreign_Key__c>();
            Id listCusPricingProcedureRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Cus Pricing Procedure');
            listCusPricingProcedure = [SELECT ID,Name,Cus_Pricing_Procedure__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listCusPricingProcedureRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listDeliveringPlant = new List<DP_SAP_Foreign_Key__c>();
            Id listDeliveringPlantRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Delivering Plant');
            listDeliveringPlant = [SELECT ID,Name,Delivering_Plant__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listDeliveringPlantRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listDeliveryPriority = new List<DP_SAP_Foreign_Key__c>();
            Id listDeliveryPriorityRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Delivery Priority');
            listDeliveryPriority = [SELECT ID,Name,Delivery_Priority__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listDeliveryPriorityRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listDistributorChannel = new List<DP_SAP_Foreign_Key__c>();
            Id listDistributorChannelRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Distributor Channel');
            listDistributorChannel = [SELECT ID,Name,Distributor_Channel__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listDistributorChannelRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listDivison = new List<DP_SAP_Foreign_Key__c>();
            Id listDivisonRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Division');
            listDivison = [SELECT ID,Name,Division__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listDivisonRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listIncoterms = new List<DP_SAP_Foreign_Key__c>();
            Id listIncotermsRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Incoterms');
            listIncoterms = [SELECT ID,Name,Incoterms__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listIncotermsRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listPaymentTerms = new List<DP_SAP_Foreign_Key__c>();
            Id listPaymentTermsRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Payment Terms');
            listPaymentTerms = [SELECT ID,Name,Payment_Terms__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listPaymentTermsRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listPriceGroup = new List<DP_SAP_Foreign_Key__c>();
            Id listPriceGroupRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Price Group');
            listPriceGroup = [SELECT ID,Name,Price_Group__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listPriceGroupRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listSalesGroup = new List<DP_SAP_Foreign_Key__c>();
            Id listSalesGroupRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Sales Group');
            listSalesGroup = [SELECT ID,Name,Sales_Group__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listSalesGroupRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listSalesOffice = new List<DP_SAP_Foreign_Key__c>();
            Id listSalesOfficeRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Sales Office');
            listSalesOffice = [SELECT ID,Name,Sales_Office__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listSalesOfficeRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listSalesOrg = new List<DP_SAP_Foreign_Key__c>();
            Id listSalesOrgRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Sales Organization');
            listSalesOrg = [SELECT ID,Name,Sales_Organization__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listSalesOrgRecordTypeId WITH SECURITY_ENFORCED];

            List<DP_SAP_Foreign_Key__c> listSalesCondition = new List<DP_SAP_Foreign_Key__c>();
            Id listSalesConditionRecordTypeId = recordTypeIDbyName('DP_SAP_Foreign_Key__c','Shipping Condition');
            listSalesCondition = [SELECT ID,Name,Shipping_Condition__c FROM DP_SAP_Foreign_Key__c WHERE Distributor__c=:recordId AND  RecordTypeId=:listSalesConditionRecordTypeId WITH SECURITY_ENFORCED];
            
            passDetails.listPartnerDetailsObject = listPartnerDetailsObject;
            passDetails.listProjectPartnerDetailsObject = listProjectPartnerDetailsObject;
            passDetails.listProprietorPartnersDirector = listProprietorPartnersDirector;
            passDetails.listBusinessActivityAndHistory = listBusinessActivityAndHistory;
            passDetails.totalTurnOver = totalTurnOver;
            passDetails.listSisterConcerns = listSisterConcerns;
            passDetails.businessAreaAndStaffDetails = businessAreaAndStaffDetails;
            passDetails.financialDetail = financialDetail;
            passDetails.loanDetails = loanDetails;
            passDetails.businessProposalQuestions = businessProposalQuestions;
            //passDetails.upload_One_passport_Size = 
            //passDetails.copyOfPanCard = 
            //passDetails.copyOfSalesTax = 
            //passDetails.copyOfShopLicense = 
            //passDetails.fourPhotographOfEstablishment = 
            //passDetails.copyOfLasttwoYearsAudited = 
            //passDetails.copyOfLastTwoYearsIncome = 
            //passDetails.lastOneYearBank = 
            //passDetails.visitingCard = 
            //passDetails.securityCheques = 
            passDetails.billingCommitmentSales = billingCommitmentSales;
            passDetails.dealerNetworkAdditionSales = dealerNetworkAdditionSales;
            passDetails.salesProjectionInstance = salesProjectionInstance;
            passDetails.detailsOfSelfandFamily = detailsOfSelfandFamily;

            //Check if user is from SAP Team
            
            //user loggedinUser = [SELECT Id,Name,Profile.Name FROM User WHERE Id=:Userinfo.getUserId() WITH SECURITY_ENFORCED];

            passDetails.sapTeamUser = true;
            passDetails.listAccountAssignmentGroup = listAccountAssignmentGroup;
            passDetails.listCreditControlArea = listCreditControlArea;
            passDetails.listCusGroup = listCusGroup;
            passDetails.listCusPricingProcedure = listCusPricingProcedure;
            passDetails.listDeliveringPlant = listDeliveringPlant;
            passDetails.listDeliveryPriority =listDeliveryPriority;
            passDetails.listDistributorChannel =listDistributorChannel;
            passDetails.listDivison = listDivison;
            passDetails.listIncoterms = listIncoterms;
            passDetails.listPaymentTerms = listPaymentTerms;
            passDetails.listPriceGroup = listPriceGroup;
            passDetails.listSalesGroup = listSalesGroup;
            passDetails.listSalesOffice = listSalesOffice;
            passDetails.listSalesOrg = listSalesOrg;
            passDetails.listSalesCondition = listSalesCondition;
            
        }
        
        passDetails.businessLineOptions = businessLineValues;
        passDetails.partnerTypeOptions = partyTypeValues;
        passDetails.map_RecordTypesAndName = mapofpartnerDetailRecordTypeNameandId;
        list<String> deleteRecords = new list<String>();
        passDetails.recordsToDelete = deleteRecords;
        
        
        
        RETURN passDetails;
    }
    
    public static Id recordTypeIDbyName(String objAPIName, String recordTypeName){
        
        Id devRecordTypeId = Schema.getGlobalDescribe().get(objAPIName).getDescribe().getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
        
        RETURN devRecordTypeId;
    }
    
    public static Map<String,Id> passMapOf_RecordTypeNameandId(String SObjectName){
        Map<String,Id> mapofRecordTypeNameandId = new Map<String,Id>();
        Schema.DescribeSObjectResult partnerDetail_SObjectResult = Schema.getGlobalDescribe().get(SObjectName).getDescribe();
        List<Schema.RecordTypeInfo> recordTypeInfo = partnerDetail_SObjectResult.getRecordTypeInfos();
        for(Schema.RecordTypeInfo info : recordTypeInfo){
            if(info.getName()!='Master'){
                mapofRecordTypeNameandId.put(info.getName(),info.getRecordTypeId());
            }
        }
        RETURN mapofRecordTypeNameandId;
    }
    
    @AuraEnabled
    public static ValidateGSTWrapper validateGST(String recordId, String gstNumber){
        ValidateGSTWrapper wrapper = new ValidateGSTWrapper();
        wrapper.gststatusWithPortal = false;
        try {
            System.debug('recordID-->'+recordId);
            System.debug('gstNumber-->'+gstNumber);
            
            list<Account> checkAllSameGSTAccounts = new List<Account>();
            checkAllSameGSTAccounts = [SELECT Id,Name FROM Account WHERE ID!=:recordId AND VAT_CST_Number__c=:gstNumber WITH SECURITY_ENFORCED];
            
            if(checkAllSameGSTAccounts.size()>0){
                throw new AuraHandledException('GST already present in Salesforce. Kindly use the existing record or merge the record.');
            }else{
                REST_API_Configuration__mdt restSetup = [SELECT Authentication_Key__c, Authentication_Value__c, Content_Type__c,
                                                         End_Point_URL__c, Request_Type__c 
                                                         FROM REST_API_Configuration__mdt WHERE DeveloperName ='GSTIN_API'];
                System.debug('meta-->'+restSetup);
                String authurl = String.format(restSetup.End_Point_URL__c, new List<String>{ gstNumber });
                system.debug('authurl1 '+authurl);            
                
                HttpRequest request = new HttpRequest();
                Http http = new Http();
                request.setEndpoint(authurl);
                request.setMethod(restSetup.Request_Type__c);
                request.setHeader('Content-Type', restSetup.Content_Type__c);
                request.setHeader(restSetup.Authentication_Key__c, restSetup.Authentication_Value__c);
                HttpResponse httpResponse = http.send(request);
                system.debug('Status Code == '+ httpResponse.getStatusCode());
                system.debug('Response Status == '+ httpResponse.getStatus());
                system.debug('Raw Response ------>>'+httpResponse.getBody());
                
                if (httpResponse.getStatusCode() == 200) {
                    //Formatting response JSON
                    GSTINValidatorParser wrapObj = GSTINValidatorParser.parse(httpResponse.getBody());
                    system.debug('wrapObj: Order ------>>'+wrapObj);
                    
                    if(wrapObj.status_code == 0){
                        throw new AuraHandledException(wrapObj.error);
                    }else if(wrapObj.status_code == 1){
                        CheckGST_SAP_Response  sapresponse = CheckGST_SAP.checkGST(gstNumber);
                        System.debug('sapresponse -- message-->'+sapresponse);

                        if(sapresponse.MT_GSTValidation_Response !=null && sapresponse.MT_GSTValidation_Response.RESPONSE.STATUS_MSG==200){
                            throw new AuraHandledException('SAP ID - '+ sapresponse.MT_GSTValidation_Response.RESPONSE.CREATION_NUM +' for Customer already available in SAP System. Kindly contact the accounts team to create new record.');
                        }else{
                            wrapper.gststatusWithPortal = true;
                        }
                    }
                }
            } 
        }
        catch(AurahandledException e) {
            throw e;
        }
        catch (Exception e) {
            System.debug('Exceptions-->'+e +'and '+e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
        }
        System.debug(wrapper);
        RETURN wrapper;
    }
    
    public class ValidateGSTWrapper{
        @AuraEnabled
        public Boolean gststatusWithPortal{get;set;}
    }
    
    @AuraEnabled
    public static string saveData(string recordId, PassAccountObjectDetails wrapperToUPSERT){
        //try {
            System.debug(wrapperToUPSERT);
            System.debug(wrapperToUPSERT.recordsToDelete);
            list<String> recordIds = new list<String>();
            for(String getVal:wrapperToUPSERT.recordsToDelete){
                if(getVal!=null){
                    recordIds.add(getVal);
                }
            }
            if(recordIds.size()>0){
                database.delete(recordIds, false);
            }


            Account acc = new Account();
            acc = wrapperToUPSERT.accountRef;

            CustomerCreation_SAP_Request wrapperUpdate = new CustomerCreation_SAP_Request();
            CustomerCreation_SAP_Request.Request_Class wrapper = new CustomerCreation_SAP_Request.Request_Class();
            wrapper.PARTNER_ROLE = 'ZCUS'; //Default
            wrapper.CREATION_GRO = 'ZCUS'; //Default
            wrapper.TITLE_MEDI = '0003'; //Default
            //String name = acc.Name;
            String name = 'City limited to 40 charectors --- Same value will be pushed in CITY2 as CITY1 state code - foreign Key master';
            if(name.length()>40){
                wrapper.NAME_ORG1 = name.substring(0, 40);
                wrapper.NAME_ORG2 = name.substring(40, 80);
            }else{
                wrapper.NAME_ORG1 = name;
            }
            wrapper.SORT1_TXT = wrapper.NAME_ORG1; // First 40 Caracter of Name
            wrapper.SORT2_TXT = '';
            wrapper.UNW_REMARK = '';
            acc.BillingStreet = '6-H-12 jawaharnagar sriganganagar, Rajasthan (335001), India';
            if(acc.BillingStreet.length()<=60){
                wrapper.STREET = acc.BillingStreet;
            }
            if(acc.BillingStreet.length()>60 && acc.BillingStreet.length()<=120){
                wrapper.STREET = acc.BillingStreet.substring(0, 60);
                wrapper.STR_SUPPL1 = acc.BillingStreet.substring(60, 120);
            }
            if(acc.BillingStreet.length()>120 && acc.BillingStreet.length()<=180){
                wrapper.STREET = acc.BillingStreet.substring(0, 60);
                wrapper.STR_SUPPL1 = acc.BillingStreet.substring(60, 120);
                wrapper.STR_SUPPL2 = acc.BillingStreet.substring(120, 180);
            }if(acc.BillingStreet.length()>180 && acc.BillingStreet.length()<=240){
                wrapper.STREET = acc.BillingStreet.substring(0, 60);
                wrapper.STR_SUPPL1 = acc.BillingStreet.substring(60, 120);
                wrapper.STR_SUPPL2 = acc.BillingStreet.substring(120, 180);
                wrapper.STR_SUPPL3 = acc.BillingStreet.substring(180, 240);
            }
            wrapper.LOCATION = ''; //District limited to 40 Charectors //does not have any specific account field
            wrapper.CITY2 = acc.BillingCity; //City limited to 40 charectors --- Same value will be pushed in CITY2 as CITY1
            wrapper.POST_CODE1 = acc.BillingPostalCode; //Pin code limited to 6 charectors
            wrapper.CITY1 = acc.BillingCity; //City limited to 40 charectors --- Same value will be pushed in CITY2 as CITY1
            wrapper.COUNTRY = 'IN'; //Default
            wrapper.REGION = '29'; //state code - foreign Key master -- We will maintain the codes in State master // we do not have cods for state in sfdc state master
            wrapper.LANGU = 'EN'; //Default
            wrapper.TEL_NUMBER = acc.Contact_Number_Phone__c; //Telephone Number
            wrapper.MOB_NUMBER = acc.Contact_Number_Mobile__c; //Mobile Number
            wrapper.SMTP_ADDR = acc.Contact_Email__c; //Email Address
            wrapper.VALID_FROM = String.valueOf(System.today());
            wrapper.VALID_TO = '31.12.9999';
            wrapper.LOCATION_3 = '0'; //Default
            wrapper.TAXTYPE = 'IN3'; //Default
            wrapper.TAXNUMXL = acc.VAT_CST_Number__c;  //GST Number
            wrapper.BUKRS = 'AA01'; //Default
            wrapper.KNB1_AKONT = '2200001'; //Default
            wrapper.J_1IPANNO = acc.PAN_Number__c; //PAN Number

            list<CustomerCreation_SAP_Request.data> listData = new list<CustomerCreation_SAP_Request.data>();
            Integer maxSizeOfList = 0;
            Integer sizeOfList = 0;
            if(wrapperToUPSERT.listAccountAssignmentGroup.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listAccountAssignmentGroup.size();
            }
            if(wrapperToUPSERT.listCreditControlArea.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listCreditControlArea.size();
            }
            if(wrapperToUPSERT.listCusGroup.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listCusGroup.size();
            }
            if(wrapperToUPSERT.listCusPricingProcedure.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listCusPricingProcedure.size();
            }
            if(wrapperToUPSERT.listDeliveringPlant.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listDeliveringPlant.size();
            }
            if(wrapperToUPSERT.listDeliveryPriority.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listDeliveryPriority.size();
            }
            if(wrapperToUPSERT.listDistributorChannel.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listDistributorChannel.size();
            }
            if(wrapperToUPSERT.listDivison.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listDivison.size();
            }
            if(wrapperToUPSERT.listIncoterms.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listIncoterms.size();
            }
            if(wrapperToUPSERT.listPaymentTerms.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listPaymentTerms.size();
            }
            if(wrapperToUPSERT.listPriceGroup.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listPriceGroup.size();
            }
            if(wrapperToUPSERT.listSalesGroup.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listSalesGroup.size();
            }
            if(wrapperToUPSERT.listSalesOffice.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listSalesOffice.size();
            }
            if(wrapperToUPSERT.listSalesOrg.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listSalesOrg.size();
            }
            if(wrapperToUPSERT.listSalesCondition.size()>maxSizeOfList){
                maxSizeOfList = wrapperToUPSERT.listSalesCondition.size();
            }

            list<Sap_Foreign_Key_Master__c> listAllForeignKeyMasters = new list<Sap_Foreign_Key_Master__c>();
            listAllForeignKeyMasters = [SELECT Id,Name FROM Sap_Foreign_Key_Master__c];

            Map<Id,String> mapOfIdandMaster = new Map<Id,String>();
            for(Sap_Foreign_Key_Master__c sap:listAllForeignKeyMasters){
                mapOfIdandMaster.put(sap.Id,sap.Name);

            }
            for(Integer i=0;i<maxSizeOfList;i++){
                CustomerCreation_SAP_Request.data dataWrapper = new CustomerCreation_SAP_Request.data(); 
                dataWrapper.VKORG = wrapperToUPSERT.listSalesOrg.size() > i && wrapperToUPSERT.listSalesOrg[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listSalesOrg[i].Sales_Organization__c):'AA01';
                dataWrapper.VTWEG = wrapperToUPSERT.listDistributorChannel.size() > i && wrapperToUPSERT.listDistributorChannel[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listDistributorChannel[i].Distributor_Channel__c):'';
                dataWrapper.SPART = wrapperToUPSERT.listDivison.size() > i && wrapperToUPSERT.listDivison[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listDivison[i].Division__c):'';
                dataWrapper.BZIRK = ''; //Sales District - Satet Code Foreign key master
                dataWrapper.KDGRP = wrapperToUPSERT.listCusGroup.size() > i && wrapperToUPSERT.listCusGroup[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listCusGroup[i].Cus_Group__c):'';
                dataWrapper.VKBUR = wrapperToUPSERT.listSalesOffice.size() > i && wrapperToUPSERT.listSalesOffice[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listSalesOffice[i].Sales_Office__c):'';
                dataWrapper.VKGRP = wrapperToUPSERT.listSalesGroup.size() > i && wrapperToUPSERT.listSalesGroup[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listSalesGroup[i].Sales_Group__c):'';
                dataWrapper.DYNP_AWAHR = ''; //No information available
                dataWrapper.KLABC = 'A'; // Default A
                dataWrapper.KNVV_WAERS = 'INR'; // Default INR
                dataWrapper.KURST = ''; //No information available
                dataWrapper.KONDA = wrapperToUPSERT.listPriceGroup.size() > i && wrapperToUPSERT.listPriceGroup[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listPriceGroup[i].Price_Group__c):'';
                dataWrapper.KALKS = wrapperToUPSERT.listCusPricingProcedure.size() > i && wrapperToUPSERT.listCusPricingProcedure[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listCusPricingProcedure[i].Cus_Pricing_Procedure__c):'';
                dataWrapper.LPRIO = wrapperToUPSERT.listDeliveryPriority.size() > i && wrapperToUPSERT.listDeliveryPriority[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listDeliveryPriority[i].Delivery_Priority__c):'';
                dataWrapper.VWERK = wrapperToUPSERT.listDeliveringPlant.size() > i && wrapperToUPSERT.listDeliveringPlant[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listDeliveringPlant[i].Delivering_Plant__c):'';
                dataWrapper.VSBED = wrapperToUPSERT.listSalesCondition.size() > i && wrapperToUPSERT.listSalesCondition[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listSalesCondition[i].Shipping_Condition__c):'';
                dataWrapper.INCO1 = wrapperToUPSERT.listIncoterms.size() > i && wrapperToUPSERT.listIncoterms[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listIncoterms[i].Incoterms__c):'';
                dataWrapper.INCO2_L = ''; //Manual input
                dataWrapper.ZTERM = wrapperToUPSERT.listPaymentTerms.size() > i && wrapperToUPSERT.listPaymentTerms[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listPaymentTerms[i].Payment_Terms__c):'';
                dataWrapper.KKBER = wrapperToUPSERT.listCreditControlArea.size() > i && wrapperToUPSERT.listCreditControlArea[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listCreditControlArea[i].Credit_Control_Area__c):'';
                dataWrapper.KNVV_KTGRD = wrapperToUPSERT.listAccountAssignmentGroup.size() > i && wrapperToUPSERT.listAccountAssignmentGroup[i] != null ? mapOfIdandMaster.get(wrapperToUPSERT.listAccountAssignmentGroup[i].Account_Assignment_Group__c):'';
                dataWrapper.TC_TAXKD = '0'; //default 0
                dataWrapper.TEST_TCS = '0'; //default 0
                dataWrapper.KVGR4 = ''; //Cluster4
                dataWrapper.KVGR5 = ''; //Cluster5

                listData.add(dataWrapper);
            }

            wrapper.data = listData;

            wrapperUpdate.CustomerCreation_SAP = wrapper;
            CustomerCreation_SAP_Response  customerCreation = CustomerCreation_SAP.createCustomer(wrapperUpdate);
            System.debug('response-->'+customerCreation);
        //} catch (Exception e) {
        //    throw new AuraHandledException(e.getMessage());
        //}
        
        RETURN 'SUCCESS';
    }
    
    @AuraEnabled 
    public static void saveDPAppointmentApplicationDetails(String recordId, Account accountObj,list<Partner_Detail__c> listPartnerDetailsObject,
                                                           list<Partner_Detail__c> listProjectPartnerDetailsObject, list<Contact> listProprietorPartnersDirector,
                                                           list<Business_Activity_History__c> listBusinessActivityAndHistory, DP_Detail__c totalTurnOver,
                                                           list<Partner_Detail__c> listSisterConcerns,DP_Detail__c businessAreaAndStaffDetails,
                                                           Bank_Details__c financialDetail, list<Bank_Details__c> loanDetails,
                                                           DP_Detail__c businessProposalQuestions, list<Sales_Projection__c> salesProjectionInstance,
                                                           list<Contact> detailsOfSelfandFamily, boolean upload_One_passport_Size, boolean copyOfPanCard, boolean copyOfSalesTax, boolean copyOfShopLicense, boolean fourPhotographOfEstablishment, boolean copyOfLasttwoYearsAudited, boolean copyOfLastTwoYearsIncome, boolean lastOneYearBank, boolean visitingCard, boolean securityCheques, Sales_Projection__c billingCommitmentSales, Sales_Projection__c dealerNetworkAdditionSales)
    {
        
        try{
            if(recordId==null){
                INSERT accountObj;
            }else{
                UPDATE accountObj;
            }
            if(listPartnerDetailsObject!=null){
                UPSERT listPartnerDetailsObject;
            }
            if(listProjectPartnerDetailsObject!=null){
                UPSERT listProjectPartnerDetailsObject;
            }
            if(listProprietorPartnersDirector!=null){
                list<Contact> listProprietorPartnersDirector_forSave = new list<Contact>();
                for(Contact detail:listProprietorPartnersDirector){
                    if(detail.Salutation !='' && detail.FirstName !='' && detail.LastName !='' && detail.Contact_Type__c !='' ){
                        listProprietorPartnersDirector_forSave.add(detail);
                    }
                }
                if(listProprietorPartnersDirector_forSave.size()>0){
                    UPSERT listProprietorPartnersDirector_forSave;
                }
            }
            if(listBusinessActivityAndHistory!=null){
                list<Business_Activity_History__c> listBusinessActivityAndHistory_forSave = new list<Business_Activity_History__c>();
                for(Business_Activity_History__c BAH:listBusinessActivityAndHistory){
                    if(BAH.Name !='' && BAH.Type__c !='' && BAH.Dealing_Since_When__c !=null && BAH.Average_Annual_Turn_Over__c!=null ){
                        listBusinessActivityAndHistory_forSave.add(BAH);
                    }
                }
                if(listBusinessActivityAndHistory_forSave.size()>0){
                    UPSERT listBusinessActivityAndHistory_forSave;
                }
            }
            if(totalTurnOver!=null){
                UPSERT totalTurnOver;
            }
            if(listSisterConcerns.size()>0){
                UPSERT listSisterConcerns;
            }
            if(businessAreaAndStaffDetails!=null){
                UPSERT businessAreaAndStaffDetails;
            }
            if(financialDetail!=null){
                UPSERT financialDetail;
            }
            if(loanDetails!=null){
                list<Bank_Details__c> loanDetails_forSave = new list<Bank_Details__c>();
                for(Bank_Details__c BD:loanDetails){
                    loanDetails_forSave.add(BD);
                }
                if(loanDetails_forSave.size()>0){
                    UPSERT loanDetails_forSave; 
                }
            }
            if(businessProposalQuestions!=null){
                UPSERT businessProposalQuestions;
            }
            if(billingCommitmentSales!=null){
                UPSERT billingCommitmentSales;
            }
            if(dealerNetworkAdditionSales!=null){
                UPSERT dealerNetworkAdditionSales;
            }
            System.debug('salesProjectionInstance.size()-->'+salesProjectionInstance.size());
            if(salesProjectionInstance.size()>0){
                System.debug('Inside');
                UPSERT salesProjectionInstance;
            }
            if(detailsOfSelfandFamily.size()>0){
                UPSERT detailsOfSelfandFamily;
            }
            if(upload_One_passport_Size==true){
                String subject = 'Upload One Passport Size Photograph For Each Prop / Partner / Director';
                createTask(subject,recordId);
            }
            if(copyOfPanCard==true){
                String subject = 'Copy of Pancard For Each';
                createTask(subject,recordId);
            }
            if(copyOfSalesTax==true){
                String subject = 'Copy of Sales Tax Certificate';
                createTask(subject,recordId);
            }
            if(copyOfShopLicense==true){
                String subject = 'Copy of Shop Licence';
                createTask(subject,recordId);
            }
            if(fourPhotographOfEstablishment==true){
                String subject = 'Four Photograph of Establishment - Front Elevation / Interiors etc.';
                createTask(subject,recordId);
            }
            if(copyOfLasttwoYearsAudited==true){
                String subject = 'Copy of Last 2 Years Audited Financial Statements';
                createTask(subject,recordId);
            }
            if(copyOfLastTwoYearsIncome==true){
                String subject = 'Copy of Last 2 Years Income Tax Assessment Orders';
                createTask(subject,recordId);
            }
            if(lastOneYearBank==true){
                String subject = 'Last 1 Year Bank Statement';
                createTask(subject,recordId);
            }
            if(visitingCard==true){
                String subject = 'Visiting Card';
                createTask(subject,recordId);
            }
            if(securityCheques==true){
                String subject = 'Security Cheques 3 Nos (Bank Name, Cheque Nos and Branch Name)';
                createTask(subject,recordId);
            }
        }
        catch(Exception e){
            System.debug('Exception-->'+e.getStackTraceString()+' and '+e.getMessage());
            throw new AuraHandledException('Please contact to your Admin! '+e.getStackTraceString()+' and '+e.getMessage());
        }
        
    }
    
    public static void createTask(String subjectName,String recordId){
        System.debug('upload_One_passport_Size-222->'+subjectName);
        Task task = new Task();
        task.WhatId = recordId;
        task.Subject = subjectName;
        task.ActivityDate = System.today();
        Insert task;
    }
    
    public class PassAccountObjectDetails{
        @AuraEnabled
        public boolean sapTeamUser{get;set;}
        @AuraEnabled
        public Account accountRef{get;set;}
        @AuraEnabled 
        public list<String> businessLineOptions{get;set;}
        @AuraEnabled 
        public list<String> partnerTypeOptions{get;set;}
        @AuraEnabled
        public Map<String,Id> map_RecordTypesAndName{get;set;}
        @AuraEnabled
        public list<Partner_Detail__c> listPartnerDetailsObject{get;set;}
        @AuraEnabled
        public list<Partner_Detail__c> listProjectPartnerDetailsObject{get;set;}
        @AuraEnabled
        public list<Contact> listProprietorPartnersDirector{get;set;}
        @AuraEnabled
        public list<Business_Activity_History__c> listBusinessActivityAndHistory{get;set;}
        @AuraEnabled
        public list<DP_Detail__c> totalTurnOver{get;set;}
        @AuraEnabled
        public list<Partner_Detail__c> listSisterConcerns{get;set;}
        @AuraEnabled
        public list<DP_Detail__c> businessAreaAndStaffDetails{get;set;}
        @AuraEnabled
        public list<Bank_Details__c> financialDetail{get;set;}
        @AuraEnabled
        public list<Bank_Details__c> loanDetails{get;set;}
        @AuraEnabled
        public list<DP_Detail__c> businessProposalQuestions{get;set;}
        @AuraEnabled
        public boolean upload_One_passport_Size{get;set;}
        @AuraEnabled
        public boolean copyOfPanCard{get;set;}
        @AuraEnabled
        public boolean copyOfSalesTax{get;set;}
        @AuraEnabled
        public boolean copyOfShopLicense{get;set;}
        @AuraEnabled
        public boolean fourPhotographOfEstablishment{get;set;}
        @AuraEnabled
        public boolean copyOfLasttwoYearsAudited{get;set;}
        @AuraEnabled
        public boolean copyOfLastTwoYearsIncome{get;set;}
        @AuraEnabled
        public boolean lastOneYearBank{get;set;}
        @AuraEnabled
        public boolean visitingCard{get;set;}
        @AuraEnabled
        public boolean securityCheques{get;set;}
        @AuraEnabled
        public list<Sales_Projection__c> billingCommitmentSales{get;set;}
        @AuraEnabled
        public list<Sales_Projection__c> dealerNetworkAdditionSales{get;set;}
        @AuraEnabled
        public list<Sales_Projection__c> salesProjectionInstance{get;set;}
        @AuraEnabled
        public list<Contact> detailsOfSelfandFamily{get;set;}
        @AuraEnabled
        public Boolean getGSTValidated{get;set;}
        @AuraEnabled
        public list<String> recordsToDelete{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listAccountAssignmentGroup{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listCreditControlArea{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listCusGroup{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listCusPricingProcedure{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listDeliveringPlant{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listDeliveryPriority{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listDistributorChannel{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listDivison{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listIncoterms{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listPaymentTerms{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listPriceGroup{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listSalesGroup{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listSalesOffice{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listSalesOrg{get;set;}
        @AuraEnabled
        public list<DP_SAP_Foreign_Key__c> listSalesCondition{get;set;}
    }
}
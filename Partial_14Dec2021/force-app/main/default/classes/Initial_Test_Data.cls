/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :24-Jan-2015
Modified Date   :
Version         :1.0
Description     :Initial Test Data for test classes

********************XXX***********************************/

/*
    0.User
    1.Account
    2.Project(Opportunity)
    3.OpportunityLineItems
    4.Product2
    5.pricebookentry
    6.Influencer
    7.Project Tracker
    8.Pricebook2

*/
@isTest
public class Initial_Test_Data {
    
    //User
    public static User createUser(String LName ,String FName,String profileName){
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@TestUser.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= FName+LName+'@TestUser.com',
                                  EmployeeNumber = 'Test'
                                  );
        return userData; 
    }



    public static Account createAccount(String name,String recordTypeName) {
        Id recordTId  = [select id from RecordType where SobjectType = 'Account' AND Name =:recordTypeName].id;
        Account newAccount = new Account(
                                Name  = name,
                                BillingState = 'Gujarat',
                                BillingStreet = 'Abc Street',
                                BillingCity = 'Abc City',
                                BillingCountry = 'India',
                                RecordTypeId = recordTId,
                                AccountNumber = '12345'
                                );

        return newAccount;
    }
    //Project 
    public static Opportunity createNewProject(String projectName,String projType,Id accoId,String stag) {  
        //Id recordTypeId  = [select id from RecordType where SobjectType = 'Opportunity' AND DeveloperName='New_Project'].id;
        Opportunity newNewProject =  new Opportunity(
                                   
                                    Name=projectName,
                                    Project_Type__c = projType,
                                    CloseDate = date.today(),
                                    No_of_Bathrooms__c = 100,
                                    StageName = stag,
                                    Project_By__c = accoId
                                    );
        return newNewProject; 
    }

    //OpportunityLineItem 
    public static OpportunityLineItem createOppLineItem(Id oppId,String aType,Id priceb) {  
        //Id recordTypeId  = [select id from RecordType where SobjectType = 'Opportunity' AND DeveloperName='New_Project'].id;
        OpportunityLineItem oppLineItem =  new OpportunityLineItem(
                                  
                                    OpportunityId = oppId,
                                    UnitPrice = 0,
                                    APPL_Type__c = aType,
                                    PricebookEntryId = priceb,
                                    Quantity = 2,
                                    Probability_MRP__c = null,
                                    Unit__c = null,
                                    Product_Specified__c = 'Yes'
                                    
                                    );
        
        return oppLineItem; 
    }

    //OpportunityLineItem 
    public static OpportunityLineItem createOppLineItemYes(Id oppId,String aType,Id priceb) {  
        //Id recordTypeId  = [select id from RecordType where SobjectType = 'Opportunity' AND DeveloperName='New_Project'].id;
        OpportunityLineItem oppLineItem =  new OpportunityLineItem(
                                  
                                    OpportunityId = oppId,
                                    UnitPrice = 0,
                                    APPL_Type__c = aType,
                                    PricebookEntryId = priceb,
                                    Quantity = 2,
                                    Probability_MRP__c = null,
                                    Unit__c = null,
                                    Probability_Validation__c = 'Yes'
                                    
                                    );
        
        return oppLineItem; 
    }
    public static OpportunityLineItem createOppLineItemNo(Id oppId,String aType,Id priceb) {  
        //Id recordTypeId  = [select id from RecordType where SobjectType = 'Opportunity' AND DeveloperName='New_Project'].id;
        OpportunityLineItem oppLineItem =  new OpportunityLineItem(
                                  
                                    OpportunityId = oppId,
                                    UnitPrice = 0,
                                    APPL_Type__c = aType,
                                    PricebookEntryId = priceb,
                                    Remark__c = null,
                                    Quantity = 2,
                                    Probability_Validation__c = 'No'
                                    
                                    );
        
        return oppLineItem; 
    }

    //Product
    public static Product2 createProduct(String proName) {

        Product2 newPro = new Product2(

                        Name = proName,
                        IsActive=true
                        );

        return newPro;

    } 
    
    //PricebookEntry
    public static PricebookEntry createPriceBookEntry(Id price,Id prod) {

        PricebookEntry newPriceE = new PricebookEntry(

            Pricebook2Id = price,

            UnitPrice = 0.0,

            IsActive = true,

            Product2Id = prod);

 
        return newPriceE;

    }   
    //Influencer
    public static Influencer__c createInfluencer(Id prod) {

        Influencer__c newInfu = new Influencer__c(

         
                            Influencer_Type__c = 'Engineer',

                            Opportunity__c = prod

                           );

        return newInfu;

    }   
    //Influencer
    public static Influencer__c createInfluencerdetails(Id oppId,Id accid) {

        Influencer__c newInfu = new Influencer__c(

         
                            Influencer_Type__c = 'Purchase Manager',

                            Opportunity__c = oppId ,
                            Account__c = accid                      

                           );

        return newInfu;

    }   

    //Influencer
    public static Project_Tracker__c createPTracker(Id prod) {

        Project_Tracker__c newPT = new Project_Tracker__c(

         
                            Question__c = 'All Product range approved',

                            Opportunity__c = prod

                           );

        return newPT;

    }   

    //PricebookEntry
    public static Pricebook2 createPriceBook(String pricebookName) {

        Pricebook2 newPriceBook = new Pricebook2(

            Description = 'Project Pricebook',
            IsActive = true,
            Name = pricebookName
            );

        return newPriceBook;

    } 
    
      //Target
    /*public static Target__c CreateTarget(String User) {
        
         Target__c target = new Target__c(
         Is_Active__c = true,
         Architects_Meet__c = 2,
         Boarers_Meet__c = 3,
         Builders_Meet__c = 4,
         Column_Dealer_Meet__c = 5
         
         );
         return target;
    } */
    public static Order createOrder(Id accountID, Id opportunityID, Id priceBookId) {
        
        Order newOrder = new Order(
                                Status  = 'Draft',
                                AccountId = accountID,
                                OpportunityId = opportunityID,
                                EffectiveDate = Date.today(),
                                Pricebook2Id = priceBookId
                                );

        return newOrder;
    } 
    public static OrderItem createOrderItem(Id productId, Id parentOrder, Id accountId, Id PricebookEntryId) {
        
        OrderItem newOrderItem = new OrderItem(
                                Quantity  = 1,
                                Unit__c = 'Mtrs',
                                Order_Value__c = 0,
                                ServiceDate = Date.today(),
                                Distributor_Name__c = accountId,
                                Competitor_Name__c = 'Astral',
                                EndDate = Date.today(),
                                Payment_Terms__c = '30 Days credit with PO',
                                Validity_for_Price__c = Date.today(),
                                OrderId = parentOrder,
                                UnitPrice = 0.0,
                                PricebookEntryId = PricebookEntryId
                                );

        return newOrderItem;
    }
    public static Supply__c createSupply(Id parentOrder, Id oppId) {
        
        Supply__c parentSupply = new Supply__c(
                                Order__c  = parentOrder,
                                Project__c = oppId,
                                ParentSupplyFlag__c = true
                                );

        return parentSupply;
    }
    public static SupplyLineItem__c createSupplyItem(Id parentSupply, Id orderLineItem, Id productId, Id accountId) {
        
        SupplyLineItem__c supplyLineItem = new SupplyLineItem__c(
                                SupplyDetails__c = parentSupply,
                                OrderLineItem__c  = orderLineItem,
                                Quantity__c = 0.0,
                                Unit__c = 'Mtrs',
                                Order_Value__c = 123,                                
                                Product__c = productId,
                                Supply_Status__c = 'Fully Received',
                                Payment_Terms__c = '30 days after delivery',
                                Distributor_Name__c = accountId,
                                ORC_Markup__c = 'qwerty',
                                ORC_Status__c =  'Part Received'

                                );

        return supplyLineItem;
    }

      

}
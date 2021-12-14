/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :02-Mar-2015
Modified Date   :
Version         :1.0
Description     :Test class for Additional_Dics_Opp_Controller

********************XXX***********************************/
@isTest(seeAllData=false)

private class Test_Additional_Dics_Opp_Controller {

  static User testUser;
  static Product2 testProduct;
  static Pricebook2 testPricebook;
  static PricebookEntry testPriceEntry;
  static PricebookEntry testPriceEntry2;
  static Account testAccount;
  static Opportunity testOpp;
  static OpportunityLineItem testOppLI;



  @isTest static void test_method_one() {
      
      

   
    

      Test.startTest();
testUser = Initial_Test_Data.createUser('Fir','Las','System Administrator');
      insert testUser;
//
      system.runAs(testUser){
//
      testProduct = Initial_Test_Data.createProduct('Test Product');
      insert testProduct;

      Id stdpb = Test.getStandardPricebookId();
      testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
      insert testPriceEntry;
       
       testPricebook = Initial_Test_Data.createPriceBook('Project');
      insert testPricebook;

       testPriceEntry2 = Initial_Test_Data.createPriceBookEntry(testPricebook.Id, testProduct.Id);
      insert testPriceEntry2;

      testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
      testAccount.Contact_Number_Mobile__c = '9765431218';
      testAccount.state__c='Karnataka';
      testAccount.District__c='Bangalore';
      testAccount.Business_Line__c='Plumbing';
      insert testAccount;

    testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
      testOpp.Probability_New__c ='100%';
      testOpp.Special_Pricing_Request_Approval__c='Approved';
      //testOpp.Conversion_Probability__c='test';
      insert testOpp;
      
    Recordtype rcd=new Recordtype();
          rcd=[select id,name from Recordtype where sObjectType='Account' and name='Distributor' limit 1];
   
      
        Account acc = new Account();
           
            acc.Name ='Acco';
            acc.Primary_Contact_Person_Name__c='te';
            acc.Classification__c='A';
            acc.Purchase_Cycle__c='Yearly';
            acc.Contact_Number_Mobile__c='7830864467';
            acc.Street_Address__c='Station road';
            acc.Display_of_our_product__c='Prominent';
            acc.Type_of_Dealer__c='Sanitary';
            acc.Media__c='Outshop';    
            acc.Market__c ='Existing';
            acc.Party_Type__c='Dealer';
            acc.Status__c = 'Prospective'; 
            acc.OwnerId=testUser.id;
            //acc.Discount__c=5;
            acc.District__c='Bangalore';
            acc.State__c='Karnataka';
            acc.Business_Line__c='Column';
          acc.RecordTypeId=rcd.id;
          acc.Conversion_Probability__c='tset';
          acc.AccountNumber = '12345';
             
            
          insert acc;
            
     
      testOppLI = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Probability',testPriceEntry2.Id);
      testOppLI.Quantity = 1;
      testOppLI.Probability_Check__c = true;
      testOppLI.Offer_Check__c = true;
      testOppLI.checked_if_Approved__c=true;
       testOppLI.APPL_STD_Discount__c = 1 ;
                        testOppLI.Addl_Discount_Required__c  = 1;
                        testOppLI.ORC_Margin_to_Dlr_Dist__c = 1;
                        testOppLI.Delivery_Start_Date__c = date.newinstance(2017, 09, 16); 
                        testOppLI.Delivery_End_Date__c  = date.newinstance(2017, 09, 16); 
                        testOppLI.Competitor_name_Offer__c  = 'sada' ;
                        testOppLI.Distributor__c  = acc.Id;
                        testOppLI.Product_Specified__c   = 'Yes' ;
                        testOppLI.Payment_Terms__c = '30 Days credit with PO' ;
                        testOppLI.Delivery_Schedule__c = '1 LOTS' ;
                        testOppLI.Why_Additional_Discount__c = 'asdad' ;
                        //testOppLI.Conversion_Probability__c='test';
                        testOppLI.Validity_for_the_Price__c  = date.newinstance(2017, 09, 16);
      insert testOppLI;

        //ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        PageReference pageRef = new PageReference('/apex/Additional_Dics_Opp');
              Test.setCurrentPage(pageRef);
              ApexPages.currentPage().getParameters().put('id',testOpp.Id);
          
              Additional_Dics_Opp_Controller oppController = new Additional_Dics_Opp_Controller();
             oppController.OldList[0].oppCheck=true;
      
      
      
              oppController.addrow();
      
    Additional_Dics_Opp_Controller.wrapperOpp ob=new Additional_Dics_Opp_Controller.wrapperOpp();
          ob.oli=new OpportunityLineItem();
     
      
      
               displaySPR obj=new displaySPR();
               Test.setCurrentPage(pageRef);
              pageRef.getParameters().put('id',testOpp.id);
             // ApexPages.StandardController sc = new ApexPages.standardController(testOpp);
              displaySPR  controller = new displaySPR();
              PageReference page=controller.removeRow();
            testOppLI.checked_if_Approved__c=false;
             update testOppLI;
        displaySPR  controller1 = new displaySPR();
         testOpp.Special_Pricing_Request_Approval__c='Rejected';
      update testOpp;
         displaySPR  controller2 = new displaySPR();
          
      for(Additional_Dics_Opp_Controller.wrapperOpp t:oppController.OldList){
        t.oppCheck=true;
      }
   
      testOpp.Special_Pricing_Request_Approval__c='Approved';
      update testOpp;
      MyBatchClassToUpdateOLI  objcgt=new MyBatchClassToUpdateOLI();
    Id batchId = Database.executeBatch(objcgt);
       
                
       Additional_Dics_Opp_Controller.wrapperOpp w1=new Additional_Dics_Opp_Controller.wrapperOpp();   
        oppController.addRow(); 
        oppController.oldId=testOppLI.id;
          oppController.edit();
          
          
          
        //oppController.NewList.add(w1);
     
        
             
               oppController.save();
               //oppController.edit();
      Test.stopTest();
      }
      
    }

  
  
  
}
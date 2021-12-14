/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class Test_APPL_AccountTrigger {
    
    static testMethod void myUnitTest() {
       
            list<Account> accList  =  new list<Account>(); 
            
            Target__c objTarget = Test_Utilclass.objTarget();
            objTarget.New_dealers_activation_Actual__c = null;
            objTarget.New_Distributer_Activation_Actuals__c = null;
            objTarget.New_Direct_Dealer_Activation__c = null;
            insert objTarget;
            
            Account objAcct = Test_Utilclass.ObjAcct();
            objAcct.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct.Contact_Number_Mobile__c     = '9603612601'; 
            objAcct.Status__c = 'Existing';
            objAcct.Discount__c  = 2;
            
            
            Account objAcct1 = Test_Utilclass.ObjAcct();
            objAcct1.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct1.Contact_Number_Mobile__c     = '9603612602'; 
            objAcct1.Status__c = 'Existing';
            objAcct1.Discount__c  = 2;
            
            Account objAcct2 = Test_Utilclass.ObjAcct();
            objAcct2.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct2.Contact_Number_Mobile__c     = '9603612603'; 
            objAcct2.Status__c = 'Existing';
            objAcct2.Discount__c  = 2;
            objAcct2.Ramco_ID__c = '123';
            
            Account objAcct3 = Test_Utilclass.ObjAcct();
            objAcct3.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct3.Contact_Number_Mobile__c     = '9603612604'; 
            objAcct3.Status__c = 'Existing';
            objAcct3.Discount__c  = 2;
            objAcct3.Ramco_ID__c = '123';
            
            
            Account objAcct4 = Test_Utilclass.ObjAcct();
            objAcct4.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct4.Contact_Number_Mobile__c     = '9603612605'; 
            objAcct4.Status__c = 'Existing';
            objAcct4.Discount__c  = 2; 
            
            
            
            Account objAcct5 = Test_Utilclass.ObjAcct();
            objAcct5.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct5.Contact_Number_Mobile__c     = '9603612606'; 
            objAcct5.Status__c = 'Cold Call';
            objAcct5.Discount__c  = 2;
            
            /*Account objAcct1 = Test_Utilclass.ObjAcct();
            objAcct1.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct1.Contact_Number_Mobile__c     = '9603612602'; 
            objAcct1.Status__c = 'Prospective';
            objAcct1.Discount__c  = 2;*/
            
            Account objAcct6 = Test_Utilclass.ObjAcct();
            objAcct6.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct6.Contact_Number_Mobile__c     = '9603612607'; 
            objAcct6.Type_Of_partner__c = 'Retail Partner';
            objAcct6.Status__c = 'Existing';
            objAcct6.Discount__c  = 2;
            objAcct6.Ramco_ID__c = '123';
            //insert objAcct;
            
            Account objAcct7 = Test_Utilclass.ObjAcct();
            objAcct7.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct7.Contact_Number_Mobile__c     = '9603612608'; 
            objAcct7.Type_Of_partner__c = 'Retail Partner';
            objAcct7.Discount__c  = 2;
            objAcct7.Ramco_ID__c = '123';
            
            accList.add(objAcct);
            accList.add(objAcct1);
            accList.add(objAcct2);
            accList.add(objAcct3);
            accList.add(objAcct4);
            accList.add(objAcct5);
            accList.add(objAcct6);
            accList.add(objAcct7);
            insert accList;
            
            objAcct5.recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct5.Distributor_Activated_Date__c = date.today().addDays(45);
            update objAcct5;
    }
    
    static testMethod void myUnitUpdate() {
        	
        	Target__c objTarget = Test_Utilclass.objTarget();
            insert objTarget;
            
            list<Account> lstAccount = new list<Account>();
            
            Account objAcct = Test_Utilclass.ObjAcct();
            objAcct.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct.Contact_Number_Mobile__c     = '9603612611';
            objAcct.Type_Of_partner__c = 'Retail Partner';
            objAcct.Ramco_ID__c = '123';
            
            Account objAcct1 = Test_Utilclass.ObjAcct();
            objAcct1.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct1.Contact_Number_Mobile__c     = '9603612612';
            objAcct1.Type_Of_partner__c = 'Retail Partner';
            objAcct1.Ramco_ID__c = '123';
            
            Account objAcct3 = Test_Utilclass.ObjAcct();
            objAcct3.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct3.Contact_Number_Mobile__c     = '9603612613';
            
            Account objAcct4 = Test_Utilclass.ObjAcct();
            objAcct4.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct4.Contact_Number_Mobile__c     = '9603612614';
            objAcct4.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct5 = Test_Utilclass.ObjAcct();
            objAcct5.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct5.Contact_Number_Mobile__c     = '9603612615';
            objAcct5.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct6 = Test_Utilclass.ObjAcct();
            objAcct6.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
            objAcct6.Contact_Number_Mobile__c     = '9603612616';
            objAcct6.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct7 = Test_Utilclass.ObjAcct();
            objAcct7.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct7.Contact_Number_Mobile__c     = '9603612617';
            objAcct7.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct8 = Test_Utilclass.ObjAcct();
            objAcct8.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct8.Contact_Number_Mobile__c     = '9603612618';
            objAcct8.Dealer_Activated_Date__c     = date.today();
            
            
            Account objAcct9 = Test_Utilclass.ObjAcct();
            objAcct9.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct9.Contact_Number_Mobile__c     = '9603612619';
            objAcct9.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct10 = Test_Utilclass.ObjAcct();
            objAcct10.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct10.Contact_Number_Mobile__c     = '9603612620';
            objAcct10.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct11 = Test_Utilclass.ObjAcct();
            objAcct11.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct11.Contact_Number_Mobile__c     = '9603612621';
            objAcct11.Dealer_Activated_Date__c     = date.today();
            objAcct11.Ramco_ID__c = '123';
            
            Account objAcct12 = Test_Utilclass.ObjAcct();
            objAcct12.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct12.Contact_Number_Mobile__c     = '9603612622';
            objAcct12.Dealer_Activated_Date__c     = date.today();
            objAcct12.Ramco_ID__c = '123';
            
            Account objAcct13 = Test_Utilclass.ObjAcct();
            objAcct13.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct13.Contact_Number_Mobile__c     = '9603612623';
            objAcct13.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct14 = Test_Utilclass.ObjAcct();
            objAcct14.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            objAcct14.Contact_Number_Mobile__c     = '9603612624';
            objAcct14.Dealer_Activated_Date__c     = date.today();
            
            Account objAcct15 = Test_Utilclass.ObjAcct();
            objAcct15.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
            objAcct15.Contact_Number_Mobile__c     = '9603612625';
            objAcct15.Dealer_Activated_Date__c     = date.today();
            objAcct15.Ramco_ID__c = '123';
            
            /*Account objAcct16 = Test_Utilclass.ObjAcct();
            objAcct16.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Branding Shop').getRecordTypeId();
            objAcct16.Contact_Number_Mobile__c     = '9603612626';
            objAcct16.Dealer_Activated_Date__c     = date.today();*/
            
            
            lstAccount.add(objAcct);
            lstAccount.add(objAcct1);
            lstAccount.add(objAcct3);
            lstAccount.add(objAcct4);
            lstAccount.add(objAcct5);
            lstAccount.add(objAcct6);
            lstAccount.add(objAcct7);
            lstAccount.add(objAcct8);
            lstAccount.add(objAcct9);
            lstAccount.add(objAcct10);
            lstAccount.add(objAcct11);
            lstAccount.add(objAcct12);
            lstAccount.add(objAcct13);
            lstAccount.add(objAcct14);
            lstAccount.add(objAcct15);
            //lstAccount.add(objAcct16);
            //lstAccount.add(objAcct17);
            
            insert lstAccount;
            
            list<Account> lstUpdateAcct = new list<Account>();
            
            Account objUpdateAcct = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(),
                                                id=lstAccount[0].id);
            
            Account objUpdateAcct1 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                 id=lstAccount[1].id);
            
            Account objUpdateAcct2 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(),
                                                 id=lstAccount[2].id);
            
            Account objUpdateAcct3 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(),
                                                 id=lstAccount[3].id);
            
            Account objUpdateAcct4 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(),
                                                 id=lstAccount[4].id);
            
            Account objUpdateAcct5 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(),
                                                 id=lstAccount[5].id);
            
            Account objUpdateAcct6 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId(),
                                                 id=lstAccount[6].id);
            
            Account objUpdateAcct7 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId(),
                                                 id=lstAccount[7].id);
            
            Account objUpdateAcct8 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId(),
                                                 id=lstAccount[8].id);
            
            Account objUpdateAcct9 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId(),
                                                 id=lstAccount[9].id);
            
            Account objUpdateAcct10 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[10].id);
            
            Account objUpdateAcct11 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[11].id);
            
            Account objUpdateAcct12 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[12].id);
            
            Account objUpdateAcct13 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[13].id);
            
            Account objUpdateAcct14 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[14].id);
            
             /*Account objUpdateAcct15 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                  id=lstAccount[15].id);
            
            Account objUpdateAcct16 = new Account(recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId(),
                                                   id=lstAccount[16].id);*/
            
            lstUpdateAcct.add(objUpdateAcct);
            lstUpdateAcct.add(objUpdateAcct1);
            lstUpdateAcct.add(objUpdateAcct2);
            lstUpdateAcct.add(objUpdateAcct3);
            lstUpdateAcct.add(objUpdateAcct4);
            lstUpdateAcct.add(objUpdateAcct5);
            lstUpdateAcct.add(objUpdateAcct6);
            lstUpdateAcct.add(objUpdateAcct7);
            lstUpdateAcct.add(objUpdateAcct8);
            lstUpdateAcct.add(objUpdateAcct9);
            lstUpdateAcct.add(objUpdateAcct10);
            lstUpdateAcct.add(objUpdateAcct11);
            lstUpdateAcct.add(objUpdateAcct12);
            lstUpdateAcct.add(objUpdateAcct13);
            lstUpdateAcct.add(objUpdateAcct14);
            //lstUpdateAcct.add(objUpdateAcct15);
            //lstUpdateAcct.add(objUpdateAcct16); 
            
            update lstUpdateAcct;     
    }  
}
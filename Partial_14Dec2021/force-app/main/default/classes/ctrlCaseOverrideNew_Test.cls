/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class ctrlCaseOverrideNew_Test{

 static testMethod void validateCaseOverrideNew(){
    
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Id coll=[Select id from RecordType where Name ='Collateral Request'].id; 
    Id auto=[Select id from RecordType where Name ='Auto Dispatch'].id;
    
    
    Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false, Request_User__c=user.id); 
                    
    test.startTest();
    System.runAs(user)
    { 
    insert casej;
    Case casek=new Case(recordtypeId = coll); 
    ctrlCaseOverrideNew pdd = new ctrlCaseOverrideNew(new ApexPages.StandardController(casej));
    PageReference page = pdd.redirect();
   }    
    test.stopTest();  
    }


}
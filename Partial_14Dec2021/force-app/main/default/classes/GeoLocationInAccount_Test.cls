@isTest
public class GeoLocationInAccount_Test{
    public static testMethod void GeoLocationTestMethod(){
        Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'BD']; 
        User userData1 = new User(Alias = 'standt1', 
              Email= 'FName'+'LName'+'@ashirvad.com', 
              EmailEncodingKey='UTF-8', 
              FirstName = 'FName',
              LastName = 'LName', 
              LanguageLocaleKey='en_US', 
              LocaleSidKey='en_US', 
              ProfileId = p.Id, 
              TimeZoneSidKey='Asia/Kolkata', 
              UserName='LName'+'FName'+'@ashirvadpipes.com',
              EmployeeNumber = '12345'                                  
        );
                                 
        insert userData1;
                                 
        RecordType rcdtyp = [SELECT ID FROM RecordType WHERE Name = 'Distributor'];
        Account newAccount = new Account(
            Name  = 'name',
            BillingState = 'Gujarat',
            BillingStreet = 'Abc Street',
            BillingCity = 'Abc City',
            BillingCountry = 'India',
            Contact_Number_Mobile__c = '9999999999',
            Ramco_ID__c = '1234',
            RecordTypeId = rcdtyp.ID
        );
        
        insert newAccount;
         
        Target__c target = new Target__c(
            Is_Active__c = true,
            Architects_Meet__c = 2,
            Boarers_Meet__c = 3,
            Builders_Meet__c = 4,
            Column_Dealer_Meet__c = 5,
            Target_User__c = userData1.Id,
            OwnerId = userData1.Id,
            Approval_Status__c = 'Not Submitted',
            Vertical__c        = 'Plumbing'
        );
        
        insert target;
        
        AP_Tour_Plan__c tourplan = new AP_Tour_Plan__c(
            Market_Type__c = 'New',
            Promotional_Type__c = 'Boarers Meet',
            Target__c = target.ID,
            Account__c = newAccount.Id           
        );
        
        insert tourplan;
         
        AP_Site_Visit__c apsv = new AP_Site_Visit__c(
            AP_Tour_Plan__c = tourplan.ID,
            Target__c = target.Id,
            Party_Type__c = 'Distributor',
            Party_Name__c = newAccount.Id,
            Geo_Location__Latitude__s = 12.91315,
            Geo_Location__Longitude__s = 77.62784 
        );
        
        insert apsv;
     
    } 
}//end of GeoLocationInAccount_Test
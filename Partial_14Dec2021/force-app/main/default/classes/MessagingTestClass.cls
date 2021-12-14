@isTest
public class MessagingTestClass {
    
    public static testmethod  void testCase(){
        MessagingChannel mc= new MessagingChannel();
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        MessagingEndUser msend=new MessagingEndUser();

        system.runAs(thisUser){
            mc.MessageType='Whatsapp';
            mc.MessagingPlatformKey='whatsapp:+918061341880';
            mc.DeveloperName='xyzz';
            mc.MasterLabel='asdfg';
            insert mc;
            
            msend.Name='whatsapp:+919980830110';
            msend.MessagingPlatformKey='whatsapp:+919980830110';
            // msend.MessagingConsentStatus='Implicitly Opted In';
            msend.MessageType='WhatsApp';
            msend.MessagingChannelId=mc.id;
            insert msend;
            
            
        }
         OperatingHours oh = new OperatingHours();
        oh.Name = 'TestOH';
        oh.TimeZone='America/Los_Angeles';
        insert oh;
        
        
      ServiceTerritory s1=new ServiceTerritory();
        s1.Name='Bangalore';
        s1.IsActive=true;
        s1.OperatingHoursId=oh.id;
        insert s1;

        Town_Master__c tm=new Town_Master__c();
        tm.Name='Bangalore';
        tm.State__c='Karnataka';
        tm.District__c='Bangalore';
        tm.Service_Territory__c=s1.id;
        insert tm;
        
        Account acc1=new Account();
        acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Customer').getRecordTypeId();
        acc1.Name='Customer';
        acc1.Contact_Number_Mobile__c='9980830110';
        acc1.Can_you_please_give_address_retail__c='asdfghj';
        acc1.City_lookup__c=s1.id;
        acc1.State__c='Karnataka';
        acc1.Country_fsl__c='India';
        acc1.PinCode__c='123456';
        acc1.Town_Code__c='5670';
         acc1.Business_Line__c='Column';
        acc1.Products__c='CPVC';
        
        acc1.Town_Name__c=tm.id;
        insert acc1;
        MessagingSession ms=new MessagingSession();
        ms.MessagingEndUserId=msend.id;
        ms.MessagingChannelId=mc.Id;
        ms.Messaging_User_Account__c=acc1.id;
        ms.Status='Active';
        //ms.Origin='Inbound Initiated';
        upsert ms;
        
    }
}
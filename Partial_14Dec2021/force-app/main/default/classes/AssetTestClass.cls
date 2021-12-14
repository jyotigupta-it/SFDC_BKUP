@isTest
private class AssetTestClass {
    public static testMethod void testCase(){
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
        Warranty_Master__c wc=new Warranty_Master__c();
        wc.Name='TEST';
        Wc.Product_Code__c='90085';
        insert wc;
         MessagingSession ms=new MessagingSession();
        ms.MessagingEndUserId=msend.id;
        ms.MessagingChannelId=mc.Id;
        ms.Messaging_User_Account__c=acc1.id;
        ms.Status='Active';
        //ms.Origin='Inbound Initiated';
        upsert ms;
        
        Asset ass=new Asset();
        ass.AccountId=acc1.id;
        ass.Warranty_Master__c=wc.id;
        ass.Status='Verified';
        ass.Name='test';
        ass.Messaging_Session__c=ms.id;
        insert ass;
        
         Asset ass1=new Asset();
        ass1.Name='test1';
        ass1.AccountId=acc1.id;
        ass1.Warranty_Master__c=wc.id;
        insert ass1;
          Map<String,String> mapOfTemplateMapping = new Map<String,String>();
         List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c ,Closed_Reason__c,Status__c,TemplateId__c from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
           
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
            
        }
            SMSLogService.SMSJSON smsjsn = new SMSLogService.SMSJSON();
          
            smsjsn.flow_id = mapOfTemplateMapping.get('Closed' +'-WorkOrder'+'-'+'Problem Resolved');
            smsjsn.flow_id = mapOfTemplateMapping.get('Closed' +'-WorkOrder');
            smsjsn.mobiles = '1234567890';
            smsjsn.mobiles = '1234567890';
            smsjsn.customerName = 'Test';
            smsjsn.caseNumber = '098765433';
            smsjsn.contractorName = 'Test';
            smsjsn.custPhone = '1234567890';
            smsjsn.custAddress = 'qwer,qwer,456789,qwert,qwert';
            smsjsn.Issue ='concealed';
            smsjsn.Quantity ='4' ;
            smsjsn.ProductName = 'concealed';
            System.debug('JSON WO'+JSON.serialize(smsjsn));
            String str = JSON.serialize(smsjsn);
            
        
        
        SMS99_Endpoints__c smsendpoint=new SMS99_Endpoints__c();
        smsendpoint.Name='sms';
        smsendpoint.Api_Key__c='262423A43Fh7kczK5ee30ce6P1';
        smsendpoint.Endpoint__c='https://api.msg91.com/api/v5/flow/';
        insert smsendpoint;
        System.test.startTest();
        SMSLogService.sendSMS(str);
        
        System.test.stopTest();
     
        
        
    }
}
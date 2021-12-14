@isTest
private class ServiceChargeTestClass {
    public static testMethod void testCase(){
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
        acc1.Contact_Number_Mobile__c='12345678901';
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
          Entitlement ent=new Entitlement();
         ent.name='Work Order Process';
         ent.AccountId=acc1.id;
         insert ent;
        
        Entitlement ent1=new Entitlement();
         ent1.name='Case Process';
         ent1.AccountId=acc1.id;
         insert ent1;
        
       
        
      
        ServiceTerritory s5=new ServiceTerritory();
        s5.Name='Pune';
        s5.IsActive=true;
        s5.OperatingHoursId=oh.id;
        insert s5;
        
        
        Product2 prod=new Product2();
        prod.Name='Concealed Valve';
        prod.IsActive=true;
        prod.Family='Concealed Valve';
        insert prod;
       
        Product2 prod1=new Product2();
        prod1.Name='Concealed Diverter';
        prod1.IsActive=true;
        prod1.Family='Diverter';
        insert prod1;
        
        WorkType work=new WorkType();
        work.Name='Concealed';
        work.DurationType='Hours';
        work.EstimatedDuration=5;
        insert work;
        
        Problem__c prob =new Problem__c();
        prob.Name='Concealed valve leakage';
        prob.Product__c=prod.Id;
        
        prob.Work_Type__c=work.id;
        insert prob;
        
         Problem__c prob1 =new Problem__c();
        prob1.Name='Concealed Diverter leakage';
        prob1.Product__c=prod1.Id;
        
        prob1.Work_Type__c=work.id;
        insert prob1;

       Contact con = new Contact(LastName ='testCon',Salutation='Mr',AccountId = acc1.Id);
       insert con;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Ashirvad Contractor Partner Community'];
        User u1=new User();
        u1.Alias='user1';
        u1.Email='test@gmail.com';
        u1.Username='test675433@gmail.com.123';
        u1.FirstName='test';
        u1.LastName='user';
        u1.ProfileId=p.id;
        u1.EmailEncodingKey='UTF-8';
        u1.LanguageLocaleKey='en_US';
        u1.LocaleSidKey='en_US';
        u1.IsActive=true;
        u1.ContactId=con.id;
        u1.TimeZoneSidKey='America/Los_Angeles';
        insert u1;
 
         ServiceResource sr=new ServiceResource();
        sr.Name='TestResource';
       // sr.ResourceType='Technician';
        sr.RelatedRecordId=u1.Id;
        sr.IsActive=true;
        insert sr;
        
          
        Territory_Contractors__c tc =new Territory_Contractors__c();
        tc.Name='Test';
        tc.Service_Territory__c=s1.Id;
        tc.Contractor__c= u1.id;
        insert tc;
        
        Case c1=new Case();
        c1.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Product Complaint').getRecordTypeId();
        c1.AccountId=acc1.id;
        c1.Status='Work Order Acceptance Pending';
        c1.Service_Territory__c=s1.id;
        c1.Problem__c = prob.id;
        c1.Product__c= prod.id;
        c1.Quantity__c='6';
        c1.Product_Family__c='Concealed Valve';
        c1.Create_WorkOrder__c=true;
        c1.Contractor__c=u1.id;
        c1.EntitlementId=ent1.id;
        c1.Closure_Code__c='123456';
        insert c1;
        
        Case_Products__c cp=new Case_Products__c();
        cp.Case__c=c1.id;
        //cp.Name='test product';
        cp.Product__c= prod1.id;
        cp.Product_Family__c='Diverter';
        cp.Problem__c=prob1.id;
        cp.Quantity__c=6;
        insert cp;
        
        WorkOrder w1=new WorkOrder();
        w1.CaseId=c1.Id;
        w1.OwnerId=c1.Contractor__c;
        w1.EntitlementId = ent.id;
        w1.ServiceTerritoryId=c1.Service_Territory__c;
        w1.Status='Acceptance Pending';
        insert w1;
        
       
        
        
        ServiceAppointment ser=new ServiceAppointment();
        
        ser.ParentRecordId=w1.id;
        ser.DueDate=datetime.newInstance(2020, 7, 30, 12, 30, 0);
        ser.EarliestStartTime=datetime.newInstance(2020, 7, 29, 12, 30, 0);
        ser.SchedStartTime=datetime.newInstance(2020, 7, 29, 12, 30, 0);
        ser.SchedEndTime=datetime.newInstance(2020, 7, 30, 12, 30, 0);
        insert ser;
        

         
        Service_Charge__c sc=new Service_Charge__c();
        sc.Location_Name__c=tm.Name;
        sc.Customer_Name__c=acc1.Name;
        sc.Plumber__c=sr.id;
        sc.Work_Order__c=w1.id;
        sc.Service_Charge_Amount__c=250;
        insert sc;
         Service_Charge__c sc1=new Service_Charge__c();
        sc1.Location_Name__c=tm.Name;
        sc1.Customer_Name__c=acc1.Name;
        sc1.Plumber__c=sr.id;
        sc1.Work_Order__c=w1.id;
        sc1.Service_Charge_Amount__c=2500;
        insert sc1;
        
        Invoice__c inv=new Invoice__c();
        inv.Account__c=acc1.id;
        inv.Invoice_Amount__c=2000;
        inv.Invoice_Date__c=Date.newInstance(2020, 12, 1);
        insert inv;
        List<String> lst=new List<String>();
        lst.add(sc1.id);
        lst.add(sc.id);
       // List<id> lst1=JSON.stringify(lst);
        
        String fc=json.serialize(lst);
         LCC_CreateInvoice.Datawarp da=new LCC_CreateInvoice.Datawarp();
        da=LCC_CreateInvoice.getsreciveCharges(fc);
        List<LCC_CreateInvoice.ServiceChargeWrapper> sw=new  List<LCC_CreateInvoice.ServiceChargeWrapper>();
        sw=LCC_CreateInvoice.getServiceCharges();
        //LCC_CreateInvoice.updatesreciveCharges(inv.id,lst);
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
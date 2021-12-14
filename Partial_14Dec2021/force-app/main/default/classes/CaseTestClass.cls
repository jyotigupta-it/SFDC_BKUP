@isTest
private class CaseTestClass {
    
    public static testMethod void testCase(){
        
        try {
           
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
        
   
         
        
       // Case c2=new Case();
       // c2.id=c1.id;
       // c2.Status='Closed';
        //c2.Closed_Reason__c='Customer not available';
        //update c2;
        
         Contact con1 = new Contact(LastName ='testcontact',Salutation='Mr',AccountId = acc1.Id);
       insert con1;
        
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Ashirvad Contractor Partner Community'];
        User u11=new User();
        u11.Alias='user1';
        u11.Email='testffff@gmail.com';
        u11.Username='test44675433@gmail.com.123';
        u11.FirstName='test';
        u11.LastName='user5';
        u11.ProfileId=p1.id;
        u11.EmailEncodingKey='UTF-8';
        u11.LanguageLocaleKey='en_US';
        u11.LocaleSidKey='en_US';
        u11.IsActive=true;
        u11.ContactId=con1.id;
        u11.TimeZoneSidKey='America/Los_Angeles';
        insert u11;
        
          Territory_Contractors__c tcc =new Territory_Contractors__c();
        tcc.Name='Pune';
        tcc.Service_Territory__c=s5.Id;
        tcc.Contractor__c= u11.id;
        insert tcc;
 
        ServiceTerritory s2=new ServiceTerritory();
         s2.Name='Mangalore';
        s2.IsActive=true;
        s2.OperatingHoursId=oh.id;
        insert s2;
          Test.startTest();
        
        Territory_Contractors__c tc1 =new Territory_Contractors__c();
        tc1.id=tc.id;
        tc1.Service_Territory__c=s2.id;
        tc1.Contractor__c=u11.id;
        update tc1;
        
        Case c2=new Case();
        c2.id=c1.id;
        c2.Service_Territory__c=s5.id;
        c2.Contractor__c=u11.id;
        update c2;
        
         ServiceAppointment ser1=new ServiceAppointment();
        ser1.id=ser.id;
        ser1.Status='Scheduled';
        update ser1;
        
        ServiceAppointment ser2=new ServiceAppointment();
        ser2.id=ser.id;
        ser2.Status='Dispatched';
        update ser2;
        
         ServiceAppointment ser3=new ServiceAppointment();
        ser3.id=ser.id;
        ser3.Status='In Progress';
        update ser3;
        
               
          
        WorkOrder wo=new WorkOrder();
        
        wo.id=w1.id;
        wo.Status='Acceptance Pending';
        wo.Stop_milestone__c='Case Violation ';
        update wo;
        
         WorkOrder wor=new WorkOrder();
        
        wor.id=w1.id;
        wor.Status='Accepted';
        //wor.Stop_milestone__c='Cart Violation ';
        update wor;
        
         ServiceAppointment ser4=new ServiceAppointment();
        ser4.id=ser.id;
        ser4.Status='Completed';
        update ser4;

      
        Case cs=new Case();
        cs.id=c1.id;
        cs.Status='Completed by Contractor';
         update cs;
          
        WorkOrder w2 = new WorkOrder();
         w2.CaseId=c1.Id;
        w2.id=w1.id;
        w2.Status='Closed';
        
   
        update w2;
          Case newC1=new Case();
        newC1.id=c1.id;
        newC1.Status='Closed';
        newC1.Reason__c='Customer Not Available';
        //newC.Is_your_complaint__c='yes';
        //newC.How_will_you_rate_behavior_of_our_expert__c='Excellent';
        //newC.How_will_you_rate_o__c='6';
        
       update newC1;
        
       Case newC=new Case();
        newC.id=c1.id;
        newC.Status='Open';
        //newC.Reason__c='Problem Resolved';
        newC.Is_your_complaint__c='No';
        //newC.How_will_you_rate_behavior_of_our_expert__c='Excellent';
        //newC.How_will_you_rate_o__c='6';
        
       update newC;
        
         /*Case newCase=new Case();
        newCase.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Product Complaint').getRecordTypeId();
        newCase.AccountId=acc1.id;
        newCase.Status='Work Order Acceptance Pending';
        newCase.Service_Territory__c=s1.id;
        newCase.Problem__c = prob.id;
        newCase.Product__c= prod.id;
        newCase.Create_WorkOrder__c=true;
        newCase.Contractor__c=u1.id;
        newCase.EntitlementId=ent1.id;
        newCase.Closure_Code__c='123456';
        neWCase.Product_Family__c='Concealed Valve';
        insert newCase;
        
        WorkOrder workor=new WorkOrder();
        workor.CaseId=newCase.Id;
        workor.OwnerId=newCase.Contractor__c;
        workor.EntitlementId = ent.id;
        workor.ServiceTerritoryId=newCase.Service_Territory__c;
        workor.Status='Acceptance Pending';
        insert workor;
        
        ServiceAppointment serapp=new ServiceAppointment();
        serapp.ParentRecordId=workor.id;
        serapp.DueDate=datetime.newInstance(2020, 7, 31, 12, 30, 0);
        serapp.EarliestStartTime=datetime.newInstance(2020, 7, 30, 12, 30, 0);
        serapp.Status='Scheduled';
        insert serapp;
        
        
        ServiceAppointment serapp1=new ServiceAppointment();
        serapp1.id=serapp.id;
        serapp1.Status='Dispatched';
        update serapp1;
        
        ServiceAppointment serapp2=new ServiceAppointment();
        serapp2.Id=serapp.id;
        serapp2.Status='In Progress';
        update serapp2;
        
         ServiceAppointment serapp3=new ServiceAppointment();
        serapp3.Id=serapp.id;
        serapp3.Status='Completed';
        update serapp3;
        
        WorkOrder rder=new WorkOrder();
        rder.id=workor.id;
        rder.Status='Completed by Plumber';
        update rder;
        
         WorkOrder rder1=new WorkOrder();
        rder1.id=workor.id;
        rder1.Status='Closed';
        update rder1;
        
        Case casenew=new Case();
        casenew.id= newCase.id;
        casenew.Status='Completed by Contractor';
        update casenew;
        
       
        
      /* Case casenew1=new Case();
        casenew1.id=casenew.id;
        casenew1.Status='Closed';
        casenew1.Closed_Reason__c='Problem resolved';
       casenew1.Is_your_complaint__c='yes';
        update casenew1;*/
        
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
         List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c ,Closed_Reason__c,Status__c,TemplateId__c from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            if(each.Closed_Reason__c == null)
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
            else
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c + '-' + each.Closed_Reason__c, each.TemplateId__c);    
        }
            SMSLogService.SMSJSON smsjsn = new SMSLogService.SMSJSON();
          
            smsjsn.flow_id = mapOfTemplateMapping.get('Closed' +'-WorkOrder'+'-'+'Problem Resolved');
            smsjsn.flow_id = mapOfTemplateMapping.get('Closed' +'-WorkOrder');
            smsjsn.mobiles = '1234567890';
            
        
            smsjsn.customerName = 'Test';
            smsjsn.caseNumber = '098765433';
            smsjsn.contractorName = 'Test';
            smsjsn.contractorNumber='1234567890';
            smsjsn.custPhone = '1234567890';
            smsjsn.custAddress = 'qwer,qwer,456789,qwert,qwert';
            smsjsn.Issue ='concealed';
            smsjsn.Quantity ='4' ;
            smsjsn.ProductName = 'concealed';
            smsjsn.closureNum = '345678';
            System.debug('JSON WO'+JSON.serialize(smsjsn));
        
            String str = JSON.serialize(smsjsn);
            SMSLogService.SMSJSON smsjsnn = new SMSLogService.SMSJSON();
            smsjsnn.mobiles = '1234567890';
            smsjsnn.customerName = 'zxcvbn';
            smsjsnn.plumberPhone = '1234567890';
            smsjsnn.plumberName = 'asdfg';
            smsjsnn.scheduledDateTime = String.valueOf(ser.EarliestStartTime);
            System.debug('JSON Service App'+JSON.serialize(smsjsnn));
         String str1 = JSON.serialize(smsjsnn);
            
        SMS99_Endpoints__c smsendpoint = new SMS99_Endpoints__c();
        smsendpoint.Name='sms91';
        smsendpoint.Api_Key__c ='262423A43Fh7kczK5ee30ce6P1';
        smsendpoint.Endpoint__c ='https://api.msg91.com/api/v5/flow/';
        insert smsendpoint;
     
          
        SMSLogService.sendSMS(str);
        //SMSLogService.sendSMSBatch(str1);
       
           Test.stopTest();
       


        
        
        
        
        }
    Catch(Exception e){
        
    }
    }}
public class SMSLogService {
    
    public static void generateSMSContentForCase(Map<Id,Case> mapOfCases){
        List<Case> listOfCases = [Select Id,CaseNumber,closure_code__c,status,Account.Contact_Number_Mobile__c,Closed_Reason__c ,Account.Name,Product__r.Name,Product_Family__c,Problem__r.Name,Quantity__c 
                                  from Case 
                                  where Id in: mapOfCases.keySet()];
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c,Closed_Reason__c,Status__c,TemplateId__c
                                                           from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            System.debug('each.Closed_Reason__c'+each.Closed_Reason__c);
            System.debug('each.Status__c'+each.Status__c);
            System.debug('each.Object_Name__c'+each.Object_Name__c);
            System.debug('each.TemplateId__c'+each.TemplateId__c);
            if(each.Closed_Reason__c == null)
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
            else
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c + '-' + each.Closed_Reason__c, each.TemplateId__c);
        }
        System.debug('All flow Ids'+mapOfTemplateMapping);
        for(Case eachCase : listOfCases){
            SMSJSON smsjsn = new SMSJSON();
            if(eachCase.Status == 'Closed'){
                System.debug('eachwo.status '+eachCase.status +'-Case');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachCase.status +'-Case'+'-'+eachCase.Closed_Reason__c);
            }else{
                System.debug('eachwo.status '+eachCase.status +'-Case');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachCase.status +'-Case');   
            }
            
           // smsjsn.mobiles = eachCase.Account.Contact_Number_Mobile__c;
            system.debug(UtilityClass.getContactNumber(eachCase.Account.Contact_Number_Mobile__c));
            smsjsn.mobiles=UtilityClass.getContactNumber(eachCase.Account.Contact_Number_Mobile__c);
            smsjsn.customerName = eachCase.Account.Name;
            smsjsn.caseNumber = eachCase.CaseNumber;
            smsjsn.ProductName = eachCase.Product_Family__c;
            smsjsn.Quantity = eachCase.quantity__c;
            smsjsn.Issue = eachCase.Problem__r.Name;
            smsjsn.closureNum = eachCase.Closure_Code__c;
            System.debug('JSON Case'+JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn));
            
        } 
    }
    public static void generateSMSContentForWorkOrders(Map<Id,WorkOrder> mapOfWorkOrders, String destination){
        System.debug('MSG Called3');
        System.debug('destination'+destination);

        List<WorkOrder> listOfWorkOrders = [Select Id,status,Case.CaseNumber,Owner.Name,owner.Phone,Account.Phone,Account.Name
                                            ,Account.Can_you_please_give_address_retail__c, Account.Town_Name__r.Name,Account.PinCode__c,Account.Contact_Number_Mobile__c 
                                            ,Account.State__c,Account.Country_fsl__c, case.Product_Name__c,case.Product_Family__c,case.Product__r.Name,case.Quantity__c,case.Problem__r.Name
                                            from WorkOrder
                                            where Id in: mapOfWorkOrders.keySet()];
        System.debug('listOfWorkOrders in SMS'+listOfWorkOrders);
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c ,Closed_Reason__c,Status__c,TemplateId__c from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            if(each.Closed_Reason__c == null)
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
            else
                mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c + '-' + each.Closed_Reason__c, each.TemplateId__c);    
        }
        System.debug('mapOfTemplateMapping'+mapOfTemplateMapping);
        for(WorkOrder eachwo : listOfWorkOrders){
            SMSJSON smsjsn = new SMSJSON();
            if(eachwo.Status == 'Closed'){
                System.debug('eachwo.status '+eachwo.status +'-WorkOrder');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachwo.status +'-WorkOrder'+'-'+eachwo.Closed_Reason__c);
            }else{
                System.debug('eachwo.status '+eachwo.status +'-WorkOrder');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachwo.status +'-WorkOrder');   
            }
            System.debug('Owner'+ eachwo.owner);
            System.debug('Owner number'+ eachwo.owner.Phone);
            System.debug('owner phone'+UtilityClass.getContactNumber(eachwo.owner.Phone));
            if(destination=='Contractor')
            smsjsn.mobiles = UtilityClass.getContactNumber(eachwo.owner.Phone);
            else
            smsjsn.mobiles=UtilityClass.getContactNumber(eachwo.Account.Contact_Number_Mobile__c);
            
            smsjsn.customerName = eachwo.Account.Name;
            smsjsn.caseNumber = eachwo.case.CaseNumber;
            smsjsn.contractorName = eachwo.Owner.Name;
            smsjsn.contractorNumber = eachwo.Owner.Phone;
           // smsjsn.custPhone = eachwo.Account.Contact_Number_Mobile__c;
            System.debug('utility method'+UtilityClass.getContactNumber(eachwo.Account.Contact_Number_Mobile__c));
            smsjsn.custPhone=UtilityClass.getContactNumber(eachwo.Account.Contact_Number_Mobile__c);
            smsjsn.custAddress = eachwo.Account.Can_you_please_give_address_retail__c +','+eachwo.Account.Town_Name__r.Name +','+eachwo.Account.PinCode__c +','+eachwo.Account.State__c +','+eachwo.Account.Country_fsl__c;
            smsjsn.Issue = eachwo.case.Problem__r.Name;
            smsjsn.Quantity = eachwo.case.Quantity__c;
            smsjsn.ProductName = eachwo.case.Product_Family__c;
            System.debug('JSON WO'+JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn));
            
        } 
    }
    public static void generateSMSContentForAssignedResource(Map<Id,AssignedResource> mapOfAssignedResource){
        List<AssignedResource> listOfARs = [Select Id,ServiceAppointment.status,serviceAppointment.AppointmentNumber ,ServiceResource.Name,ServiceResource.RelatedRecord.Phone,ServiceAppointment.SchedStartTime,  
                                            ServiceAppointment.Account.Name,ServiceAppointment.Account.Contact_Number_Mobile__c,
                                            ServiceAppointment.Account.Can_you_please_give_address_retail__c, ServiceAppointment.Account.Town_Name__r.Name,ServiceAppointment.Account.PinCode__c
                                            ,ServiceAppointment.Account.State__c,ServiceAppointment.Account.Country_fsl__c
                                            from AssignedResource 
                                            where Id in: mapOfAssignedResource.keySet()];
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c,Status__c,TemplateId__c
                                                           from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
        }
        for(AssignedResource eachAR : listOfARs){
            SMSJSON smsjsn = new SMSJSON();
            SMSJSON smsjsn2 = new SMSJSON();
            smsjsn.flow_id = mapOfTemplateMapping.get(eachAR.ServiceAppointment.status +'-ServiceAppointment');
            
            //smsjsn.mobiles = eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c;
            smsjsn.mobiles=UtilityClass.getContactNumber(eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c);
            smsjsn.customerName = eachAR.ServiceAppointment.Account.Name;
            smsjsn2.customerName = eachAR.ServiceAppointment.Account.Name;
           // smsjsn.plumberPhone = eachAR.ServiceResource.RelatedRecord.Phone;
            //smsjsn2.plumberPhone = eachAR.ServiceResource.RelatedRecord.Phone;
            smsjsn.plumberPhone = UtilityClass.getContactNumber(eachAR.ServiceResource.RelatedRecord.Phone);
            smsjsn2.plumberPhone= UtilityClass.getContactNumber(eachAR.ServiceResource.RelatedRecord.Phone);
            smsjsn.plumberName = eachAR.ServiceResource.Name;
            smsjsn2.plumberName = eachAR.ServiceResource.Name;
            smsjsn.scheduledDateTime = String.valueOf(eachAR.ServiceAppointment.SchedStartTime);
            smsjsn2.scheduledDateTime = String.valueOf(eachAR.ServiceAppointment.SchedStartTime);
            smsjsn.caseNumber = eachAR.serviceAppointment.AppointmentNumber;
            smsjsn2.caseNumber = eachAR.serviceAppointment.AppointmentNumber;
                //smsjsn.Issue = 
                //smsjsn.Quantity
                //smsjsn.ProductName
                //smsjsn2.Issue = 
                //smsjsn2.Quantity
                //smsjsn2.ProductName
            smsjsn.custAddress = eachAR.ServiceAppointment.Account.Can_you_please_give_address_retail__c +','+eachAR.ServiceAppointment.Account.Town_Name__r.Name +','+eachAR.ServiceAppointment.Account.PinCode__c +','+eachAR.ServiceAppointment.Account.State__c +','+eachAR.ServiceAppointment.Account.Country_fsl__c;
            smsjsn2.custAddress = eachAR.ServiceAppointment.Account.Can_you_please_give_address_retail__c +','+eachAR.ServiceAppointment.Account.Town_Name__r.Name +','+eachAR.ServiceAppointment.Account.PinCode__c +','+eachAR.ServiceAppointment.Account.State__c +','+eachAR.ServiceAppointment.Account.Country_fsl__c;
            //smsjsn.custPhone = eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c;
            smsjsn.custPhone=UtilityClass.getContactNumber(eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c);
           // smsjsn2.custPhone = eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c; 
            smsjsn2.custPhone=UtilityClass.getContactNumber(eachAR.ServiceAppointment.Account.Contact_Number_Mobile__c);
            //smsjsn2.mobiles = eachAR.serviceResource.RelatedRecord.Phone;
            smsjsn2.mobiles=UtilityClass.getContactNumber(eachAR.serviceResource.RelatedRecord.Phone);
            smsjsn2.flow_id = mapOfTemplateMapping.get(eachAR.ServiceAppointment.status +'-AssignedResource');
            System.debug('JSON Assigned Res'+JSON.serialize(smsjsn));
            System.debug('JSON Assigned Res 2'+JSON.serialize(smsjsn2));
            sendSMS(JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn2));
            
        } 
    }
    public static void generateSMSContentForServiceAppointment(Map<Id,ServiceAppointment> mapOfSAs,String user){
        List<ServiceAppointment> listOfSAs = [Select Id,schedStartTime,AppointmentNumber,Account.Contact_Number_Mobile__c,status,owner.Name,Owner.Phone,Account.name
                                            from ServiceAppointment 
                                            where Id in: mapOfSAs.keySet()];
        System.debug('SAs'+listOfSAs);
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c,Status__c,TemplateId__c
                                                           from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
        }
        for(ServiceAppointment sa : listOfSAs){
            SMSJSON smsjsn = new SMSJSON();
            smsjsn.flow_id = mapOfTemplateMapping.get(sa.status +'-ServiceAppointment');
            System.debug('Mobile'+sa.Account.Contact_Number_Mobile__c);
            if(user == 'Customer') 
             smsjsn.mobiles=UtilityClass.getContactNumber(sa.Account.Contact_Number_Mobile__c);
            else
            smsjsn.mobiles = UtilityClass.getContactNumber(sa.Owner.Phone);
            smsjsn.customerName = sa.Account.Name;
            smsjsn.plumberPhone = UtilityClass.getContactNumber(sa.owner.Phone);
            smsjsn.caseNumber= sa.AppointmentNumber;
            smsjsn.plumberName = sa.owner.Name;
            smsjsn.scheduledDateTime = String.valueOf(sa.schedStartTime);
            System.debug('JSON Service App'+JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn));
            
        } 
    }
    public static void generateSMSContentForServiceAppointmentBatch(Map<Id,ServiceAppointment> mapOfSAs, String day){
        List<ServiceAppointment> listOfSAs = [Select Id,schedStartTime,Account.Contact_Number_Mobile__c,status,owner.Name,Owner.Phone,Account.name
                                            from ServiceAppointment 
                                            where Id in: mapOfSAs.keySet()];
        System.debug('SAs'+listOfSAs);
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c,Status__c,TemplateId__c
                                                           from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
        }
        for(ServiceAppointment sa : listOfSAs){
            SMSJSON smsjsn = new SMSJSON();
            if(day == 'Day Batch')
            smsjsn.flow_id = mapOfTemplateMapping.get('Day Batch' +'-ServiceAppointment');
            else
            smsjsn.flow_id = mapOfTemplateMapping.get('Before Day Batch' +'-ServiceAppointment');
            
            smsjsn.mobiles = UtilityClass.getContactNumber(sa.Owner.Phone);
            smsjsn.customerName = sa.Account.Name;
            smsjsn.plumberPhone = UtilityClass.getContactNumber(sa.Owner.Phone);
            smsjsn.plumberName = sa.owner.Name;
            smsjsn.scheduledDateTime = String.valueOf(sa.schedStartTime);
            System.debug('JSON Service App'+JSON.serialize(smsjsn));
            sendSMSBatch(JSON.serialize(smsjsn));
            
        } 
    }
    public static void generateSMSContentForWarranty(Map<Id,Asset> mapOfAsset){
        List<Asset> listOfAsset = [Select Id,Verification__c,Messaging_Session__c,Name,AccountId,Account.Contact_Number_Mobile__c,Contact_Number__c,Account.Name 
                                  from Asset 
                                  where Id in: mapOfAsset.keySet()];
        
        Map<String,String> mapOfTemplateMapping = new Map<String,String>();
        List<SMSMetaData__mdt> listOfSMSTemplateMapping = [select Id,Object_Name__c,Closed_Reason__c,Status__c,TemplateId__c
                                                           from SMSMetaData__mdt];
        for(SMSMetaData__mdt each : listOfSMSTemplateMapping){
            mapOfTemplateMapping.put(each.Status__c + '-' + each.Object_Name__c, each.TemplateId__c);
        }
        for(Asset eachAsset : listOfAsset){
            if(eachAsset.AccountId!=null && eachAsset.Messaging_Session__c==null){
            SMSJSON smsjsn = new SMSJSON();
            if(eachAsset.Verification__c == 'Already Present'){
             smsjsn.flow_id = mapOfTemplateMapping.get(eachAsset.Verification__c +'-Asset');
            }else{
                System.debug('eachwo.status '+eachAsset.Verification__c +'-Case');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachAsset.Verification__c +'-Asset');   
            }
            
           // smsjsn.mobiles = eachCase.Account.Contact_Number_Mobile__c;
            system.debug(UtilityClass.getContactNumber(eachAsset.Account.Contact_Number_Mobile__c));
            smsjsn.mobiles=UtilityClass.getContactNumber(eachAsset.Account.Contact_Number_Mobile__c);
            smsjsn.customerName = eachAsset.Name;
           
            System.debug('JSON Case'+JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn));
            }
            else
                if(eachAsset.Messaging_Session__c!=null){
                    SMSJSON smsjsn = new SMSJSON();
            if(eachAsset.Verification__c == 'Already Present'){
             smsjsn.flow_id = mapOfTemplateMapping.get(eachAsset.Verification__c +'-Asset');
            }else{
                System.debug('eachwo.status '+eachAsset.Verification__c +'-Case');
                smsjsn.flow_id = mapOfTemplateMapping.get(eachAsset.Verification__c +'-Asset');   
            }
            
           // smsjsn.mobiles = eachCase.Account.Contact_Number_Mobile__c;
            system.debug(UtilityClass.getContactNumber(eachAsset.Contact_Number__c));
            smsjsn.mobiles=UtilityClass.getContactNumber(eachAsset.Contact_Number__c);
            smsjsn.customerName = eachAsset.Name;
           
            System.debug('JSON Case'+JSON.serialize(smsjsn));
            sendSMS(JSON.serialize(smsjsn));
                }
        } 
        
    }

    @future(callout=true)
    public static void sendSMS(String jsonBody){
        List<SMS99_Endpoints__c > smsEndpoints = SMS99_Endpoints__c.getall().values();
        
        Map<String,String> headerMap = new Map<String, String>();
        if(!smsEndpoints.isEmpty()){
        headerMap.put('authkey',smsEndpoints[0].Api_Key__c);
        headerMap.put('Content-Type', 'application/json');
        
        HttpResponse res = HttpCalloutRequestClass.httpRequest('POST', smsEndpoints[0].Endpoint__c, headerMap, jsonBody, 2000);
        }
        //System.debug('response'+res);
    }
   
    public static void sendSMSBatch(String jsonBody){
        List<SMS99_Endpoints__c > smsEndpoints = SMS99_Endpoints__c.getall().values();
        Map<String,String> headerMap = new Map<String, String>();
        headerMap.put('authkey',smsEndpoints[0].Api_Key__c);
        headerMap.put('Content-Type', 'application/json');
        HttpResponse res = HttpCalloutRequestClass.httpRequest('POST', smsEndpoints[0].Endpoint__c, headerMap, jsonBody, 2000);
        System.debug('res'+res);
    }
    public class SMSJSON{
        public String mobiles;
        public String flow_id;
        public String customerName;
        public String caseNumber;
        public String scheduledDateTime;
        public String ProductName;
        public String Quantity;
        public String Issue;
        public String custAddress;
        public String contractorNumber;
        public String contractorName;
        public String custPhone;
        public String plumberPhone;
        public String plumberName;
        public String closureNum;
    }
}
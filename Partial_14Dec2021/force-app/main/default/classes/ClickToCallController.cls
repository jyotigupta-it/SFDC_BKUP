public without sharing class ClickToCallController {

    @AuraEnabled
    public static String clickToCall(Id recordId){
        System.debug('Click to call');
        String myIdPrefix = String.valueOf(recordId).substring(0,3);
        String customerPhone;
        String errorMsg;
        List<WorkOrder> listOfWorkOrders = new List<WorkOrder>();
        List<Case> listOfCase = new List<Case>();
        Task t1=new Task();
        if(myIdPrefix == '0WO'){ 
            listOfWorkOrders = [Select id, Account.Contact_Number_Mobile__c from WorkOrder where Id =: recordId];
            customerPhone = listOfWorkOrders[0].Account.Contact_Number_Mobile__c;
            customerPhone = customerPhone != null ? customerPhone.removeStart('+91').trim() : '';
            t1.WhatId=listOfWorkOrders[0].id;
        } else if(myIdPrefix == '500'){
            listOfCase = [Select id, Account.Contact_Number_Mobile__c from Case where Id =: recordId];
            customerPhone = listOfCase[0].Account.Contact_Number_Mobile__c;
            customerPhone = customerPhone != null ? customerPhone.removeStart('+91').trim() : '';
            t1.WhatId=listOfCase[0].id;
        }
        
        t1.Subject='call to customer';
        insert t1;
        List<Task> listOfTask=new List<task>();
        if(listOfWorkOrders.size()>0)
            listOfTask=[Select WhatId,CallDisposition from Task where WhatId =: listOfWorkOrders[0].id ];
         Integer counter=0;
            if(!listOfTask.isEmpty()){
                if(listOfTask.size()>=2){
                    for(Task t:listOfTask){
                       
                        if(t.CallDisposition=='No Response'){
                         counter= counter+1;  
                        }
                        
                    }
                }
            }
        if(counter==2){
            WorkOrder w=new WorkOrder();
            w.id=listOfWorkOrders[0].id;
            w.Called_3_times__c=true;
            update w;
        }
        User currentUser = [Select Id, Phone from User where Id =: UserInfo.getUserId()];
        String currentUserPhone = currentUser.Phone != null ? currentUser.Phone.removeStart('+91').trim() : '';
        if(customerPhone != null && customerPhone != '' && currentUserPhone != null && currentUserPhone != ''){
        	AmeyoCalloutService.dialAmeyo(customerPhone, currentUserPhone, t1.Id);
        } else if(customerPhone == ''){
            errorMsg = 'Customer Phone number is missing. Please update customer phone on Account level.';
            return errorMsg;
        } else if(currentUserPhone == ''){
            errorMsg = 'Your Phone number is missing. Please update you phone on User level.';
            return errorMsg;
        }
        return t1.Id;
        
    }
    
    @AuraEnabled
    public static void saveCallResult(String taskId, String disposition, String comments){
        System.debug('taskId: '+taskId);
        Task tsk = new Task();
        tsk.Id = taskId;
        tsk.CallDisposition = disposition;
        tsk.Description = comments;
        update tsk;
    }
    
}
trigger TaskTrigger on Task (before insert,before update) {

    String enquiry_prefix = Schema.SObjectType.Enquiry__c.getKeyPrefix();
  

    Set<Id> ids = new Set<Id>();
        for(Task tk : trigger.new)
        {
            ids.add(tk.WhatId);
        }

        if(ids.size()!=0 || ids != null){
    Map<Id,Enquiry__c> enq = new Map<Id,Enquiry__c>([SELECT id,Source__c,Enquiry_Date__c,Mobile__c,Email__c,Name,Relatedtotype__c,Product__c from Enquiry__c where id IN : ids]);
   Map<Id,Account> acc = new Map<Id,Account>([SELECT id from Account where id IN : ids]);
    Map<Id,Promotions__c> prm = new Map<Id,Promotions__c>([SELECT id, RelatedtoType__c from Promotions__c where id IN : ids]);
  
    for(Task tk : trigger.new)
        try
        {
        
           if(tk.WhatId!=null)
           {  
               
                   if( string.valueOf(tk.WhatId).startsWith('a01') ){
                tk.Mobile__c=enq.get(tk.WhatId).Mobile__c;   
                tk.Email_Address__c= enq.get(tk.WhatId).Email__c;        
               tk.Source__c=enq.get(tk.WhatId).Source__c;
               tk.Products__c= enq.get(tk.WhatId).Product__c; 
               tk.Related_To_Type__c=enq.get(tk.WhatId).Relatedtotype__c;
               tk.ActivityDate=(enq.get(tk.WhatId).Enquiry_Date__c)+3;      //addded by SudhaMurthy for due date to be populated from Enquiry date
              
             }
             else if(string.valueOf(tk.WhatId).startsWith('001') ){
             
            //tk.Related_To_Type__c=acc.get(tk.WhatId).Relatedtotype__c;
          }
            else if(string.valueOf(tk.WhatId).startsWith('a0A') ){
             
             tk.Related_To_Type__c=prm.get(tk.WhatId).Relatedtotype__c;
          }
       } 
       }
        catch(Exception e)
        {
        system.debug('exceprion...........'+e);
        }
        }
}
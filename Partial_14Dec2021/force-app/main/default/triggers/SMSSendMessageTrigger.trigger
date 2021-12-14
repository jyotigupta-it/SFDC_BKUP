trigger SMSSendMessageTrigger on Branding_Request__c (before update) {
    
    
    List<Branding_Request__c> brobj = new    List<Branding_Request__c>();
   
    string msgTemp= 'Branding Request for @ShopName has not been acted by @RBM. Request created By @CreatedBy on @CreatedDate';
  
    if(Trigger.isBefore && Trigger.isUpdate){
       
       system.debug('Example testing'); 
        // Escalated to BH
       set<Id> s= new Set<Id>();
           
              for(Branding_Request__c b : Trigger.New){
                  s.add(b.id);
              }
                  
       brobj= [select id,Shop_Name__r.Name,CreatedDate,SMS_Sent__c,RBM_Name__c,Escalated_To_Branding_Head__c,BH_Mobile__c,CreatedBy.name from Branding_Request__c where id in: s ];   
       Map<Id,Branding_Request__c> mapbrd=new Map<Id,Branding_Request__c>();
       for(Branding_Request__c b:brobj){
           if(mapbrd.containsKey(b.id)){
               mapbrd.put(b.id,b);
           }else{
               mapbrd.put(b.id,b);
           }
       }
              
              
              for(Branding_Request__c b : Trigger.New){
                     
                   Branding_Request__c temp=mapbrd.get(b.Id);
               
                    if(b.Escalated_To_Branding_Head__c && temp.SMS_Sent__c==false){
             				System.debug('========');
                        	System.debug(temp);
                        System.debug('=========');
                           String msg= msgTemp.replace('@ShopName', temp.Shop_Name__r.Name);
                           
                            msg= msg.replace('@RBM',temp.RBM_Name__c);
                            msg=msg.replace('@CreatedBy',string.valueOf(temp.CreatedBy.name));
                            msg= msg.replace('@CreatedDate',string.valueOf(temp.CreatedDate.format('dd/MMM/yyyy HH:mm:ss')));
                        
                            String msgEncoded= EncodingUtil.urlEncode(msg, 'UTF-8');
                            BrandingSMS__c bsms = BrandingSMS__c.getvalues('Switchingoff');
                            boolean isOff = bsms.Turnoff__c;
                            System.debug('isOff='+isOff);
                            if(isOff){
                            SendSMSController.sendMessage(temp.BH_Mobile__c, msgEncoded);
                        
                            system.debug('entered the method');
                  
                            b.SMS_Sent__c = true; 
                        }
                    }
              
              }

       }
    
}
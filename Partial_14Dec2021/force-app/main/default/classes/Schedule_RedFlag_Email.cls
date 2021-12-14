/********************************************XXX**********************************************************

Developer       : Subhajit Ghosh
Company         : KVP Business Solutions
Created Date    : 05-08-2019
Description     : Scheduler class that sends email to the project owner manager when the red flag is raised if the stage of the project
                  remains unchanged for many days. It fires if the lead status is active and the Project_Status_Flag_Value__c
                  value is 2.
Test:            Schedule_RedFlag_Test
**********************************************XXX*********************************************************/
global class Schedule_RedFlag_Email implements Schedulable {
    global Map<Id,String> mapProjectIdManagerName=new Map<Id,String>();
    global String domainLabel=System.Label.Domain_Name_SPR;
    global void execute(schedulablecontext sc){
        Map<id,Opportunity> mapOpportunity=new Map<id,Opportunity>();
        List<Opportunity> oppList=new List<Opportunity>();
        oppList=[SELECT id,Name,Lead_Status__c,StageName,Project_Status_Flag_Value__c,Owner.ManagerId,Owner.Manager_Email__c,Owner.Manager.Name 
                 FROM Opportunity where Project_Status_Flag_Value__c=:2 AND Lead_Status__c='Active'];
        if(oppList.size()>0){
            for(Opportunity opp:oppList){
                mapOpportunity.put(opp.id,opp);
                mapProjectIdManagerName.put(opp.id,opp.Owner.Manager.Name);
            } 
        }
        
        if(mapOpportunity.size()>0){
            sendmail(mapOpportunity);
        }
    }
    
    public void sendmail(Map<Id,opportunity> oppMap)
    {
        
        try{
            
             List<string> addressList = new List<String>();
        for(Id idKey:oppMap.keySet()){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           
            email.setSubject(oppMap.get(idKey).Name +'-Red flag raised');
           // String s = 'A red flag has been raised in project - :'+oppMap.get(idKey).Name+ 'The stage - '+oppMap.get(idKey).StageName+ ' remains unchanged for quite a long. Please check.';
           
            
            if(oppMap.get(idKey).Owner.Manager_Email__c != null){
                addressList.add(oppMap.get(idKey).Owner.Manager_Email__c);
                  }
            system.debug('addressList-->'+addressList);
            
            if(!addressList.isEmpty()){
                
                email.setHtmlBody( 'Dear '+mapProjectIdManagerName.get(idKey)+','+ '<br/>' +'<br/>' + 'A red flag has been raised in project- '+'<b>'+oppMap.get(idKey).Name+'<b/>'+' .'+'<br/>'+'<br/>'+
                'The stage - '+oppMap.get(idKey).StageName+ ' remains unchanged for quite a long.'+
                '<br/>' + 'Please take required actions.'+'<br/>'+'<a href=" '+domainLabel+'/'+oppMap.get(idKey).id+' ">'+oppMap.get(idKey).Name+'</a>'+'<br/>'+'<br/>'+'Thank You,'+'<br/>'+'System Admin'+'<br/>'+'This is a auto-generated email. Please do not reply.'
                 );

                email.setToAddresses(addressList);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email}); 
            }
            
        }
        
    }
        catch(exception e){
            system.debug('an exception occured while sending emails---'+e.getMessage());
            
        }
            
        }
       
    
}
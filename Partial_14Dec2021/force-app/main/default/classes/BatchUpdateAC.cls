global class BatchUpdateAC implements Database.Batchable<sobject>{
    
   PRIVATE STATIC FINAL BOOLEAN LOG_THIS_CLASS = TRUE;


 global string query ;
    
global database.querylocator start(Database.BatchableContext BC){
      query = 'Select Id,AccountCreatedDate__c,ownerid, Name,Status__c From Account'  ;
     
            return Database.getQueryLocator(query);
}

global void execute(Database.BatchableContext BC,List<Account> Scope){
Integer numberDaysDue,numberDaysDue2;
set<Id> accountsID=new set<Id>();
set<Id> ownersID=new set<Id>();
for (Account ac:Scope){
accountsID.add(ac.ID);
ownersID.add(ac.OwnerId);
}

Map<ID,Target__c > tmap = new Map<ID,Target__c >();
 
 for (Target__c t:[select ownerid,Start_Date__c,New_dealers_activation_Actual__c From Target__c where ownerid In:ownersID]){
  tmap.put(t.ownerid,t);
  }
  
  Map<ID,order> omap = new Map<ID,order>();
  List<order> oderList=new List<order>();
  for(order o:[select accountId,EffectiveDate from order where accountId In: accountsID]){
  
  omap.put(o.accountId,o);
  
  }
  
   system.debug('**********************omap********************');
  system.debug(omap);
  
  
  List<Account> toUpdateAccountList=new List<Account>();
  List<Target__c> targetListUpdate=new List<Target__c>();
                for(Account acc:scope){
                if(omap.get(acc.Id)!=null && acc.AccountCreatedDate__c!=null){
                 try{
                date targetCreatedDate;
                date    orderstartDate;
                orderstartDate=omap.get(acc.Id).EffectiveDate;
                if(tmap.get(acc.ownerId).Start_Date__c!=null){
                targetCreatedDate=tmap.get(acc.ownerId).Start_Date__c;
                 }
                else{
                 targetCreatedDate=tmap.get(acc.ownerId).Start_Date__c;
                }
               
               Integer d = acc.AccountCreatedDate__c.day();
                Integer mo = acc.AccountCreatedDate__c.month();
                Integer yr = acc.AccountCreatedDate__c.year();

                Date dte= Date.newInstance(yr, mo, d);

              numberDaysDue =dte.daysBetween(orderstartDate);
              numberDaysDue2=orderstartDate.daysBetween(targetCreatedDate);
               
                 system.debug('The Status');
                 
                    if( (numberDaysDue)>180 ){
                     acc.status__c='Prospective';
                        toUpdateAccountList.add(acc);
                          system.debug('The Status has been changed to Prospective');
                    if( tmap.get(acc.ownerId)!=null ){
                       if( (numberDaysDue2)>31 ){
                        tmap.get(acc.ownerId).New_dealers_activation_Actual__c=0;
                        targetListUpdate.add(tmap.get(acc.ownerId));
                        }
                        }
                       
                    }
                    else {
                      acc.status__c='Existing'; //Existing
                          toUpdateAccountList.add(acc);
                        
                         system.debug('The Status has been changed Existing');
                     if( tmap.get(acc.ownerId)!=null ){
                     if((numberDaysDue2)<31) {
                        tmap.get(acc.ownerId).New_dealers_activation_Actual__c=1;
                          targetListUpdate.add(tmap.get(acc.ownerId));
                        
                        }
                        }
                      
                    }
                    
                    
                    
                    }
                    
                    catch(Exception exc){
                    system.debug('The Error is :'+exc.getMessage()+'in Line Number'+exc.getLineNumber());
                    }
                    }
                }
                
               // update toUpdateAccountList;
                //update targetListUpdate;
                 system.debug(targetListUpdate);
  }


    
     
     public void finish(Database.BatchableContext BC){
  
   }


    }
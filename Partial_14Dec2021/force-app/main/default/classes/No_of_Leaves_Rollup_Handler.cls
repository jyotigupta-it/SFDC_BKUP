/*************************************
* Created by:SudhaMurthy
* Trigger:AdoptedPlumberAndDealer
* Description:Trigger handler to count no of leave record on Target object(parent)
* Field to rollup:
**************************************/ 

public class No_of_Leaves_Rollup_Handler {
    public static void leavemethod(list<AP_Site_Visit__c> newvisit){
        map<id,integer> visitmapcount = new map<id,integer>();
        map<string,list<Date>> datemap= new  map<string,list<Date>>();
        set<Id> parentIDSet = new set<Id>(); 
        try{
            for(AP_Site_Visit__c ap : newvisit) {
                parentIDSet.add(ap.Target__c);
            }
            List<AP_Site_Visit__c> newvisitlist = new List<AP_Site_Visit__c>();
            newvisitlist = [SELECT id ,Name,Target__c,Leave_Date__c from AP_Site_Visit__c where Target__c IN:parentIDSet and Othet_Activities__c ='leave' ];
            if(newvisitlist!=null){
                for(AP_Site_Visit__c ap:newvisitlist){
                    string uniquekey= ap.Target__c+'@'+ap.Leave_Date__c;
                    
                    if(visitmapcount!=null && visitmapcount.containsKey(ap.Target__c) && visitmapcount.get(ap.Target__c)!=null){
                        visitmapcount.put(ap.Target__c,visitmapcount.get(ap.Target__c)+1);
                        
                        datemap.get(ap.Target__c).add(ap.Leave_Date__c);
                        system.debug('map............if'+visitmapcount.get(ap.Target__c));
                        // visitmapcount.put(ap.Target__c, 1); new list<string>
                        
                    }else{
                        visitmapcount.put(ap.Target__c,1);
                        datemap.put(ap.Target__c,new list<date> {ap.Leave_Date__c   });
                        system.debug('map............else'+visitmapcount.get(ap.Target__c));
                        
                        //visitmapcount.put(ap.Target__c, visitmapcount.get(ap.Target__c) + 1);
                    }
                    
                    
                }
            }
            system.debug('value...'+datemap.values());
            system.debug('map-----leave---->'+visitmapcount);
            list<target__C> targetlisttoupdate= new list<target__C>();
           /**** Map<Id, String> mapToHoldPreviousLeaveVal = new Map<Id, String>();
            for(target__C tar : [SELECT Id, Leave_date__c FROM target__C WHERE Id IN: parentIDSet AND Leave_date__c != null]) {
                System.debug('tar---- ' + tar.Leave_date__c);
                mapToHoldPreviousLeaveVal.put(tar.Id, tar.Leave_date__c);
            }****/
            for(ID ids:visitmapcount.Keyset()){               
                target__c t= new target__C();
                t.id=ids;
                t.Leave_Actual__c=visitmapcount.get(ids);
                //t.Leave_date__c = mapToHoldPreviousLeaveVal.get(ids) + '\n' +String.join(datemap.get(ids), '\n');
                targetlisttoupdate.add(t);
            }
            //system.debug('count.map.......'+visitmapcount.get(ids));
            //system.debug('count........'+t.Leave_Actual__c);
            if(!targetlisttoupdate.isempty()){
                
                update targetlisttoupdate;
                
            }    
        }catch(System.Exception e){
            system.debug('exception---->'+e+'line...' +e.getLineNumber());
        }       
    }
    public static void leaveupdatemethod(list<AP_Site_Visit__c> oldvisitlist){
        map<id,integer> visitmapcount = new map<id,integer>();
        
        set<id> visitset2= new set<id>();
        try{
            if(!oldvisitlist.isempty() && oldvisitlist!=null){
                for(AP_Site_Visit__c apvisitold :oldvisitlist) {
                    if(apvisitold.Target__c!=null){
                        if(visitmapcount.containsKey(apvisitold.Target__c)){
                            visitmapcount.put(apvisitold.Target__c,visitmapcount.get(apvisitold.Target__c)+1);
                        }
                        else{
                            visitmapcount.put(apvisitold.Target__c,1);
                        }
                        /*visitset2.add(apvisitold.target__C);
                        system.debug('old visit........'+oldvisitlist);
                        system.debug('visitset2........'+visitset2);*/
                    }
                }
            } 
            list<Target__c> targetList = new list<Target__c>();
            for(Target__c tg : [SELECT Id, Leave_Actual__c FROM Target__c where Id in : visitmapcount.keySet()]){
                tg.Leave_Actual__c = tg.Leave_Actual__c - visitmapcount.get(tg.Id);
                targetList.add(tg);
            }
            if(!targetList.isEmpty()){
                update targetList;
            }
            /*if(visitset2!=null){
                List<AP_Site_Visit__c> newvisitlist = [SELECT id ,Name,Target__c,Othet_Activities__c from AP_Site_Visit__c where Target__c IN:visitset2 and Othet_Activities__c ='leave' ];
                system.debug('newvisitlist........'+newvisitlist);
                
                if(newvisitlist!=null){
                    for(AP_Site_Visit__c ap:newvisitlist){
                        
                        if(visitmapcount!=null && visitmapcount.containsKey(ap.target__C) && visitmapcount.get(ap.Target__c)!=null){
                            visitmapcount.put(ap.target__C,visitmapcount.get(ap.Target__c)+1);
                            system.debug('map............if update'+visitmapcount.get(ap.Target__c));
                            // visitmapcount.put(ap.Target__c, 1);
                            
                        }else{
                            visitmapcount.put(ap.Target__c,1);
                            system.debug('map............else update'+visitmapcount.get(ap.Target__c));
                            //visitmapcount.put(ap.Target__c, visitmapcount.get(ap.Target__c) + 1);
                        }
                        
                        
                    }
                }
            }
            system.debug('map-----leave---update->'+visitmapcount);
            list<target__C> targetlisttoupdate= new list<target__C>();
            for(ID ids:visitmapcount.Keyset()){
                target__c t= new target__C();
                t.id=ids;
                t.Leave_Actual__c=visitmapcount.get(ids);
                targetlisttoupdate.add(t);
                system.debug('count.map.......'+visitmapcount.get(ids));
                system.debug('count........'+t.Leave_Actual__c);
            }
            if(!targetlisttoupdate.isempty()){
                
                update targetlisttoupdate;  
            }    */
        }catch(System.Exception e){
            system.debug('exception---->'+e);
        }       
    }
    
}
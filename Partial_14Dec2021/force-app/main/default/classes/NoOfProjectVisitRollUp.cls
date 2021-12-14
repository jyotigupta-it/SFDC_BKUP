/***************************************************
 * Name:SudhaMurthy
 * Description: class to create rollup  count of visits on target
 * Trigger:AdoptedPlumberAndDealer 
 * Test class:Test_RollupInfluencerVisitsColumn
 * created date :12/08/2019***********************/

public class NoOfProjectVisitRollUp{
      
    public static void noofvisitmethod(list<AP_Site_Visit__c> visitlist){
        list<target__c> newtargetlisttoupdate = new list<target__C>();
        system.debug('test for trigegr.new........'+visitlist);
        
        
        set<id> visitset= new set<id>();
        if(!visitlist.isempty() && visitlist!=null){
            for(AP_Site_Visit__c apvisit :visitlist) {
                if(apvisit.target__C!=null){
                    visitset.add(apvisit.target__C);
                    system.debug('test for set after insert........'+visitset);
                }
            }
        }  
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,No_of_Visits_Actual_Project__c,(select id,name,RecordType.id,Vertical__c from AP_Site_Visits__r where RecordType.id='01230000001DPvu') from Target__C where id in:visitset  limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.No_of_Visits_Actual_Project__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
    
      public static void noofvisitmethodupdate(list<AP_Site_Visit__c> oldvisitlist){
         list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        if(!oldvisitlist.isempty() && oldvisitlist!=null){
                for(AP_Site_Visit__c apvisitold :oldvisitlist) {
                    if(apvisitold.Target__c!=null){
                    visitset2.add(apvisitold.target__C);
                    system.debug('test for set after update........'+oldvisitlist);
                    }
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,No_of_Visits_Actual_Project__c,(select id,name,RecordType.id,Vertical__c from AP_Site_Visits__r where RecordType.id='01230000001DPvu') from Target__C where id in:visitset2  limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.No_of_Visits_Actual_Project__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
}
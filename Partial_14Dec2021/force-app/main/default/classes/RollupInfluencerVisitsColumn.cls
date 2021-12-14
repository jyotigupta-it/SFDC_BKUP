/***************************************************
 * Name:SudhaMurthy
 * Description: class to create count of column visits except dealer and distributor visits
 * Trigger:AdoptedPlumberAndDealer 
 * created date :08/07/2019***********************/
 
 
public class RollupInfluencerVisitsColumn{
      
    public static void InfluencerVisitsColumnforupdate(list<AP_Site_Visit__c> visitlist,map<id,AP_Site_Visit__c> oldmap){
        list<target__c> newtargetlisttoupdate = new list<target__C>();
        system.debug('test for trigegr.ner........'+visitlist);
        //system.debug('test for trigegr.old........'+oldvisitlist);
        
        set<id> visitset= new set<id>();
        if(!visitlist.isempty() && visitlist!=null){
            for(AP_Site_Visit__c ap :visitlist) {
                if((ap.Actual_Created_Date__c!=oldmap.get(ap.id).Actual_Created_Date__c) ||  (ap.Actual_LastModified_Date__c!=oldmap.get(ap.id).Actual_LastModified_Date__c)){
                    
                   
                }else{
                    visitset.add(ap.target__C);
                }
            }
        }  
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_visit_actual_column__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='visits' AND (Party_type__c!='Dealer' AND Party_type__c!='Distributor') )  from Target__C where id in:visitset limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_visit_actual_column__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public static void InfluencerVisitsColumndelete(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_visit_actual_column__c,(select id,name,Purpose_of_Visit__c,Party_type__c,recordtype.name from AP_Site_Visits__r where recordtype.name='visits' AND (Party_type__c!='Dealer' AND Party_type__c!='Distributor')) from Target__C where id in:visitset2 limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_visit_actual_column__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
    public static void InfluencerVisitsColumn(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_visit_actual_column__c,(select id,name,Purpose_of_Visit__c,Party_type__c,recordtype.name from AP_Site_Visits__r where recordtype.name='visits' AND (Party_type__c!='Dealer' AND Party_type__c!='Distributor')) from Target__C where id in:visitset2 limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_visit_actual_column__c=targets.AP_Site_Visits__r.size();
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
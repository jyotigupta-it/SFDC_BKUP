/***************************************************
 * Name:SudhaMurthy
 * Description: class to create count  and sum of visits on target
 * Trigger:AdoptedPlumberAndDealer 
 * created date :22/22/2018***********************/



public class ProductiveVisitWithOrders {
      
    public static void neworderbooking(list<AP_Site_Visit__c> visitlist){
        list<target__c> newtargetlisttoupdate = new list<target__C>();
        system.debug('test for trigegr.ner........'+visitlist);
        //system.debug('test for trigegr.old........'+oldvisitlist);
        
        set<id> visitset= new set<id>();
        if(!visitlist.isempty() && visitlist!=null){
            for(AP_Site_Visit__c apvisit :visitlist) {
                if(apvisit.target__C!=null){
                    visitset.add(apvisit.target__C);
                    system.debug('test for set after insert........'+visitset);
                }
            }
        }  
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,visit_with_new_order_booking__c,(select id,name,Purpose_of_Visit__c,Order_Value__c,Othet_Activities__c from AP_Site_Visits__r where (Purpose_of_Visit__c='New Order Booking' or Othet_Activities__c='Post Visit Order') and Order_Value__c>0) from Target__C where id in:visitset limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.visit_with_new_order_booking__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
    public static void neworderbookingforupdate(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Actual_Created_Date__c!=oldmapvisit.get(apvisitold.id).Actual_Created_Date__c) || (apvisitold.Actual_LastModified_Date__c!=oldmapvisit.get(apvisitold.id).Actual_LastModified_Date__c)){
                    
                    
                    }else if(apvisitold.Target__c!=null){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,visit_with_new_order_booking__c,(select id,name,Purpose_of_Visit__c,Order_Value__c,Othet_Activities__c,Actual_Created_Date__c,Actual_LastModified_Date__c from AP_Site_Visits__r where (Purpose_of_Visit__c='New Order Booking' or Othet_Activities__c='Post Visit Order') and Order_Value__c>0) from Target__C where id in:visitset2 limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.visit_with_new_order_booking__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
        system.debug('newtargetlisttoupdate........'+newtargetlisttoupdate);
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            

    }   

    }
     public static void neworderbookingdelete(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,visit_with_new_order_booking__c,(select id,name,Purpose_of_Visit__c,Order_Value__c,Othet_Activities__c from AP_Site_Visits__r where (Purpose_of_Visit__c='New Order Booking' or Othet_Activities__c='Post Visit Order') and Order_Value__c>0) from Target__C where id in:visitset2 limit 999]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.visit_with_new_order_booking__c=targets.AP_Site_Visits__r.size();
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
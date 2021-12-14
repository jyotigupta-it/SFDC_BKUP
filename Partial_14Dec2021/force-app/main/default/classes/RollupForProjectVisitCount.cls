public class RollupForProjectVisitCount {
 //distributor insertion method
    Public  void projectVisitinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Distributor_projectVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void projectVisitdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void projectVisitupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
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
//dealer insert method
         Public  void projectVisitDealerinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Dealer_projectVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void projectVisitDealerdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset2 limit 999 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void projectVisitDealerupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset2]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
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
    //influencer insert method
         Public  void projectVisitInfluencerinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  (Party_type__c!='Dealer' AND Party_type__c!='Distributor'))  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Influencer_projectVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void projectVisitInfluencerdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  (Party_type__c!='Dealer' AND Party_type__c!='Distributor') )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void projectVisitInfluencerupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_projectVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='Project Visit' AND  (Party_type__c!='Distributor' AND party_type__c!='Dealer') )  from Target__C where id in:visitset2]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_projectVisit_Actual__c=targets.AP_Site_Visits__r.size();
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
    //distributor insertion method
    Public  void BrandingVisitinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Distributor_BrandingVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void BrandingVisitdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void brandingVisitupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Distributor_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Distributor' )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Distributor_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
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
//dealer insert method
         Public  void brandingVisitDealerinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Dealer_BrandingVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void brandingVisitDealerdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void brandingVisitDealerupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Dealer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  Party_type__c='Dealer' )  from Target__C where id in:visitset2]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Dealer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
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
    //influencer insert method
         Public  void brandingVisitInfluencerinsertmethod(list<AP_Site_Visit__c> visitlist){
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
           
        list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  (Party_type__c!='Dealer' AND Party_type__c!='Distributor'))  from Target__C where id in:visitset]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                system.debug('size........'+newtarget.Influencer_BrandingVisit_Actual__c);
                system.debug('size222........'+targets.AP_Site_Visits__r.size());
                newtargetlisttoupdate.add(newtarget);
                                
            }
        
         system.debug('list insert------------'+newtargetlisttoupdate);
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                system.debug('exception---->'+e);
                
            }    
            
        }
    }
    
      public  void brandingVisitInfluencerdeletemethod(list<AP_Site_Visit__c> oldvisitlist){
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
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  (Party_type__c!='Dealer' AND Party_type__c!='Distributor') )  from Target__C where id in:visitset2 ]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
                newtargetlisttoupdate.add(newtarget);
                                
            }
         
        if(!newtargetlisttoupdate.isempty() && newtargetlisttoupdate.size()>0 && newtargetlisttoupdate!=null){
            try{
            update newtargetlisttoupdate;
            }catch(System.Exception e){
                
            }    
            
        }

    }
     public  void brandingVisitInfluencerupdatemethod(map<id,AP_Site_Visit__c> oldmapvisit,list<AP_Site_Visit__c> newlist){
        
               list<target__c> newtargetlisttoupdate = new list<target__C>();
        set<id> visitset2= new set<id>();
        system.debug('newlist'+newlist);
        if(!newlist.isempty()){
                for(AP_Site_Visit__c apvisitold :newlist) {
                    system.debug('test new id'+apvisitold);
                    
                    if((apvisitold.Party_Type__c!=oldmapvisit.get(apvisitold.id).Party_Type__c)||(apvisitold.RecordType_Name__c!=oldmapvisit.get(apvisitold.id).RecordType_Name__c) ){
                        visitset2.add(apvisitold.target__C);
                    }
                    system.debug('set id'+visitset2);
                }
           } 
    
     list<Target__C> targetlist=  new list<target__C>([select id,name,Influencer_BrandingVisit_Actual__c,(select id,name,recordtype.name,Party_type__c from AP_Site_Visits__r where recordtype.name='brandingVist' AND  (Party_type__c!='Distributor' AND party_type__c!='Dealer') )  from Target__C where id in:visitset2]);
            for(Target__C targets:Targetlist){
                target__C newtarget = new target__C();
                newtarget.id= targets.id;
                newtarget.Influencer_BrandingVisit_Actual__c=targets.AP_Site_Visits__r.size();
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

}
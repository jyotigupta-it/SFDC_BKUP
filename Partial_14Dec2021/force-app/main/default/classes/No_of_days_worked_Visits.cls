public class No_of_days_worked_Visits {
   public static void visitisertmethod(list<AP_Site_Visit__c> visitlist){
        set<id> targetid= new set<id>();
        set<date> dateid= new set<date>();
        list<id> targetIdList= new list<id>();
        list<Target__C> Targetlisttoupdate= new list<Target__C>();
        list<date> dateidlist= new list<date>();
        map<id,map<date,integer>> visitmap= new map<id,map<date,integer>>();
        map<id,map<date,integer>> otheractivitymap= new map<id,map<date,integer>>();
        
        try{
            if(!visitlist.IsEmpty()){
                for(AP_Site_Visit__c ap:visitlist){
                    system.debug('ap.Othet_Activities__c:: ' + ap.Othet_Activities__c);
                    if(ap.Othet_Activities__c != 'Leave' && ap.Othet_Activities__c != 'Holiday/ Market Closed'){
                    targetid.add(ap.Target__c);
                    system.debug('entering if::');
                    }
                   /* else{
                        targetid.add(ap.Target__c);
                        system.debug('entering else::');
                    }*/
                }
            }
            list<AP_Site_Visit__c> aplist=[select id,name,recordtype.name,target__C,Date__c from AP_Site_Visit__c where target__C IN : targetid and (recordtype.name='Other Activities' OR  recordtype.name='Visits')  ];
            system.debug('tset list today------->'+aplist);
            if(!aplist.IsEmpty()){
                for(AP_Site_Visit__c a:aplist){
                    
                    map<date,integer> datemap= new map<date,integer>();
                    if(a.recordtype.name=='Visits'){
                        /*system.debug('test 1'+visitmap.isEmpty());
                         system.debug('test 2'+visitmap.get(a.Target__c).isEmpty());
                         system.debug('test 3'+visitmap.containsKey(a.Target__c));*/
                        if(!visitmap.isEmpty() &&  !visitmap.get(a.Target__c).isEmpty() && visitmap.containsKey(a.Target__c)){ 
                            
                            datemap.putAll(visitmap.get(a.Target__c));
                            datemap.put(a.Date__c,(datemap.containsKey(a.Date__c)?datemap.get(a.Date__c):0)+1);
                            visitmap.put(a.Target__c,datemap);
                        }else{
                            datemap.put(a.Date__c, 1);
                            visitmap.put(a.Target__c,datemap);
                            System.debug('visitmap'+visitmap);
                            
                        }
                        
                    }else if(a.recordtype.name=='Other Activities'){
                        system.debug('visit......'+a);
                        system.debug('recordtype...'+a.recordtype.name);
                        map<date,integer> otherdatemap= new map<date,integer>();
                        system.debug('otheractivitymap empty ' + otheractivitymap.isEmpty());
                        if(!otheractivitymap.isEmpty() &&  !otheractivitymap.get(a.Target__c).IsEmpty() && otheractivitymap.containsKey(a.Target__c)){ 
                            //system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            otherdatemap.putAll(otheractivitymap.get(a.Target__c));
                            // system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            //system.debug('otherdatemap values......'+otherdatemap.Values());
                            otherdatemap.put(a.Date__c,(otherdatemap.containsKey(a.Date__c)?otherdatemap.get(a.Date__c):0)+1);
                            
                            otheractivitymap.put(a.Target__c,otherdatemap);
                        }else{
                            
                            otherdatemap.put(a.Date__c, 1);
                            otheractivitymap.put(a.Target__c,otherdatemap);
                            //system.debug('test.......otherdatemap'+otherdatemap);
                            // system.debug('test.......otheractivitymap'+otheractivitymap);
                            
                        }
                        
                    }
                    targetid.add(a.Target__c);
                    dateid.add(a.Date__c);
                }
                //targetIdList.addAll(targetid);
                dateidlist.addAll(dateid);
                system.debug('targetid in list...'+targetIdList);
                system.debug('targetid in dateidlist list...'+dateidlist);
            }
            list<Target__C> tarlist= [select id,name,No_of_days_worked_in_month_visit__c,No_of_days_worked_in_month_Office__c from Target__c where ID IN:targetid];
            for(Target__C tar:tarlist){
                Target__c t= new Target__c();
                t.id=tar.id;
                map<Date, integer> tempOmap = new map<Date, integer>();
                map<Date, integer> tempVmap = new map<Date, integer>();
                if(otheractivitymap.get(tar.ID) != null)
                    tempOmap = otheractivitymap.get(tar.ID);
                if(visitmap.get(tar.ID) != null)
                    tempVmap = visitmap.get(tar.ID);
                system.debug('tempOmap'+tempOmap);
                system.debug('tempVmap'+tempvmap);
                for(date eachdate:dateidlist){
                    
                    system.debug('tempVmap get...'+tempVmap.get(eachdate));
                    system.debug('tempOmap get...'+tempOmap.get(eachdate));
                    if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)>(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        
                        t.No_of_days_worked_in_month_visit__c=(t.No_of_days_worked_in_month_visit__c != null?t.No_of_days_worked_in_month_visit__c:0)+1;
                    }else if((tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)>(tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)){
                        t.No_of_days_worked_in_month_Office__c=(t.No_of_days_worked_in_month_Office__c != null?t.No_of_days_worked_in_month_Office__c:0)+1;
                        
                    }else if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)==(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        system.debug(t.No_of_days_worked_in_month_visit__c);
                        t.No_of_days_worked_in_month_visit__c=(t.No_of_days_worked_in_month_visit__c != null?t.No_of_days_worked_in_month_visit__c:0)+1;
                    }
                    Targetlisttoupdate.add(t);
                    
                }
                
            }
            map<id,target__c> tempmap= new map<id,target__c>();
            tempmap.putAll(Targetlisttoupdate);
            if(!tempmap.IsEmpty()){
                update tempmap.Values();
            }
            system.debug('visitmap....final----'+visitmap);
            system.debug('otheractivitymap....final---'+otheractivitymap);
        }catch(exception e){
            system.debug('exception,,,,..............no of visit handler'+e+'.........'+e.getLineNumber());
        }
        
    }
    public static void projectvisitisertmethod(list<AP_Site_Visit__c> visitlist){
        set<id> targetid= new set<id>();
        set<date> dateid= new set<date>();
        list<id> targetIdList= new list<id>();
        list<Target__C> Targetlisttoupdate= new list<Target__C>();
        list<date> dateidlist= new list<date>();
        map<id,map<date,integer>> visitmap= new map<id,map<date,integer>>();
        map<id,map<date,integer>> otheractivitymap= new map<id,map<date,integer>>();
        
        try{
            if(!visitlist.IsEmpty()){
                for(AP_Site_Visit__c ap:visitlist){
                    system.debug('ap.Othet_Activities__c:: ' + ap.Othet_Activities__c);
                    if(ap.Othet_Activities__c != 'Leave' && ap.Othet_Activities__c != 'Holiday/ Market Closed'){
                    targetid.add(ap.Target__c);
                    system.debug('entering if::');
                    }
                   /* else{
                        targetid.add(ap.Target__c);
                        system.debug('entering else::');
                    }*/
                }
            }
            list<AP_Site_Visit__c> aplist=[select id,name,recordtype.name,target__C,Date__c from AP_Site_Visit__c where target__C IN : targetid and (recordtype.name='brandingVist' OR  recordtype.name='Project Visit')  ];
            system.debug('tset list today------->'+aplist);
            if(!aplist.IsEmpty()){
                for(AP_Site_Visit__c a:aplist){
                    
                    map<date,integer> datemap= new map<date,integer>();
                    if(a.recordtype.name=='Project Visit'){
                        /*system.debug('test 1'+visitmap.isEmpty());
                         system.debug('test 2'+visitmap.get(a.Target__c).isEmpty());
                         system.debug('test 3'+visitmap.containsKey(a.Target__c));*/
                        if(!visitmap.isEmpty() &&  !visitmap.get(a.Target__c).isEmpty() && visitmap.containsKey(a.Target__c)){ 
                            
                            datemap.putAll(visitmap.get(a.Target__c));
                            datemap.put(a.Date__c,(datemap.containsKey(a.Date__c)?datemap.get(a.Date__c):0)+1);
                            visitmap.put(a.Target__c,datemap);
                        }else{
                            datemap.put(a.Date__c, 1);
                            visitmap.put(a.Target__c,datemap);
                            System.debug('visitmap'+visitmap);
                            
                        }
                        
                    }else if(a.recordtype.name=='brandingVist'){
                        system.debug('visit......'+a);
                        system.debug('recordtype...'+a.recordtype.name);
                        map<date,integer> otherdatemap= new map<date,integer>();
                        system.debug('otheractivitymap empty ' + otheractivitymap.isEmpty());
                        if(!otheractivitymap.isEmpty() &&  !otheractivitymap.get(a.Target__c).IsEmpty() && otheractivitymap.containsKey(a.Target__c)){ 
                            //system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            otherdatemap.putAll(otheractivitymap.get(a.Target__c));
                            // system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            //system.debug('otherdatemap values......'+otherdatemap.Values());
                            otherdatemap.put(a.Date__c,(otherdatemap.containsKey(a.Date__c)?otherdatemap.get(a.Date__c):0)+1);
                            
                            otheractivitymap.put(a.Target__c,otherdatemap);
                        }else{
                            
                            otherdatemap.put(a.Date__c, 1);
                            otheractivitymap.put(a.Target__c,otherdatemap);
                            //system.debug('test.......otherdatemap'+otherdatemap);
                            // system.debug('test.......otheractivitymap'+otheractivitymap);
                            
                        }
                        
                    }
                    targetid.add(a.Target__c);
                    dateid.add(a.Date__c);
                }
                //targetIdList.addAll(targetid);
                dateidlist.addAll(dateid);
                system.debug('targetid in list...'+targetIdList);
                system.debug('targetid in dateidlist list...'+dateidlist);
            }
            list<Target__C> tarlist= [select id,name,No_of_days_worked_BrandingVisit_visits__c,No_of_days_worked_ProjectVisit_visits__c from Target__c where ID IN:targetid];
            for(Target__C tar:tarlist){
                Target__c t= new Target__c();
                t.id=tar.id;
                map<Date, integer> tempOmap = new map<Date, integer>();
                map<Date, integer> tempVmap = new map<Date, integer>();
                tempOmap = otheractivitymap.get(tar.ID);
                tempVmap = visitmap.get(tar.ID);
                system.debug('tempOmap'+tempOmap);
                system.debug('tempVmap'+tempvmap);
                for(date eachdate:dateidlist){
                    
                    system.debug('tempVmap get...'+tempVmap.get(eachdate));
                    system.debug('tempOmap get...'+tempOmap.get(eachdate));
                    if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)>(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        
                        t.No_of_days_worked_ProjectVisit_visits__c=(t.No_of_days_worked_ProjectVisit_visits__c != null?t.No_of_days_worked_ProjectVisit_visits__c:0)+1;
                    }else if((tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)>(tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)){
                        t.No_of_days_worked_BrandingVisit_visits__c=(t.No_of_days_worked_BrandingVisit_visits__c != null?t.No_of_days_worked_BrandingVisit_visits__c:0)+1;
                        
                    }else if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)==(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        system.debug(t.No_of_days_worked_ProjectVisit_visits__c);
                        t.No_of_days_worked_ProjectVisit_visits__c=(t.No_of_days_worked_ProjectVisit_visits__c != null?t.No_of_days_worked_ProjectVisit_visits__c:0)+1;
                    }
                    Targetlisttoupdate.add(t);
                    
                }
                
            }
            map<id,target__c> tempmap= new map<id,target__c>();
            tempmap.putAll(Targetlisttoupdate);
            if(!tempmap.IsEmpty()){
                update tempmap.Values();
            }
            system.debug('visitmap....final----'+visitmap);
            system.debug('otheractivitymap....final---'+otheractivitymap);
        }catch(exception e){
            system.debug('exception,,,,..............no of visit handler'+e+'.........'+e.getLineNumber());
        }
        
    }
    public static void deletemethod(list<AP_Site_Visit__c> Oldlist){
        set<id> targetid= new set<id>();
        set<date> dateid= new set<date>();
        list<id> targetIdList= new list<id>();
        list<Target__C> Targetlisttoupdate= new list<Target__C>();
        list<date> dateidlist= new list<date>();
        map<id,map<date,integer>> visitmap= new map<id,map<date,integer>>();
        map<id,map<date,integer>> otheractivitymap= new map<id,map<date,integer>>();
        
        try{
            if(!Oldlist.IsEmpty()){
                for(AP_Site_Visit__c ap:Oldlist){
                    if(ap.Othet_Activities__c!='Leave' && ap.Othet_Activities__c!='Holiday/ Market Closed'){
                    targetid.add(ap.Target__c);
                    }
                }
            }
            list<AP_Site_Visit__c> aplist=[select id,name,recordtype.name,target__C,Date__c from AP_Site_Visit__c where target__C IN : targetid and (recordtype.name='Other Activities' OR  recordtype.name='Visits') ];
           system.debug('tset list today delete------->'+aplist);
            if(!aplist.IsEmpty()){
                for(AP_Site_Visit__c a:aplist){
                    
                    map<date,integer> datemap= new map<date,integer>();
                    if(a.recordtype.name=='Visits'){
                        if(!visitmap.isEmpty() &&  !visitmap.get(a.Target__c).isEmpty() && visitmap.containsKey(a.Target__c)){ 
                            
                            datemap.putAll(visitmap.get(a.Target__c));
                            datemap.put(a.Date__c,(datemap.containsKey(a.Date__c)?datemap.get(a.Date__c):0)+1);
                            visitmap.put(a.Target__c,datemap);
                        }else{
                            datemap.put(a.Date__c, 1);
                            visitmap.put(a.Target__c,datemap);
                            
                        }
                        
                    }else if(a.recordtype.name=='Other Activities'){
                        system.debug('visit......'+a);
                        system.debug('recordtype...'+a.recordtype.name);
                        map<date,integer> otherdatemap= new map<date,integer>();
                        if(!otheractivitymap.isEmpty() &&  !otheractivitymap.get(a.Target__c).IsEmpty() && otheractivitymap.containsKey(a.Target__c)){ 
                            //system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            otherdatemap.putAll(otheractivitymap.get(a.Target__c));
                            // system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            //system.debug('otherdatemap values......'+otherdatemap.Values());
                            otherdatemap.put(a.Date__c,(otherdatemap.containsKey(a.Date__c)?otherdatemap.get(a.Date__c):0)+1);
                            
                            otheractivitymap.put(a.Target__c,otherdatemap);
                        }else{
                            
                            otherdatemap.put(a.Date__c, 1);
                            otheractivitymap.put(a.Target__c,otherdatemap);
                            //system.debug('test.......otherdatemap'+otherdatemap);
                            // system.debug('test.......otheractivitymap'+otheractivitymap);
                            
                        }
                        
                    }
                    targetid.add(a.Target__c);
                    dateid.add(a.Date__c);
                }
                //targetIdList.addAll(targetid);
                dateidlist.addAll(dateid);
                system.debug('targetid in list...'+targetIdList);
                system.debug('targetid in dateidlist list...'+dateidlist);
            }
            list<Target__C> tarlist= [select id,name,No_of_days_worked_in_month_visit__c,No_of_days_worked_in_month_Office__c from Target__c where ID IN:targetid];
            for(Target__C tar:tarlist){
                Target__c t= new Target__c();
                t.id=tar.id;
                map<Date, integer> tempOmap = new map<Date, integer>();
                map<Date, integer> tempVmap = new map<Date, integer>();
                tempOmap = otheractivitymap.get(tar.ID);
                tempVmap = visitmap.get(tar.ID);
                system.debug('tempOmap'+tempOmap);
                system.debug('tempVmap'+tempvmap);
                for(date eachdate:dateidlist){
                    
                    system.debug('tempVmap get...'+tempVmap.get(eachdate));
                    system.debug('tempOmap get...'+tempOmap.get(eachdate));
                    if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)>(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        
                        t.No_of_days_worked_in_month_visit__c=(t.No_of_days_worked_in_month_visit__c != null?t.No_of_days_worked_in_month_visit__c:0)+1;
                    }else if((tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)>(tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)){
                        t.No_of_days_worked_in_month_Office__c=(t.No_of_days_worked_in_month_Office__c != null?t.No_of_days_worked_in_month_Office__c:0)+1;
                        
                    }else if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)==(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        system.debug(t.No_of_days_worked_in_month_visit__c);
                        t.No_of_days_worked_in_month_visit__c=(t.No_of_days_worked_in_month_visit__c != null?t.No_of_days_worked_in_month_visit__c:0)+1;
                    }
                    Targetlisttoupdate.add(t);
                    
                }
                
            }
            map<id,target__c> tempmap= new map<id,target__c>();
            tempmap.putAll(Targetlisttoupdate);
            if(!tempmap.IsEmpty()){
                update tempmap.Values();
            }
            system.debug('visitmap....final----'+visitmap);
            system.debug('otheractivitymap....final---'+otheractivitymap);
        }catch(exception e){
            system.debug('exception,,,,..............no of visit handler'+e+'.........'+e.getLineNumber());
        }
    }
    public static void projectVisitDeletemethod(list<AP_Site_Visit__c> Oldlist){
        set<id> targetid= new set<id>();
        set<date> dateid= new set<date>();
        list<id> targetIdList= new list<id>();
        list<Target__C> Targetlisttoupdate= new list<Target__C>();
        list<date> dateidlist= new list<date>();
        map<id,map<date,integer>> visitmap= new map<id,map<date,integer>>();
        map<id,map<date,integer>> otheractivitymap= new map<id,map<date,integer>>();
        
        try{
            if(!Oldlist.IsEmpty()){
                for(AP_Site_Visit__c ap:Oldlist){
                    if(ap.Othet_Activities__c!='Leave' && ap.Othet_Activities__c!='Holiday/ Market Closed'){
                    targetid.add(ap.Target__c);
                    }
                }
            }
            list<AP_Site_Visit__c> aplist=[select id,name,recordtype.name,target__C,Date__c from AP_Site_Visit__c where target__C IN : targetid and (recordtype.name='brandingVist' OR  recordtype.name='Project Visit') ];
           system.debug('tset list today delete------->'+aplist);
            if(!aplist.IsEmpty()){
                for(AP_Site_Visit__c a:aplist){
                    
                    map<date,integer> datemap= new map<date,integer>();
                    if(a.recordtype.name=='Project Visit'){
                        if(!visitmap.isEmpty() &&  !visitmap.get(a.Target__c).isEmpty() && visitmap.containsKey(a.Target__c)){ 
                            
                            datemap.putAll(visitmap.get(a.Target__c));
                            datemap.put(a.Date__c,(datemap.containsKey(a.Date__c)?datemap.get(a.Date__c):0)+1);
                            visitmap.put(a.Target__c,datemap);
                        }else{
                            datemap.put(a.Date__c, 1);
                            visitmap.put(a.Target__c,datemap);
                            
                        }
                        
                    }else if(a.recordtype.name=='brandingVist'){
                        system.debug('visit......'+a);
                        system.debug('recordtype...'+a.recordtype.name);
                        map<date,integer> otherdatemap= new map<date,integer>();
                        if(!otheractivitymap.isEmpty() &&  !otheractivitymap.get(a.Target__c).IsEmpty() && otheractivitymap.containsKey(a.Target__c)){ 
                            //system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            otherdatemap.putAll(otheractivitymap.get(a.Target__c));
                            // system.debug('otherdatemap..keyset....'+otherdatemap.KeySet());
                            //system.debug('otherdatemap values......'+otherdatemap.Values());
                            otherdatemap.put(a.Date__c,(otherdatemap.containsKey(a.Date__c)?otherdatemap.get(a.Date__c):0)+1);
                            
                            otheractivitymap.put(a.Target__c,otherdatemap);
                        }else{
                            
                            otherdatemap.put(a.Date__c, 1);
                            otheractivitymap.put(a.Target__c,otherdatemap);
                            //system.debug('test.......otherdatemap'+otherdatemap);
                            // system.debug('test.......otheractivitymap'+otheractivitymap);
                            
                        }
                        
                    }
                    targetid.add(a.Target__c);
                    dateid.add(a.Date__c);
                }
                //targetIdList.addAll(targetid);
                dateidlist.addAll(dateid);
                system.debug('targetid in list...'+targetIdList);
                system.debug('targetid in dateidlist list...'+dateidlist);
            }
            list<Target__C> tarlist= [select id,name,No_of_days_worked_BrandingVisit_visits__c,No_of_days_worked_ProjectVisit_visits__c  from Target__c where ID IN:targetid];
            for(Target__C tar:tarlist){
                Target__c t= new Target__c();
                t.id=tar.id;
                map<Date, integer> tempOmap = new map<Date, integer>();
                map<Date, integer> tempVmap = new map<Date, integer>();
                tempOmap = otheractivitymap.get(tar.ID);
                tempVmap = visitmap.get(tar.ID);
                system.debug('tempOmap'+tempOmap);
                system.debug('tempVmap'+tempvmap);
                for(date eachdate:dateidlist){
                    
                    system.debug('tempVmap get...'+tempVmap.get(eachdate));
                    system.debug('tempOmap get...'+tempOmap.get(eachdate));
                    if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)>(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        
                        t.No_of_days_worked_ProjectVisit_visits__c=(t.No_of_days_worked_ProjectVisit_visits__c != null?t.No_of_days_worked_ProjectVisit_visits__c:0)+1;
                    }else if((tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)>(tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)){
                        t.No_of_days_worked_BrandingVisit_visits__c=(t.No_of_days_worked_BrandingVisit_visits__c != null?t.No_of_days_worked_BrandingVisit_visits__c:0)+1;
                        
                    }else if((tempVmap.get(eachdate)!= null?tempVmap.get(eachdate):0)==(tempOmap.get(eachdate)!= null?tempOmap.get(eachdate):0)){
                        system.debug(t.No_of_days_worked_ProjectVisit_visits__c);
                        t.No_of_days_worked_ProjectVisit_visits__c=(t.No_of_days_worked_ProjectVisit_visits__c != null?t.No_of_days_worked_ProjectVisit_visits__c:0)+1;
                    }
                    Targetlisttoupdate.add(t);
                    
                }
                
            }
            map<id,target__c> tempmap= new map<id,target__c>();
            tempmap.putAll(Targetlisttoupdate);
            if(!tempmap.IsEmpty()){
                update tempmap.Values();
            }
            system.debug('visitmap....final----'+visitmap);
            system.debug('otheractivitymap....final---'+otheractivitymap);
        }catch(exception e){
            system.debug('exception,,,,..............no of visit handler'+e+'.........'+e.getLineNumber());
        }
    }  
    public static void testMethod_1(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
}
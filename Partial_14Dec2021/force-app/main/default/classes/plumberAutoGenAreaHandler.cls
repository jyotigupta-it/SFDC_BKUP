public class plumberAutoGenAreaHandler {
    
    public static void populateArea(List<Account> newList){
        
        set<Id> plumberClubIds = new set<id>();
        
        for(Account acc:newList)
        {
            plumberClubIds.add(acc.Plumber_club__c);
        }
        
        Map<id,Plumber_club__c> mapArea = new Map<id,Plumber_club__c>([Select Id, Name,Plumber_Club_Id__c,count__c,(select Id, Plumber_club_count__c,Plumber_club_member_ID__c from Accounts__r Order By createdDate DESC LIMIT 1) from Plumber_club__c where id IN: plumberClubIds]);
        System.debug('mapArea'+mapArea);
        Map<id,Integer> mapCount = new Map<id,Integer>();
        
        for(Account acc:newList)
        {
            if(mapArea.containsKey(acc.Plumber_club__c))
            {
                Integer count = 0, arCount=0;
                
                if(mapArea.get(acc.Plumber_club__c).Accounts__r.size()>0)
                {
                    arCount = Integer.valueOf(mapArea.get(acc.Plumber_club__c).Accounts__r[0].Plumber_club_count__c);                	
                }
                if(mapCount.containsKey(acc.Plumber_club__c) )
                {
                    count =   arCount + 1 + mapCount.get(acc.Plumber_club__c);
                    Integer mpcnt=mapCount.get(acc.Plumber_club__c)+1;
                    mapCount.put(acc.Plumber_club__c,mpcnt);
                }
                else{
                    count = arCount + 1;
                    mapCount.put(acc.Plumber_club__c,1);
                }
                if(count<10)
                {
                    acc.Plumber_club_member_ID__c = mapArea.get(acc.Plumber_club__c).Plumber_Club_Id__c + '00' + count;
                    acc.Plumber_club_count__c=count;
                }
                else if(count>=10 && count<100 )
                {
                    acc.Plumber_club_member_ID__c = mapArea.get(acc.Plumber_club__c).Plumber_Club_Id__c + '0' + count;
                    acc.Plumber_club_count__c= count;
                }
                
                else if(count>100)
                {
                    acc.Plumber_club_member_ID__c = mapArea.get(acc.Plumber_club__c).Plumber_Club_Id__c + count;
                    acc.Plumber_club_count__c=count;
                }
                
                
            }
            
        }
        
        for(Plumber_club__c ar: mapArea.values()){
            if(mapCount.containsKey(ar.id))
                ar.count__c += mapCount.get(ar.id);
        }
        update mapArea.values();
    }
   /* public static void afterUpdatePlumb(List<Account> oldList )
    {
		
             
        
        /* ************************************************************ 
        Decimal cnt=0;
       
        for(Account acc :oldList )
        {
            cnt =acc.Plumber_club_count__c;
        }
        List<Account> accList = [SELECT Id,Name,Plumber_club_count__c,Plumber_club_member_ID__c FROM Account WHERE Plumber_club_count__c > : cnt ];
        system.debug('accList'+accList);
        string s1='',s2;
        Decimal c;
        List<Account> UpdateList = new List<Account>();
        for(Account acc:accList)
        {
            c = acc.Plumber_club_count__c - 1;
            system.debug('acc.Plumber_club_count__c'+acc.Plumber_club_count__c);
            s1=acc.Plumber_club_member_ID__c.substringBefore('-');
            system.debug('s1'+s1);
            Account accUp = new Account();
            accUp.Id=acc.Id;
            if(c<10)
            {
                accUp.Plumber_club_member_ID__c=s1+'-00'+c;
                accUp.Plumber_club_count__c=c;
            }
            else if(c>=10 && c<100){
                accUp.Plumber_club_member_ID__c=s1+'-0'+c;
                accUp.Plumber_club_count__c=c;
                
                
            }
            else if(c>100)
            {
             	accUp.Plumber_club_member_ID__c=s1+'-'+c;  
                accUp.Plumber_club_count__c=c;
            }
            UpdateList.add(accUp);
 
        }
        Update UpdateList;
        
    }
    
    public static void afterDeletePlumb(List<Account> oldList)
    {
        Set<id> strOld = new Set<id>();
        Map<id,Plumber_club__c> mapDel = new Map<id,Plumber_club__c>();
        Map<id,Integer> mapDelCount = new Map<id,Integer>();
        for(Account acct : oldList)
            strOld.add(acct.Plumber_club__c);
        List<Plumber_club__c> arr = [select Name,Plumber_Club_Id__c,count__c from Plumber_club__c where id IN: strOld];
        system.debug('arr'+arr);
        for(Plumber_club__c area : arr)
            mapDel.put(area.id, area);
        for(Account acct : oldList){
            if(mapDel.containsKey(acct.Plumber_club__c)){
                if(mapDelCount.containsKey(acct.Plumber_club__c)){
                    Integer countDel=mapDelCount.get(acct.Plumber_club__c)+1;
                    mapDelCount.put(acct.Area__c,countDel); 
                }
                else
                    mapDelCount.put(acct.Plumber_club__c,1);      
            }
        }   
        
        for(Plumber_club__c ar: mapDel.values()){
            if(mapDelCount.containsKey(ar.id))
                system.debug('ar.count__c'+ar.count__c);
            ar.count__c -= mapDelCount.get(ar.id);
            system.debug('ar.count__c'+ar.count__c);
        }
        update mapDel.values();
    }*/
    
}
trigger Sitevisitcount on Site_Visit__c (after insert, after update, after delete, after undelete) 
{
    Map<Id,Account> MapSites= new Map<Id,Account>();
    Set<Id> prgid = new Set<Id>();

    try
    {
      
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete)
        {
            for(Site_Visit__c p : Trigger.new) 
            {
                prgid.add(p.Party_Name__c);

            }
        }
       
        if(Trigger.isUpdate || Trigger.isDelete)
        {
            for(Site_Visit__c p : Trigger.old)
            {
                prgid.add(p.Party_Name__c);
            }

        }
        
        prgid.remove(null);
        for(Id pId : prgid) 
        {
            MapSites.put(pId,new Account(Id=pId,Site_Visit_Count__c=0));
        }
        
        for(Site_Visit__c p : [select Party_Name__c,Count__c from Site_Visit__c WHERE Party_Name__c IN: prgid ]) 

        {
            MapSites.get(p.Party_Name__c).Site_Visit_Count__c += p.Count__c;
        }
        
        update MapSites.values();
    }
    catch(Exception e) 
    {
       System.debug(e);

    }
}
trigger UpdateState_Dist_Location on Site_Visit__c (after insert,After Update,After delete, After undelete) 
{
    Set<Id> TPlanIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete)
    { 
        for(Site_Visit__c each : Trigger.New)
        {
            if(each.Tour_Plan1__c!=Null)
            {
                TPlanIds.add(each.Tour_Plan1__c);
            }
        }
    }
    if(Trigger.isUpdate || Trigger.isDelete)
    {
        for(Site_Visit__c each : Trigger.Old)
        {
            if(each.Tour_Plan1__c!=Null)
            {
                TPlanIds.add(each.Tour_Plan1__c);
            }
        }
    }
    TPlanIds.Remove(Null);
    
    List<Tour_Plan1__c> TourPlans = [SELECT id,Name,Actual_District__c,
                                                                Actual_Location__c,Actual_State__c 
                                                                FROM Tour_Plan1__c WHERE id IN : TPlanIds];
    
    Map<Id,Tour_Plan1__c> MapTPlans = new Map<Id,Tour_Plan1__c>();
    
    for(Tour_Plan1__c tp : TourPlans )
    {
        if(!MapTPlans.ContainsKey(tp.id))
        {
            MapTPlans.put(tp.id,new Tour_Plan1__c(id=tp.id,Actual_State__c='',Actual_District__c='',Actual_Location__c=''));
        }
    }
    
    for(Site_Visit__c each1 : [SELECT id,Name,Tour_Plan1__c,Actual_Site_Visit_State__c,Actual_Site_Visit_District__c,Actual_Site_visit_Location__c FROM 
                                Site_Visit__c WHERE  Tour_Plan1__c IN: TPlanIds ])
    {
        if(MapTPlans.get(each1.Tour_Plan1__c)!=Null)
        {
            if(each1.Actual_Site_Visit_State__c!=Null)
            {
                if(MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c=='')
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c  =''+each1.Actual_Site_Visit_State__c;
                }
                else if(MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c!='' && !MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c.Contains(each1.Actual_Site_Visit_State__c))
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c  = MapTPlans.get(each1.Tour_Plan1__c).Actual_State__c +','+each1.Actual_Site_Visit_State__c;
                }
            }
            if(each1.Actual_Site_Visit_District__c!=Null)
            {
                if(MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c  =='')
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c  =''+each1.Actual_Site_Visit_District__c;
                }
                else if(MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c  !='' && !MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c.Contains(each1.Actual_Site_Visit_District__c))
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c  = MapTPlans.get(each1.Tour_Plan1__c).Actual_District__c+','+each1.Actual_Site_Visit_District__c;
                }
            }
            if(each1.Actual_Site_visit_Location__c!=Null)
            {
                if(MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c =='')
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c =''+each1.Actual_Site_visit_Location__c;
                }
                else if(MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c !='' && !MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c .Contains(each1.Actual_Site_visit_Location__c))
                {
                    MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c  =MapTPlans.get(each1.Tour_Plan1__c).Actual_Location__c + ','+each1.Actual_Site_visit_Location__c;
                }
            }
        }
    }
    Update MapTPlans.Values(); 
}
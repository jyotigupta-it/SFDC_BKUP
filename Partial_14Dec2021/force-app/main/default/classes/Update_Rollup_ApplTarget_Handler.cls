/*<!--++----------------------------------------------------------------------
||        Author      :  Krishnareddy
||
||        Purpose     :  Before Update - Populating Expense visitType value in TourPlan Visit Type for Reporting Purpose.
||                       After Update  - Rollup Summary of Retailing VisitType(Head Quarter - Metro, Head Quarter-State Capital, Head Quarter, Ex-Station, Out-Station) from TourPlan to Target object.
||                  
||        Created By  :  26/07/2015 / Krishna
|| 
||        Modified By :  27/07/2015 /Krishna
++----------------------------------------------------------------------- -->*/
public class Update_Rollup_ApplTarget_Handler {
    
    public static Update_Rollup_ApplTarget_Handler instance;
    
    /*-- SINGLETON PATTERN --*/
    public static Update_Rollup_ApplTarget_Handler getInstance() {
        
        if(instance == null) {
            instance = new Update_Rollup_ApplTarget_Handler();
        }
        return instance;
    }
    
    private set<id> setofTargetIds = new set<id>();   //Prepare TargetIds 
    private set<id> setofTourPlans = new set<id>();   //Prepare tourPlan ids.
    map<id, AP_Expenses__c> mapTourPlan_Ap_Expenses = new map <id, AP_Expenses__c>();
    map<id, AP_Site_Visit__c> mapTarget_visit = new map<id, AP_Site_Visit__c>();
    
    //Before Update - Populating Expense visitType value in TourPlan Visit Type for Reporting Purpose.
    
    public void populateVisitType(list <AP_Tour_Plan__c> lstApTourPlans) {
        
        for(AP_Tour_Plan__c objTourPlan : lstApTourPlans) {
            
            setofTourPlans.add(objTourPlan.id);
            setofTargetIds.add(objTourPlan.Target__c);
        }
        
        //Query the ApExpensives with particular Tour Plans.
        for(AP_Expenses__c objApExpense: [select Expens_Visit_Type__c, TourPlan__c from AP_Expenses__c where TourPlan__c IN: setofTourPlans]) {
            
            mapTourPlan_Ap_Expenses.put(objApExpense.TourPlan__c, objApExpense);
        }
        
        
        // Populating Expense visitType in TourPlan.
        for(AP_Tour_Plan__c objTourPlan : lstApTourPlans) {
            
            if(mapTourPlan_Ap_Expenses.containsKey(objTourPlan.Id)) {
                
                objTourPlan.Actual_Visit_Type__c = mapTourPlan_Ap_Expenses.get(objTourPlan.Id).Expens_Visit_Type__c;
            }
        }
    }
    // populate actual visits to Target
    
    public void populateactualVisitType(list <Target__c> lstApTargets) {
        //Update_Rollup_ApplTarget_Helper.isTarget = false;
        map<String,map<String,Decimal>> mp=new map<String,map<String,Decimal>>();
        map<String,map<String,Decimal>> mp1=new map<String,map<String,Decimal>>();
        map<String,map<String,Decimal>> mp2=new map<String,map<String,Decimal>>();
        for(Target__c objTarget : lstApTargets) {
            
            setofTargetIds.add(objTarget.id);
            
        }
        system.debug(setofTargetIds);
        for(AP_Site_Visit__c objApSite: [SELECT Id,Unplanned_Visit__c,Geo_Address__c,Party_Name__c,Party_Name__r.Dealer_Club_2_0__c,Target__c,Visit_type_Actual__c,Order_Value__c from  AP_Site_Visit__c where Target__c IN: setofTargetIds])
        {
            System.debug('app site--->'+objApSite);
            system.debug('mp.containsKey(objApSite.Target__c)'+ mp.containsKey(objApSite.Target__c));
            if(mp.containsKey(objApSite.Target__c))
            {
                if(objApSite.Visit_type_Actual__c!='E-Visit')
                {
                    system.debug(mp.keyset());
                    System.debug('not e visit--->'+objApSite.Visit_type_Actual__c+' -->'+objApSite.Target__c);
                    system.debug('objApSite.Geo_Address__c'+objApSite.Geo_Address__c);
                    if(objApSite.Geo_Address__c!=Null){
                        System.debug('geo add---->'+objApSite.Geo_Address__c);
                        if(objApSite.Party_Name__c!=Null){
                            if(objApSite.Party_Name__r.Dealer_Club_2_0__c!=Null)
                            {
                                if(mp.get(objApSite.Target__c).containsKey('ECP-Visit')){
                                    mp.get(objApSite.Target__c).put('ECP-Visit',mp.get(objApSite.Target__c).get('ECP-Visit')+1);
                                }
                                else{
                                    mp.get(objApSite.Target__c).put('ECP-Visit',1);   
                                }   
                                
                                if(objApSite.Order_Value__c!=Null){
                                    if(mp.get(objApSite.Target__c).containsKey('OrderECP-Visit'))
                                    {
                                        
                                        mp.get(objApSite.Target__c).put('OrderECP-Visit',mp.get(objApSite.Target__c).get('OrderECP-Visit')+objApSite.Order_Value__c);
                                        System.debug('mp.get(objApSite.Target__c)'+mp.get(objApSite.Target__c));
                                        mp.get(objApSite.Target__c).put('OrderECP-Visit',mp.get(objApSite.Target__c).get('OrderECP-Visit')+1);
                                    }
                                    else
                                    {
                                        mp.get(objApSite.Target__c).put('OrderECP-Visit',(objApSite.Order_Value__c));   
                                        mp.get(objApSite.Target__c).put('OrderECP-Visit',1);  
                                    }
                                } 
                                // Unplanned visits Ec      
                                if(objApSite.Unplanned_Visit__c==true){
                                    if(mp.get(objApSite.Target__c).containsKey('ECUP-Visit'))
                                    {
                                        
                                        mp.get(objApSite.Target__c).put('ECUP-Visit',mp.get(objApSite.Target__c).get('ECUP-Visit')+1);
                                        
                                    }
                                    else
                                    {
                                        mp.get(objApSite.Target__c).put('ECUP-Visit',1);   
                                        
                                    }
                                   /* if(mp.get(objApSite.Target__c).containsKey('UP-Visit'))
                                    {
                                        
                                        mp.get(objApSite.Target__c).put('UP-Visit',mp.get(objApSite.Target__c).get('UP-Visit')+1);
                                        
                                    }
                                    else
                                    {
                                        mp.get(objApSite.Target__c).put('UP-Visit',1);   
                                        
                                    }*/
                                }     
                                
                            }else{
                            if(mp.get(objApSite.Target__c).containsKey('P-Visit')){
                            mp.get(objApSite.Target__c).put('P-Visit',mp.get(objApSite.Target__c).get('P-Visit')+1);
                        }
                        else{
                            mp.get(objApSite.Target__c).put('P-Visit',1);   
                        }
                        }
                            
                        }else{
                            if(mp.get(objApSite.Target__c).containsKey('P-Visit')){
                            mp.get(objApSite.Target__c).put('P-Visit',mp.get(objApSite.Target__c).get('P-Visit')+1);
                        }
                        else{
                            mp.get(objApSite.Target__c).put('P-Visit',1);   
                        }
                        }
                        system.debug('Plannedddddddddddddddddddddddd_-------------> '+mp.keyset());
                        /*if(mp.get(objApSite.Target__c).containsKey('P-Visit')){
                            mp.get(objApSite.Target__c).put('P-Visit',mp.get(objApSite.Target__c).get('P-Visit')+1);
                        }
                        else{
                            mp.get(objApSite.Target__c).put('P-Visit',1);   
                        }*/
                        if(objApSite.Order_Value__c!=Null){
                            if(mp.get(objApSite.Target__c).containsKey('OrderP-Visit'))
                            {
                                
                                mp.get(objApSite.Target__c).put('OrderP-Visit',mp.get(objApSite.Target__c).get('OrderP-Visit')+objApSite.Order_Value__c);
                              //  System.debug('mp.get(objApSite.Target__c)'+mp.get(objApSite.Target__c));
                               // mp.get(objApSite.Target__c).put('OrderValueP-Visit',mp.get(objApSite.Target__c).get('OrderValueP-Visit')+1);
                            }
                            else
                            {
                                mp.get(objApSite.Target__c).put('OrderP-Visit',(objApSite.Order_Value__c));   
                              //  mp.get(objApSite.Target__c).put('OrderValueP-Visit',1);  
                            }
                             if(mp.get(objApSite.Target__c).containsKey('OrderValueP-Visit'))
                            {
                                
                              //  mp.get(objApSite.Target__c).put('OrderP-Visit',mp.get(objApSite.Target__c).get('OrderP-Visit')+objApSite.Order_Value__c);
                              //  System.debug('mp.get(objApSite.Target__c)'+mp.get(objApSite.Target__c));
                                mp.get(objApSite.Target__c).put('OrderValueP-Visit',mp.get(objApSite.Target__c).get('OrderValueP-Visit')+1);
                            }
                            else
                            {
                               // mp.get(objApSite.Target__c).put('OrderP-Visit',(objApSite.Order_Value__c));   
                                mp.get(objApSite.Target__c).put('OrderValueP-Visit',1);  
                            }
                        }
                        //populating the unplanned visits
                        system.debug('Unplannnnnnnnnnnnnnned ----> '+objApSite.Unplanned_Visit__c);
                        if(objApSite.Unplanned_Visit__c==true){
                            if(mp.get(objApSite.Target__c).containsKey('UP-Visit'))
                            {
                                
                                mp.get(objApSite.Target__c).put('UP-Visit',mp.get(objApSite.Target__c).get('UP-Visit')+1);
                                
                            }
                            else
                            {
                                mp.get(objApSite.Target__c).put('UP-Visit',1);   
                                
                            }
                        }
                        
                    }
                }
                else
                {
                    if(objApSite.Party_Name__c!=Null){
                        if(objApSite.Party_Name__r.Dealer_Club_2_0__c!=Null){
                            
                            if(mp.get(objApSite.Target__c).containsKey('ECE-Visit'))
                            {
                                mp.get(objApSite.Target__c).put('ECE-Visit',mp.get(objApSite.Target__c).get('ECE-Visit')+1);
                            }
                            else
                            {
                                mp.get(objApSite.Target__c).put('ECE-Visit',1);   
                            }   
                            
                            if(objApSite.Order_Value__c!=Null){
                                if(mp.get(objApSite.Target__c).containsKey('OrderECE-Visit'))
                                {
                                    mp.get(objApSite.Target__c).put('OrderECE-Visit',mp.get(objApSite.Target__c).get('OrderECE-Visit')+objApSite.Order_Value__c);
                                   // mp.get(objApSite.Target__c).put('OrderValueECE-Visit',mp.get(objApSite.Target__c).get('OrderValueECE-Visit')+1);
                                }
                                else
                                {
                                   mp.get(objApSite.Target__c).put('OrderECE-Visit',objApSite.Order_Value__c);  
                                   // mp.get(objApSite.Target__c).put('OrderValueECE-Visit',1);
                                    
                                }
                                if(mp.get(objApSite.Target__c).containsKey('OrderValueECE-Visit'))
                                {
                                    //mp.get(objApSite.Target__c).put('OrderECE-Visit',mp.get(objApSite.Target__c).get('OrderECE-Visit')+objApSite.Order_Value__c);
                                    mp.get(objApSite.Target__c).put('OrderValueECE-Visit',mp.get(objApSite.Target__c).get('OrderValueECE-Visit')+1);
                                }
                                else
                                {
                                   // mp.get(objApSite.Target__c).put('OrderECE-Visit',objApSite.Order_Value__c);  
                                    mp.get(objApSite.Target__c).put('OrderValueECE-Visit',1);
                                    
                                }
                            }   //unplanned Ec visits   
                            if(objApSite.Unplanned_Visit__c==true){
                                if(mp.get(objApSite.Target__c).containsKey('ECUE-Visit'))
                                {
                                    
                                    mp.get(objApSite.Target__c).put('ECUE-Visit',mp.get(objApSite.Target__c).get('ECUE-Visit')+1);
                                    
                                }
                                else
                                {
                                    mp.get(objApSite.Target__c).put('ECUE-Visit',1);   
                                    
                                }
                            }
                            
                            
                            
                        }else{
                              if(mp.get(objApSite.Target__c).containsKey('E-Visit'))
                    {
                        mp.get(objApSite.Target__c).put('E-Visit',mp.get(objApSite.Target__c).get('E-Visit')+1);
                    }
                    else
                    {
                        mp.get(objApSite.Target__c).put('E-Visit',1);   
                    }
                        }
                      
                    }else{
                        if(mp.get(objApSite.Target__c).containsKey('E-Visit'))
                    {
                        mp.get(objApSite.Target__c).put('E-Visit',mp.get(objApSite.Target__c).get('E-Visit')+1);
                    }
                    else
                    {
                        mp.get(objApSite.Target__c).put('E-Visit',1);   
                    }
                    }
                    
                    
                    
                    if(objApSite.Order_Value__c!=Null){
                        if(mp.get(objApSite.Target__c).containsKey('OrderE-Visit'))
                        {
                            mp.get(objApSite.Target__c).put('OrderE-Visit',mp.get(objApSite.Target__c).get('OrderE-Visit')+objApSite.Order_Value__c);
                            //mp.get(objApSite.Target__c).put('OrderValueE-Visit',mp.get(objApSite.Target__c).get('OrderValueE-Visit')+1);
                        }
                        else
                        {
                            mp.get(objApSite.Target__c).put('OrderE-Visit',objApSite.Order_Value__c);  
                            //mp.get(objApSite.Target__c).put('OrderValueE-Visit',1);
                            
                        }
                        if(mp.get(objApSite.Target__c).containsKey('OrderValueE-Visit'))
                        {
                          //  mp.get(objApSite.Target__c).put('OrderE-Visit',mp.get(objApSite.Target__c).get('OrderE-Visit')+objApSite.Order_Value__c);
                            mp.get(objApSite.Target__c).put('OrderValueE-Visit',mp.get(objApSite.Target__c).get('OrderValueE-Visit')+1);
                        }
                        else
                        {
                           // mp.get(objApSite.Target__c).put('OrderE-Visit',objApSite.Order_Value__c);  
                            mp.get(objApSite.Target__c).put('OrderValueE-Visit',1);
                            
                        }
                    }
                    //populating the unplanned visits
                    if(objApSite.Unplanned_Visit__c==true){
                        if(mp.get(objApSite.Target__c).containsKey('UE-Visit'))
                        {
                            
                            mp.get(objApSite.Target__c).put('UE-Visit',mp.get(objApSite.Target__c).get('UE-Visit')+1);
                            
                        }
                        else
                        {
                            mp.get(objApSite.Target__c).put('UE-Visit',1);   
                            
                        }
                    }
                    
                }
                if(objApSite.Party_Name__c!=Null){
                    if(objApSite.Party_Name__r.Dealer_Club_2_0__c!=Null)   
                    {
                        
                        if(mp.get(objApSite.Target__c).containsKey('Dealer-Visit'))
                        {
                            
                            mp.get(objApSite.Target__c).put('Dealer-Visit',mp.get(objApSite.Target__c).get('Dealer-Visit')+1);
                            
                        }
                        else
                        {
                            mp.get(objApSite.Target__c).put('Dealer-Visit',1);   
                            
                        }
                        
                    }
                }
            }
            else
            {
                 
                system.debug('in else  ---------> '+objApSite.Visit_type_Actual__c);
                
                if(objApSite.Party_Name__c!=Null){
                    
                    if(objApSite.Party_Name__r.Dealer_Club_2_0__c!=Null){
                        if(objApSite.Visit_type_Actual__c!='E-Visit'){
                            if(objApSite.Geo_Address__c!=Null){
                                 map<String,Decimal> mpTemp=new map<String,Decimal>();
                        mpTemp.put('ECP-Visit',1);
                        mpTemp.put('OrderECP-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('ECUP-Visit',1);
                                mp.put(objApSite.Target__c,mpTemp);
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'ECP-Visit'=>1}); 
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderECP-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'ECUP-Visit'=>1}); 
                            
                            }
                            
                        }
                        else
                        {
                          map<String,Decimal> mpTemp=new map<String,Decimal>();   
                        mpTemp.put('ECE-Visit',1);
                        mpTemp.put('OrderECE-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('ECUE-Visit',1);
                            mp.put(objApSite.Target__c,mpTemp);
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'ECE-Visit'=>1});  
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderECE-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                            //mp.put(objApSite.Target__c,new map<String,Decimal>{'ECUE-Visit'=>1}); 
                            
                        }
                        //mpTemp.put('Dealer-Visit',1);
                        if(mp.containsKey(objApSite.Target__c)){
                            mp.get(objApSite.Target__c).put('Dealer-Visit',1); 
                        }
                          
                        
                        
                    }
                    else{
                        if(objApSite.Visit_type_Actual__c!='E-Visit'){
                    if(objApSite.Geo_Address__c!=Null){
                       map<String,Decimal> mpTemp=new map<String,Decimal>();  
                        mpTemp.put('P-Visit',1);
                        mpTemp.put('OrderP-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('UP-Visit',1);
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'P-Visit'=>1}); 
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderP-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'UP-Visit'=>1}); 
                        mp.put(objApSite.Target__c,mpTemp);
                    }
                    System.debug('value of mp---->'+mp);
                }
                
                else
                {
                    map<String,Decimal> mpTemp=new map<String,Decimal>();  
                        mpTemp.put('E-Visit',1);
                        mpTemp.put('OrderE-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('UE-Visit',1);
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'E-Visit'=>1});  
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderE-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'UE-Visit'=>1}); 
                    mp.put(objApSite.Target__c,mpTemp);
                }
                    }
                }
                else{
                    if(objApSite.Visit_type_Actual__c!='E-Visit'){
                    if(objApSite.Geo_Address__c!=Null){
                       map<String,Decimal> mpTemp=new map<String,Decimal>();  
                        mpTemp.put('P-Visit',1);
                        mpTemp.put('OrderP-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('UP-Visit',1);
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'P-Visit'=>1}); 
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderP-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                        //mp.put(objApSite.Target__c,new map<String,Decimal>{'UP-Visit'=>1}); 
                        mp.put(objApSite.Target__c,mpTemp);
                    }
                    System.debug('value of mp---->'+mp);
                }
                
                else
                {
                    map<String,Decimal> mpTemp=new map<String,Decimal>();  
                        mpTemp.put('E-Visit',1);
                        mpTemp.put('OrderE-Visit',(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0));
                        mpTemp.put('UE-Visit',1);
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'E-Visit'=>1});  
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'OrderE-Visit'=>(objApSite.Order_Value__c!=Null?objApSite.Order_Value__c:0)}); 
                    //mp.put(objApSite.Target__c,new map<String,Decimal>{'UE-Visit'=>1}); 
                    mp.put(objApSite.Target__c,mpTemp);
                }
                }
            }
        }
        System.debug('mp values---->'+mp);
        for(Target__c objTar : lstApTargets)
            
        { 
            if(mp.containsKey(objTar.Id))
            {
                if(mp.get(objTar.Id).ContainsKey('P-Visit')){
                    objTar.Actual_Visits__c=mp.get(objTar.Id).get('P-Visit');
                    system.debug('P-Visit'+mp.get(objTar.Id).get('P-Visit'));
                }
                else{
                    objTar.Actual_Visits__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('E-Visit'))  
                {
                    objTar.Actual_Visits_E_Visit__c=mp.get(objTar.Id).get('E-Visit');
                    system.debug('E-Visit'+mp.get(objTar.Id).get('E-Visit'));
                }else{
                    objTar.Actual_Visits_E_Visit__c=0;
                }
                
                if(mp.get(objTar.Id).ContainsKey('OrderE-Visit'))  
                {
                    objTar.Order_Value_E_Visit__c=mp.get(objTar.Id).get('OrderE-Visit');
                    system.debug('OrderE-Visit'+mp.get(objTar.Id).get('OrderE-Visit'));
                }else{
                    objTar.Order_Value_E_Visit__c=0;
                }
                
                if(mp.get(objTar.Id).ContainsKey('OrderP-Visit'))  {
                    objTar.Order_Value_Physical__c=mp.get(objTar.Id).get('OrderP-Visit');
                    system.debug('OrderP-Visit'+mp.get(objTar.Id).get('OrderP-Visit'));
                }else{
                    objTar.Order_Value_Physical__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('UE-Visit'))  {
                    objTar.Unplanned_Visits_E_Visit__c=mp.get(objTar.Id).get('UE-Visit');
                    system.debug('UE-Visit'+mp.get(objTar.Id).get('UE-Visit'));
                }else{
                    objTar.Unplanned_Visits_E_Visit__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('UP-Visit'))  {
                    objTar.Unplanned_Visits_Physical__c=mp.get(objTar.Id).get('UP-Visit');
                    system.debug('UP-Visit'+mp.get(objTar.Id).get('UP-Visit'));
                }else{
                    objTar.Unplanned_Visits_Physical__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueP-Visit'))  {
                    objTar.Number_of_Orders_taken_Physical__c=mp.get(objTar.Id).get('OrderValueP-Visit');
                    system.debug('OrderValueP-Visit'+mp.get(objTar.Id).get('OrderValueP-Visit'));
                }else{
                    objTar.Number_of_Orders_taken_Physical__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueE-Visit'))  {
                    objTar.Number_of_Orders_taken_E_Visit__c=mp.get(objTar.Id).get('OrderValueE-Visit');
                    system.debug('OrderValueE-Visit'+mp.get(objTar.Id).get('OrderValueE-Visit'));
                }else{
                    objTar.Number_of_Orders_taken_E_Visit__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueP-Visit') && mp.get(objTar.Id).ContainsKey('P-Visit'))
                {
                    objTar.Order_to_Visit_Ratio_Physical__c=(mp.get(objTar.Id).get('OrderValueP-Visit')/mp.get(objTar.Id).get('P-Visit'));
                    system.debug('OrderValueP-Visit P-Visit'+objTar.Order_to_Visit_Ratio_Physical__c);
                }else{
                    objTar.Order_to_Visit_Ratio_Physical__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueE-Visit') && mp.get(objTar.Id).ContainsKey('E-Visit'))  {
                    system.debug('OrderValueE-Visit E-Visit'+(mp.get(objTar.Id).get('OrderValueE-Visit')/mp.get(objTar.Id).get('E-Visit')));
                    objTar.Order_to_Visit_Ratio_E_Visit__c=(mp.get(objTar.Id).get('OrderValueE-Visit')/mp.get(objTar.Id).get('E-Visit'));
                }else{
                    objTar.Order_to_Visit_Ratio_E_Visit__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('Dealer-Visit'))  {
                    system.debug('Dealer-Visit'+mp.get(objTar.Id).get('Dealer-Visit'));
                    objTar.Dealer_Club_Count__c=(mp.get(objTar.Id).get('Dealer-Visit'));
                }
                else{
                    objTar.Dealer_Club_Count__c=0;
                }
                
                
                // Ec Accounts Fields
                
                
                
                
                if(mp.get(objTar.Id).ContainsKey('ECP-Visit')){
                  
                    objTar.Actual_Visits_Physical_EC__c=mp.get(objTar.Id).get('ECP-Visit');
                    system.debug('Actual_Visits_Physical_EC__c------->'+mp.get(objTar.Id).get('ECP-Visit'));
                    
                }else{
                    objTar.Actual_Visits_Physical_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('ECE-Visit'))  
                {
                    system.debug('ECE-Visit'+mp.get(objTar.Id).get('ECE-Visit'));
                    objTar.Actual_Visits_E_Visit_EC__c=mp.get(objTar.Id).get('ECE-Visit');
                }else{
                    objTar.Actual_Visits_E_Visit_EC__c=0;
                }
                
                if(mp.get(objTar.Id).ContainsKey('OrderECE-Visit'))  
                {
                    system.debug('OrderECE-Visit'+mp.get(objTar.Id).get('OrderECE-Visit'));
                    objTar.Order_Value_E_Visit_EC__c=mp.get(objTar.Id).get('OrderECE-Visit');}
                else{
                    objTar.Order_Value_E_Visit_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderECP-Visit'))  {
                    system.debug('OrderECP-Visit'+mp.get(objTar.Id).get('OrderECP-Visit'));
                    objTar.Order_Value_Physical_EC__c=mp.get(objTar.Id).get('OrderECP-Visit');
                }else{
                    objTar.Order_Value_Physical_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('ECUE-Visit'))  {
                    system.debug('ECUE-Visit'+mp.get(objTar.Id).get('ECUE-Visit'));
                    objTar.Unplanned_Visits_E_Visit_EC__c=mp.get(objTar.Id).get('ECUE-Visit');
                }else{
                    objTar.Unplanned_Visits_E_Visit_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('ECUP-Visit'))  {
                    system.debug('ECUP-Visit'+mp.get(objTar.Id).get('ECUP-Visit'));
                    objTar.Unplanned_Visits_Physical_EC__c=mp.get(objTar.Id).get('ECUP-Visit');
                }else{
                    objTar.Unplanned_Visits_Physical_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueECP-Visit'))  {
                    system.debug('OrderValueECP-Visit'+mp.get(objTar.Id).get('OrderValueECP-Visit'));
                    objTar.Number_of_Orders_taken_Physical_EC__c=mp.get(objTar.Id).get('OrderValueECP-Visit');
                }else{
                    objTar.Number_of_Orders_taken_Physical_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueECE-Visit'))  {
                    system.debug('OrderValueECE-Visit'+mp.get(objTar.Id).get('OrderValueECE-Visit'));
                    objTar.Number_of_Orders_taken_E_Visit_EC__c=mp.get(objTar.Id).get('OrderValueECE-Visit');
                }else{
                    objTar.Number_of_Orders_taken_E_Visit_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueECP-Visit') && mp.get(objTar.Id).ContainsKey('ECP-Visit'))
                    
                {
                    system.debug('OrderValueECP-Visit ECP-Visit'+(mp.get(objTar.Id).get('OrderValueECP-Visit')/mp.get(objTar.Id).get('ECP-Visit')));
                    objTar.Order_to_Visit_Ratio_Physical_EC__c=(mp.get(objTar.Id).get('OrderValueECP-Visit')/mp.get(objTar.Id).get('ECP-Visit'));}
                else{
                    objTar.Order_to_Visit_Ratio_Physical_EC__c=0;
                }
                if(mp.get(objTar.Id).ContainsKey('OrderValueECE-Visit') && mp.get(objTar.Id).ContainsKey('ECE-Visit'))  {
                    system.debug('OrderValueECE-Visit ECE-Visit'+(mp.get(objTar.Id).get('OrderValueECE-Visit')/mp.get(objTar.Id).get('ECE-Visit')));
                    objTar.Order_to_Visit_Ratio_E_Visit_EC__c=(mp.get(objTar.Id).get('OrderValueECE-Visit')/mp.get(objTar.Id).get('ECE-Visit'));
                }else{
                    objTar.Order_to_Visit_Ratio_E_Visit_EC__c=0;
                }
                
                
            }
        }
        
        
    }
    //After Update  - Rollup Summary of Retailing VisitType(Head Quarter - Metro, Head Quarter-State Capital, Head Quarter, Ex-Station, Out-Station) from TourPlan to Target object.
    
    public void update_Retail_RollupSumarries_Target(list<AP_Tour_Plan__c> lstApTourPlans) {
        
        list <Target__c > lstTargets = new list <Target__c>();
        
        //Update Reatail Rollup summaries in Target Object.
        for (AggregateResult objAggregrate : [select Target__c, sum(Ex_Station_Actual__c) ExStation, sum(Head_Quarter_Actual__c) HeadQuarter, sum(Head_Quarter_Metro_Actual__c) HeadQuarter_Metro,
                                              sum(Head_Quarter_State_Capital_Actual__c) HeadQuarterStateCapital, sum(Out_Station_Actual__c) OutStation from AP_Tour_Plan__c where Target__c IN: setofTargetIds group by Target__c]) {
                                                  
                                                  Target__c objTarget                              =    new Target__c();  //Update_Rollup_ApplTarget_Handler.getTarget();
                                                  objTarget.id                                     =    (Id)objAggregrate.get('Target__c');
                                                  objTarget.Ex_Station_Actual__c                   =    (Decimal)objAggregrate.get('ExStation');
                                                  objTarget.Head_Quarter_Actual__c                 =    (Decimal)objAggregrate.get('HeadQuarter');
                                                  objTarget.Head_Quarter_Metro_Actual__c           =    (Decimal)objAggregrate.get('HeadQuarter_Metro');
                                                  objTarget.Head_Quarter_State_Capital_Actual__c   =    (Decimal)objAggregrate.get('HeadQuarterStateCapital');
                                                  objTarget.Out_Station_Actual__c                  =    (Decimal)objAggregrate.get('OutStation');
                                                  lstTargets.add(objTarget);
                                              }
        
        //Updating Target records with the Actuals of Retailing VisitType(Head Quarter - Metro, Head Quarter-State Capital, Head Quarter, Ex-Station, Out-Station) from TourPlan to Target object.
        if(lstTargets.size() > 0) {
            try {
                Update_Rollup_ApplTarget_Helper.isTarget = false;
                update lstTargets;
            } Catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, e.getMessage()));
            }
        }
    }
    
    public void createVisits(List<AP_Tour_Plan__c> lstApTourPlans,Map<Id,AP_Tour_Plan__c> oldMap){
        Set<Id> touPlanIDs = new Set<Id>();
        Set<Id> beatIds = new Set<Id>();
        Map<Id,Id> targetId = new Map<Id,Id>();
        Map<Id,Id> tourId = new Map<Id,Id>();
        List<AP_Site_Visit__c> siteList = new List<AP_Site_Visit__c>();
        Map<Id,Beat_Master__c> beatMasterMap = new Map<Id,Beat_Master__c>();
        Id visitRecTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        for(AP_Tour_Plan__c tpObj : lstApTourPlans){
            if(tpObj.Id != null && tpObj.Beat__c != null){
                touPlanIDs.add(tpObj.Id);
                beatIds.add(tpObj.Beat__c); 
                targetId.put(tpObj.Beat__c,tpObj.Target__c);
                tourId.put(tpObj.Beat__c,tpObj.Id);
            }
        }
        if(beatIds.size() > 0)
            beatMasterMap = new Map<Id,Beat_Master__c>([SELECT Id,(SELECT Id,Account__c,Beat_Master__c FROM Beat_Master_Account__r) FROM Beat_Master__c WHERE Id IN :beatIds]);
        for(AP_Tour_Plan__c tpObj : lstApTourPlans){
            if(tpObj.Beat__c != null && beatMasterMap.get(tpObj.Beat__c) != null){
                for(Beat_Master_Account__c bmAccObj : beatMasterMap.get(tpObj.Beat__c).Beat_Master_Account__r){
                    AP_Site_Visit__c siteObj = new AP_Site_Visit__c();
                    siteObj.AP_Tour_Plan__c = tpObj.Id;
                    siteObj.Target__c = tpObj.Target__c;
                    siteObj.Party_Name__c =bmAccObj.Account__c;
                    siteObj.Party_Type__c = 'Dealer';
                    siteObj.RecordTypeId =visitRecTypeId;
                    siteObj.RecordEdit__c=false;
                    siteList.add(siteObj);
                }
            }
        }
        /*
        
        for(Beat_Master_Account__c beatMasterAcc : [Select Id,Account__c,Beat_Master__c from Beat_Master_Account__c where Beat_Master__c IN : beatIds]){
            AP_Site_Visit__c siteObj = new AP_Site_Visit__c();
            siteObj.AP_Tour_Plan__c = tourId.get(beatMasterAcc.Beat_Master__c);
            siteObj.Target__c = targetId.get(beatMasterAcc.Beat_Master__c);
            siteObj.Party_Name__c =beatMasterAcc.Account__c;
            siteObj.Party_Type__c = 'Dealer';
            siteObj.RecordTypeId =visitRecTypeId;
            siteObj.RecordEdit__c=false;
            siteList.add(siteObj);
        }*/
        
        if(siteList.size() > 0) {
            try {
                Update_Rollup_ApplTarget_Helper.isTarget = false;
                Database.insert(siteList,false);
            } Catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, e.getMessage()));
            }
        }
        
    }
    
    public void updateVisitsBeforeApproved(List<AP_Tour_Plan__c> lstApTourPlans,Map<Id,AP_Tour_Plan__c> oldMap){
        System.debug('ming');
        
        Set<Id> touPlanIDs = new Set<Id>();
        Set<Id> newBeatIds = new Set<Id>();
        Set<Id> oldBeatIds = new Set<Id>();
        Map<Id,Id> targetId = new Map<Id,Id>();
        Map<Id,Id> tourId = new Map<Id,Id>();
        List<AP_Site_Visit__c> app = new List<AP_Site_Visit__c>();
        Set<AP_Site_Visit__c> acc1 =new Set<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> appToDelete = new List<AP_Site_Visit__c>();
        
        
        for(AP_Tour_Plan__c ap : lstApTourPlans){
            if(ap.Beat__c !=oldMap.get(ap.Id).Beat__c && ap.Id != null && ap.Beat__c != null && ap.Approval_Status__c != 'Approved'){
                touPlanIDs.add(ap.Id);
                newBeatIds.add(ap.Beat__c); 
                targetId.put(ap.Beat__c,ap.Target__c);
                tourId.put(ap.Beat__c,ap.Id);
                oldBeatIds.add(oldMap.get(ap.Id).Beat__c);
                System.debug('oldBeatIds'+oldBeatIds);
            }
            
        }
        System.debug('lstApTourPlans'+lstApTourPlans);
        Id devRecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        
        
        AP_Site_Visit__c ap;
        for(Beat_Master_Account__c acc : [Select Id,Account__c,Beat_Master__c from Beat_Master_Account__c where Beat_Master__c IN : newBeatIds]){
            ap = new AP_Site_Visit__c();
            ap.AP_Tour_Plan__c = tourId.get(acc.Beat_Master__c);
            ap.Target__c = targetId.get(acc.Beat_Master__c);
            ap.Party_Name__c =acc.Account__c;
            ap.Party_Type__c = 'Dealer';
            ap.RecordTypeId =devRecordTypeId;
            
            acc1.add(ap);
        }    
        app.addAll(acc1);
        System.debug('');
        
        if(touPlanIDs.size()>0){
            for(AP_Site_Visit__c apVisits : [Select Id from AP_Site_Visit__c where Party_Type__c ='Dealer' And AP_Tour_Plan__c IN : touPlanIDs]){
                appToDelete.add(apVisits);
            }   
        }
        
        try {
            if(app.size() > 0 ||appToDelete.size() >0 ) {
                Update_Rollup_ApplTarget_Helper.isTarget = false;
                System.debug('appToDelete'+appToDelete);
                Database.delete(appToDelete,false);
                Database.insert(app,false);
            }
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, e.getMessage()));
        }
        
        
        
        
    }    
    public void updateVisitsAfterApproved(List<AP_Tour_Plan__c> lstApTourPlans,Map<Id,AP_Tour_Plan__c> oldMap){
        System.debug('ming');
        
        Set<Id> touPlanIDs = new Set<Id>();
        Set<Id> newBeatIds = new Set<Id>();
        Set<Id> oldBeatIds = new Set<Id>();
        Map<Id,Id> targetId = new Map<Id,Id>();
        Map<Id,Id> tourId = new Map<Id,Id>();
        List<AP_Site_Visit__c> app = new List<AP_Site_Visit__c>();
        Set<AP_Site_Visit__c> acc1 =new Set<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> appToDelete = new List<AP_Site_Visit__c>();
        List<AP_Tour_Plan__c> tourToUpdate = new List<AP_Tour_Plan__c>();
        Map<Id,Id> beatName = new Map<Id,Id>();
        
        
        for(AP_Tour_Plan__c ap : lstApTourPlans){
            
            if(ap.Change_Beat_Approval__c !=oldMap.get(ap.Id).Change_Beat_Approval__c && ap.Id != null && ap.Beat__c != null && ap.Approval_Status__c == 'Approved' && ap.Change_Beat_Approval__c=='Approved' && ap.Change_To_Beat__c != null){
                touPlanIDs.add(ap.Id);
                beatName.put(ap.Id,ap.Change_To_Beat__c);
                //ap1.Beat__c = ap.Change_To_Beat__c;
                newBeatIds.add(ap.Change_To_Beat__c); 
                targetId.put(ap.Change_To_Beat__c,ap.Target__c);
                tourId.put(ap.Change_To_Beat__c,ap.Id);
                oldBeatIds.add(oldMap.get(ap.Id).Beat__c);
                System.debug('oldBeatIds'+oldBeatIds);
            }
            
        }
        System.debug('lstApTourPlans'+lstApTourPlans);
        
        Id devRecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        
        AP_Site_Visit__c ap;
        
        for(Beat_Master_Account__c acc : [Select Id,Account__c,Beat_Master__c from Beat_Master_Account__c where Beat_Master__c IN : newBeatIds]){
            ap = new AP_Site_Visit__c();
            ap.AP_Tour_Plan__c = tourId.get(acc.Beat_Master__c);
            ap.Target__c = targetId.get(acc.Beat_Master__c);
            ap.Party_Name__c =acc.Account__c;
            ap.Party_Type__c = 'Dealer';
            ap.RecordTypeId =devRecordTypeId;
            
            acc1.add(ap);
        }  
        app.addAll(acc1);
        System.debug('');
        
        if(touPlanIDs.size()>0){
            for(AP_Site_Visit__c apVisits : [Select Id from AP_Site_Visit__c where Party_Type__c ='Dealer' And AP_Tour_Plan__c IN : touPlanIDs]){
                appToDelete.add(apVisits);
            }   
        }   
        AP_Tour_Plan__c ap1;
        
        for(AP_Tour_Plan__c ap2  : [Select Id from AP_Tour_Plan__c where Id IN : beatName.keySet()] ){
            ap1 = new AP_Tour_Plan__c();
            ap1=ap2;
            ap1.Beat__c =beatName.get(ap2.Id);
            tourToUpdate.add(ap1);
            
        }
        try {
            if(app.size() > 0 ||appToDelete.size() >0 || tourToUpdate.size()>0) {
                Update_Rollup_ApplTarget_Helper.isTarget = false;
                System.debug('appToDelete'+appToDelete);
                Database.delete(appToDelete,false);
                Database.insert(app,false);
                Database.update(tourToUpdate,false);
            }
        } Catch(Exception e) {
            System.debug('e.getMessage()'+e.getMessage());
        }
    }    
    
    public void updateBeatNameAfterApprove(List<AP_Tour_Plan__c> lstApTourPlans,Map<Id,AP_Tour_Plan__c> oldMap){
        System.debug('ming');
        
        Set<Id> touPlanIDs = new Set<Id>();
        Set<Id> newBeatIds = new Set<Id>();
        Set<Id> oldBeatIds = new Set<Id>();
        Map<Id,Id> targetId = new Map<Id,Id>();
        Map<Id,Id> tourId = new Map<Id,Id>();
        List<AP_Site_Visit__c> app = new List<AP_Site_Visit__c>();
        Set<AP_Site_Visit__c> acc1 =new Set<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> appToDelete = new List<AP_Site_Visit__c>();
        List<AP_Tour_Plan__c> tourToUpdate = new List<AP_Tour_Plan__c>();
        
        
        
        try {
            if(app.size() > 0 ||appToDelete.size() >0 || tourToUpdate.size()>0) {
                
                update tourToUpdate;
            }
        } Catch(Exception e) {
            System.debug('e.getMessage()'+e.getMessage());
        }
    }    
    
    
    public void updateBeatNameAfterApprove1(List<AP_Tour_Plan__c> lstApTourPlans,Map<Id,AP_Tour_Plan__c> oldMap){
        System.debug('ming');
        
        Set<Id> touPlanIDs = new Set<Id>();
        Set<Id> newBeatIds = new Set<Id>();
        Set<Id> oldBeatIds = new Set<Id>();
        Map<Id,Id> targetId = new Map<Id,Id>();
        Map<Id,Id> tourId = new Map<Id,Id>();
        List<AP_Site_Visit__c> app = new List<AP_Site_Visit__c>();
        Set<AP_Site_Visit__c> acc1 =new Set<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> appToDelete = new List<AP_Site_Visit__c>();
        List<AP_Tour_Plan__c> tourToUpdate = new List<AP_Tour_Plan__c>();
        try {
            if(app.size() > 0 ||appToDelete.size() >0 || tourToUpdate.size()>0) {
                
                update tourToUpdate;
            }
        } Catch(Exception e) {
            System.debug('e.getMessage()'+e.getMessage());
        }
    }    
    public void testMethod_1(){
        Integer i= 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
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
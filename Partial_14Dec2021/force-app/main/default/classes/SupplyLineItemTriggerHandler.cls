public class SupplyLineItemTriggerHandler {
    
    /***Class Level Variables***/
    private static SupplyLineItemTriggerHandler instance;
    private set<string> targetUserMonthSet = new set<string>();
    public map<Integer,list<SupplyLineItem__c>> mapOfSLI;
    public map<ID,map<Integer,list<SupplyLineItem__c>>> mapOfUserToMonthBySLI;
    public map<ID,map<Integer,map<ID,list<Decimal>>>> mapOfUserToMonthBySLIProductToPrices;
    
    /***Constructor***/
    public SupplyLineItemTriggerHandler() {
        mapOfSLI = new map<Integer,list<SupplyLineItem__c>>();  
        mapOfUserToMonthBySLI = new map<ID,map<Integer,list<SupplyLineItem__c>>>();
        mapOfUserToMonthBySLIProductToPrices = new  map<ID,map<Integer,map<ID,list<Decimal>>>>();
    }
    
    
    /*** Singleton Pattern to work on a single instance within a Execution Context***/
    public static SupplyLineItemTriggerHandler getInstance() {
        if(instance == null){
            instance = new SupplyLineItemTriggerHandler();  
        }
        return instance;    
    }
    
    /***Method called on After Insert***/
    public void onAfterInsert(list<SupplyLineItem__c> newList,list<SupplyLineItem__c> oldList,map<id,SupplyLineItem__c> newMap,map<id,SupplyLineItem__c> oldMap) {
        
        system.debug('***Inside after insert method***');
        
        
        for(SupplyLineItem__c sli : newList) {
            if(!sli.Retail_Project__c && sli.Invoice_Date__c!=null) {	
                String monthTarget = getMonthAndYearFromDate(sli.Invoice_Date__c);
                targetUserMonthSet.add(monthTarget+'-'+sli.lastModifiedByID);
            }
        }
        
        //UserID to Month to Product to listOfOrderValues.
        map<ID,map<Integer,map<ID,list<Decimal>>>> mapOfUserToMonthBySLIProductToPrices =  getUserByMonthBySLIs();
        map<String,Target__c> targetMap = new map<string, Target__c>();
        targetMap = getTargets(); // Querying target records for the particular User & Month.
        
        system.debug('***mapOfUserToMonthBySLIProductToPrices '+mapOfUserToMonthBySLIProductToPrices);
        system.debug('***targetMap '+targetMap);
        list<Target__c> targetList = new list<Target__c>();
        Target__c targetRecord;
        try {
            for(SupplyLineItem__c sli : newList) {
                if(!sli.Retail_Project__c && sli.Invoice_Date__c!=null) {	
                    String monthTarget = getMonthAndYearFromDate(sli.Invoice_Date__c);
                    system.debug(monthTarget);
                    system.debug(targetMap);
                    targetRecord = targetMap.get(monthTarget+'-'+sli.lastModifiedByID);
                    if(mapOfUserToMonthBySLIProductToPrices.get(sli.lastModifiedByID).get(sli.Invoice_Date__c.Month()).keyset().size()==1){
                        system.debug(targetRecord+'************');
                        targetRecord.Orders_with_Single_Product_A__c = getSummedUpValues(mapOfUserToMonthBySLIProductToPrices.get(sli.lastModifiedByID).get(sli.Invoice_Date__c.Month()).values());
                        targetRecord.Orders_with_all_Products_A__c = 0;
                    }
                    else {
                        targetRecord.Orders_with_all_Products_A__c = getSummedUpValues(mapOfUserToMonthBySLIProductToPrices.get(sli.lastModifiedByID).get(sli.Invoice_Date__c.Month()).values());
                        targetRecord.Orders_with_Single_Product_A__c = 0;
                    }	
                }
                //targetList.add(targetRecord);
            }
            System.Debug('***targetList'+targetList);
            
            update targetRecord; 	
        }
        catch(Exception de){
            System.Debug('***Exception occurred in onAfterInsert() methd***'+de.getMessage());
        }
        
    }
    
    public Decimal getSummedUpValues(list<list<Decimal>> listOfValuesToTotal) {
        Decimal total=0;
        for(list<Decimal> DecimalList :listOfValuesToTotal){
            for(Decimal eachDecimal:DecimalList){
                total += eachDecimal;
            }
        }
        system.debug(total);
        return total;
    }
    
    
    public map<ID,map<Integer,map<ID,list<Decimal>>>> getUserByMonthBySLIs() {
        
        for(SupplyLineItem__c eachSLI : [SELECT id,Product__c,Invoice_Date__c,Order_Value__c,LastModifiedByID from SupplyLineItem__c where Invoice_Date__c!=null]){
            if(!mapOfUserToMonthBySLIProductToPrices.containsKey(eachSLI.LastModifiedByID)) {    
                mapOfUserToMonthBySLIProductToPrices.put(eachSLI.LastModifiedByID,new Map<Integer,map<ID,list<Decimal>>>{eachSLI.Invoice_Date__c.Month()=>new map<ID,list<Decimal>>{eachSLI.Product__c=>new list<Decimal>{eachSLI.Order_Value__c}}});
            }
            else if(mapOfUserToMonthBySLIProductToPrices.containsKey(eachSLI.LastModifiedByID)) {
                if(eachSLI.Invoice_Date__c !=null){
                    if(mapOfUserToMonthBySLIProductToPrices.get(eachSLI.LastModifiedByID).containsKey(eachSLI.Invoice_Date__c.Month())){
                        if(mapOfUserToMonthBySLIProductToPrices.get(eachSLI.LastModifiedByID).get(eachSLI.Invoice_Date__c.Month()).containsKey(eachSLI.Product__c)){
                            mapOfUserToMonthBySLIProductToPrices.get(eachSLI.LastModifiedByID).get(eachSLI.Invoice_Date__c.Month()).get(eachSLI.Product__c).add(eachSLI.Order_Value__c); 
                        }else{
                            mapOfUserToMonthBySLIProductToPrices.get(eachSLI.LastModifiedByID).get(eachSLI.Invoice_Date__c.Month()).put(eachSLI.Product__c,new list<Decimal>{eachSLI.Order_Value__c});
                        }  
                    }
                    else{
                        mapOfUserToMonthBySLIProductToPrices.get(eachSLI.LastModifiedByID).put(eachSLI.Invoice_Date__c.Month(),new map<ID,list<Decimal>>{eachSLI.Product__c=>new list<Decimal>{eachSLI.Order_Value__c}});
                    }
                }       
            }
        }
        return mapOfUserToMonthBySLIProductToPrices;
    }
    
    
    private String getMonthAndYearFromDate(Date invoiceDate) {
        String monthName;
        String year;
        try {
            monthName =    getMonNoToMonthNameMap().get(invoiceDate.Month());
            year      =    String.valueOf(invoiceDate.Year());
        }
        catch(Exception e) {
            system.debug('***Exception in getMonthAndYearFromDate() Method'+e.getMessage());
        }
        return monthName+' - '+year;
    }
    
    
    //Helper Method to fetch all the records.
    private map<String,Target__c> getTargets() {
        
        /***This map will include September - 2015-00530000009X3F9 => Target Record ***/
        map<String,Target__c> targetMap = new map<String,Target__c>();
        String str;
        if(targetUserMonthSet.size() > 0) {
            try {
                for(Target__c eachTarget : [SELECT Month__c,Target_User_Month__c, OwnerID,Orders_with_Single_Product_A__c,Orders_with_all_Products_A__c from Target__c where Target_User_Month__c IN: targetUserMonthSet]){
                    
                    targetMap.put(eachTarget.Target_User_Month__c,eachTarget);  
                }
            }
            catch(Exception e) {
                System.Debug('*** Exception in getTargets() Method'+e.getMessage());
            }
        }
        return targetMap;
    }
    
    /***Helper Method to fetch the Month Name against a Month No.***/
    public map<Integer,String> getMonNoToMonthNameMap() {
        
        map<Integer,String> monthNoToNameMap = new map<Integer,String>();
        
        monthNoToNameMap.put(1,'January');
        monthNoToNameMap.put(2,'February');
        monthNoToNameMap.put(3,'March');
        monthNoToNameMap.put(4,'April');
        monthNoToNameMap.put(5,'May');
        monthNoToNameMap.put(6,'June');
        monthNoToNameMap.put(7,'July');
        monthNoToNameMap.put(8,'August');
        monthNoToNameMap.put(9,'September');
        monthNoToNameMap.put(10,'October');
        monthNoToNameMap.put(11,'November');
        monthNoToNameMap.put(12,'December');
        
        return monthNoToNameMap;
    }
}
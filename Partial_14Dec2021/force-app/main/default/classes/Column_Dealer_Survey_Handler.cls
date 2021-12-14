public class Column_Dealer_Survey_Handler {
    @AuraEnabled
    public static list<String> getOtherPickListValues(String fieldName){
        List<String> pickListValuesList= new List<String>();
        if(fieldName == 'Conversion_Time_From_GI_to_Column__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Conversion_Time_From_GI_to_Column__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }     
        }
        else if(fieldName == 'Credit_Facility_given_to_dealer_by_Pipe__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Credit_Facility_given_to_dealer_by_Pipe__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }     
        }
        else if(fieldName == 'Electricity_connection__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Electricity_connection__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }     
        }
        else if(fieldName == 'Hdpe_fast_moving_Size_Inch__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Hdpe_fast_moving_Size_Inch__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }     
        }
        else if(fieldName == 'Type_of_Influencers_of_Dealer__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Type_of_Influencers_of_Dealer__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            }
        }
             else if(fieldName == 'Fast_Moving_Size__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Fast_Moving_Size__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            } 
             }
                  else if(fieldName == 'Color_of_tank__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Color_of_tank__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            } 
        }
          else if(fieldName == 'Agri_fast_moving_Size_Inch__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Agri_fast_moving_Size_Inch__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            } 
        }
        else if(fieldName == 'Casting_fast_moving_Size_Inch__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Casting_fast_moving_Size_Inch__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            } 
        }
        else if(fieldName == 'Column_fast_moving_Size_Inch__c'){
            Schema.DescribeFieldResult fieldResult = Column_dealer_Survey__c.Column_fast_moving_Size_Inch__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                pickListValuesList.add(pickListVal.getLabel());
            } 
        }
        return pickListValuesList;
    }
    @AuraEnabled
    public static void saveColumnRecords(List<Column_dealer_Survey__c> columnDealerSurvey){
        Map<String,Id> recordTypeMap = new Map<String,Id>();
        for(RecordType recType : [select Id,Name from recordtype where sObjectType = 'Column_dealer_Survey__c']){
            system.debug(recType.Name);
            recordTypeMap.put(recType.Name.toLowerCase(),recType.Id);
        }
        for(String s:recordTypeMap.keyset())
            system.debug(s+' ------>  '+recordTypeMap.get(s));
        for(Column_dealer_Survey__c cdSurvey : columnDealerSurvey){
            system.debug(recordTypeMap.get(cdSurvey.Product_sold_by_dealer__c.toLowerCase()));
            if(recordTypeMap.containsKey(cdSurvey.Product_sold_by_dealer__c.toLowerCase())){
                system.debug('Inside If of RecordType'+ recordTypeMap.get(cdSurvey.Product_sold_by_dealer__c.toLowerCase()));
                cdSurvey.RecordTypeId = recordTypeMap.get(cdSurvey.Product_sold_by_dealer__c.toLowerCase());
                system.debug(cdSurvey.RecordTypeId);
            }
        }
        insert columnDealerSurvey;
    }
    @AuraEnabled 
    public static Map<String, List<String>> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            return objResults;     
        }
        
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        return objResults;
    }
    
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    
    @AuraEnabled
    public static Map<String, String> getFieldLabelNameAndApi() {
        Map<String, String> fieldLabelMap = new Map<String, String>();
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        try {
            System.debug('coming in con');
            Map <String, Schema.SObjectField> fieldMap = schemaMap.get('Column_dealer_Survey__c').getDescribe().fields.getMap();
            for(Schema.SObjectField sfield : fieldMap.Values()) {
                schema.describefieldresult dfield = sfield.getDescribe();
                fieldLabelMap.put(dfield.getLabel(), dfield.getname());
                System.debug('Label : ' + dfield.getLabel());
                System.debug('Value : ' + dfield.getname());
            }
        } catch (Exception ex) {
            System.debug('Exception is ' + ex);
        }
        return fieldLabelMap;
    }
    
    @AuraEnabled
    public static Map<String, String> abc() {
        Map<String, String> fieldLabelMap = new Map<String, String>();
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        try {
            System.debug('coming in con');
            Map <String, Schema.SObjectField> fieldMap = schemaMap.get('Column_dealer_Survey__c').getDescribe().fields.getMap();
            for(Schema.SObjectField sfield : fieldMap.Values()) {
                schema.describefieldresult dfield = sfield.getDescribe();
                String trimLabelName = dfield.getLabel();
                trimLabelName = trimLabelName.substring(trimLabelName.lastIndexOf('-') + 1, trimLabelName.length());
                fieldLabelMap.put(trimLabelName, dfield.getname());
                System.debug('Label : ' + dfield.getLabel());
                System.debug('Value : ' + dfield.getname());
            }
        } catch (Exception ex) {
            System.debug('Exception is ' + ex);
        }
        return fieldLabelMap;
    }
    
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){            
        }
        
    }
}
/*
Created by : Deepak Singh
Created date : 1/08/2020
*/
public without sharing class DealerSignUpController {
    
    public List<SelectOption> townList {get;private set;}
    public List<SelectOption> stateList {get;private set;}
    public string selectedState{get;set;}
    public string selectedSTown{get;set;}
    public string enterdPhone{get;set;}
    public string yearSince{get;set;}
    public string accName{get;set;}
    public Integer size {get;private set;}
    public map<string,list<string>> mapOfStateAndDistrict = new map<string,list<string>>();
    
    public DealerSignUpController(){
        size = 1;
        townList = new List<SelectOption>();
        mapOfStateAndDistrict = getDependentMap(new account(),'State__c','District__c');
        stateList= new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.State__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        stateList.add(new SelectOption('--None--','--None--'));
        for( Schema.PicklistEntry pickListVal : ple){
            stateList.add(new SelectOption(pickListVal.getValue(),pickListVal.getLabel()));
        } 
    }
    
    
    
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
    
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){            
        }
        
    } 
    
    
    public Pagereference createRetailer(){
        try{
            string stateHeadRoleName = '%'+selectedState+'%';
            selectedState = string.escapeSingleQuotes(selectedState);
            system.debug('stateHeadRoleName==>'+stateHeadRoleName);
            list<user> stateHead = [select id from user where User_State__c like :stateHeadRoleName and state_head__c = true];
            user cartUser = [select id from user where isActive = true and profile.name = 'Customer Support Team' limit 1];
            system.debug('stateHead==>'+stateHead);
            system.debug('stateHead.size()='+stateHead.size());
            
            //Added by Riya for CRUD and FLS check
            String [] accFields = new String [] {'Name','Order_portal_status__c','State__c','District__c','Year_Since_in_Business__c',
                'TGM_user__c','OwnerId','From_order_portal__c'};
                    
                    // Obtaining the field name/token map for the Account object                                                    
                    Map<String,Schema.SObjectField> m = Schema.SObjectType.Account.fields.getMap();
            for (String fieldToCheck : accFields)
            {
                // Check if the user has create access on the each field
                if (!m.get(fieldToCheck).getDescribe().isCreateable()) 
                {
                    system.debug('Access error');
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to create Account'));
                    return null;
                }
            }
            system.debug('Eeeeee');
            account acc = new account();
            Acc.Order_portal_status__c = 'Prospect Dealer';
            acc.Name = accName;
            acc.State__c = selectedState;
            acc.District__c = selectedSTown;
            acc.Year_Since_in_Business__c = yearSince;
            acc.Contact_Number_Mobile__c = enterdPhone;
            
            if(stateHead.size()>0){
                acc.TGM_user__c = stateHead[0].id; 
                acc.OwnerId = stateHead[0].id;
            }
            else{
                acc.TGM_user__c = cartUser.id;
                acc.OwnerId = cartUser.id;
            }
            
            acc.From_order_portal__c = true;
            DataBase.insert(acc);
            System.debug('accountid'+acc.Id);
            Pagereference px2 = page.succesfulSignUp;
            px2.setRedirect(false);
            system.debug('before return');
            return px2;
            
        }
        catch(exception e){
            System.debug('Error at line:'+e.getLineNumber());
            System.debug('Error Message: '+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Unable to insert Account'));
            return null;
        }
        
    } 
    public void enableTGM(){
        system.debug('stste==>'+selectedState);
        townList.clear();
        townList.add(new SelectOption('--None--','--None--'));
        for(string towns : mapOfStateAndDistrict.get(selectedState)){
            townList.add(new SelectOption(towns,towns));
        }
    }
    
}
public class NpsController {
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
    
    @AuraEnabled
    public static List<String> getPartyType() {
        List<String> partyName = new List<String>();
        try {
            List<PartyTypeCustomSetting__c> partyNameCustomList = PartyTypeCustomSetting__c.getall().values(); // Fetching party type name from custom setting.
            for(PartyTypeCustomSetting__c ptName : partyNameCustomList) {
                partyName.add(ptName.Name);
            }
            system.debug('accShare' + partyName);
        } catch(Exception ex) {
            System.debug('Exception occured in getPartyType ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        return partyName; 
    }

    @AuraEnabled
    public static List<String> getStatus() {
        List<String> statusPickvals = new List<String>();
        try {
            /* code to fetch 'Status' picklist value */
            Schema.DescribeFieldResult describesObject = Account.Status__c.getDescribe(); 
            Schema.sObjectField fieldsOfPickList = describesObject.getSObjectField();
            List<PicklistEntry> entries = fieldsOfPickList.getDescribe().getPicklistValues();
            
            for(Schema.PicklistEntry iterateValues : entries) { //for all values in the picklist list
                statusPickvals.add(iterateValues.getValue());	//add the value  to our final list
            }
        } catch(Exception ex) {
            System.debug('Exception occured in getStatus ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        return statusPickvals;
    }
    

    @AuraEnabled
    public static List<Account> getFilteredAccount(String stateName, String districtName, Date toDate, Date fromDate, String partyType, String selectedTalukId, String pageSize, String pageNumber, String status) {
        
        List<Account> accList;
        String accountDynamicQuery;
        String noneAttribute = '--None--';

        Integer psize = Integer.valueOf(pageSize);
        Integer pnumber = Integer.valueOf(pageNumber)-1;
        Integer offsetValue = psize*pnumber;

        System.debug('psize ** ' + psize); 
        System.debug('pnumber ** ' + pnumber); 
        System.debug('toDate ** ' + toDate); 
        System.debug('fromDate ** ' + fromDate);
        System.debug('stateName ** ' + stateName); 
        System.debug('districtName ** ' + districtName);
        System.debug('partyType ** ' + partyType);
        System.debug('selectedTalukId ** ' + selectedTalukId);
        System.debug('status ** ' + status);
        try {
          /*  accList = new List<Account>([SELECT Id, Name, State__c, District__c, Party_Type__c, APPL_Taluk__c FROM Account 
                                         WHERE APPL_Taluk__r.AP_Taluk_Master__r.Id =: selectedTalukId OR (State__c =: stateName AND District__c =: districtName AND 
                                         Party_Type__c =: partyType AND (CreatedDate >: fromDate AND CreatedDate <: toDate) AND NpsTagged__c = false)
                                         LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)]);*/
            
            if (selectedTalukId == noneAttribute && status == noneAttribute) {
                accountDynamicQuery = 'SELECT Id, Name, State__c, District__c, Party_Type__c, APPL_Taluk__c FROM Account WHERE'
                + ' State__c =: stateName AND District__c =: districtName'
                + ' AND Party_Type__c =: partyType AND Rating_Capture_Date__c >=: fromDate AND Rating_Capture_Date__c <=: toDate AND NpsTagged__c = false'
                + ' LIMIT :psize OFFSET :offsetValue';
            } else if(selectedTalukId != noneAttribute && status == noneAttribute) {
                accountDynamicQuery = 'SELECT Id, Name, State__c, District__c, Party_Type__c, APPL_Taluk__c FROM Account WHERE'
                + ' APPL_Taluk__r.AP_Taluk_Master__r.Id =: selectedTalukId AND State__c =: stateName AND District__c =: districtName'
                + ' AND Party_Type__c =: partyType AND Rating_Capture_Date__c >=: fromDate AND Rating_Capture_Date__c <=: toDate AND NpsTagged__c = false'
                + ' LIMIT :psize OFFSET :offsetValue';
            } else if(selectedTalukId != noneAttribute && status != noneAttribute) {
                accountDynamicQuery = 'SELECT Id, Name, State__c, District__c, Party_Type__c, APPL_Taluk__c FROM Account WHERE'
                + ' APPL_Taluk__r.AP_Taluk_Master__r.Id =: selectedTalukId AND State__c =: stateName AND District__c =: districtName'
                + ' AND Status__c =: status'
                + ' AND Party_Type__c =: partyType AND Rating_Capture_Date__c >=: fromDate AND Rating_Capture_Date__c <=: toDate AND NpsTagged__c = false'
                + ' LIMIT :psize OFFSET :offsetValue';
            } else if(selectedTalukId == noneAttribute && status != noneAttribute) {
                accountDynamicQuery = 'SELECT Id, Name, State__c, District__c, Party_Type__c, APPL_Taluk__c FROM Account WHERE'
                + ' State__c =: stateName AND District__c =: districtName AND Status__c =: status'
                + ' AND Party_Type__c =: partyType AND Rating_Capture_Date__c >=: fromDate AND Rating_Capture_Date__c <=: toDate AND NpsTagged__c = false'
                + ' LIMIT :psize OFFSET :offsetValue';
            }
                 
            System.debug('accountDynamicQuery ** ' + accountDynamicQuery);                        
            accList = Database.query(accountDynamicQuery);
            System.debug('accList ** ' + accList);    
        } catch(Exception ex) {
            System.debug('Exception occured in getFilteredAccount ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        System.debug('accList size is ' + accList.size());
        return accList;
    }
    
    @AuraEnabled
    public static List<Account> getTaggedAccount(String executiveName, String pageSize, String pageNumber) {
        
        List<NPS__c> npsList = new List<NPS__c>();
        List<Account> accountList = new List<Account>();
        Set<Id> accountIdSet = new Set<Id>();

        System.debug('getTaggedAccount executiveName ' + executiveName);

        Integer psize = Integer.valueOf(pageSize);
        Integer pnumber = Integer.valueOf(pageNumber)-1;

        npsList = [SELECT Id, Account__c, Executive_Name__c FROM NPS__c WHERE Executive_Name__c =: executiveName AND
                     (Status__c = 'Open' OR Status__c = 'Onhold') AND Account__c != null]; 

        System.debug('npsList getTaggedAccount ' + npsList);

        for (NPS__c npsRecord : npsList) {
            accountIdSet.add(npsRecord.Account__c);
        }
        accountList = [SELECT Id, Name, State__c, District__c, Party_Type__c FROM Account WHERE Id IN: accountIdSet LIMIT :Integer.valueOf(psize) OFFSET :(psize*pnumber)];
        System.debug('accountList getTaggedAccount ' + accountList);
        return accountList;
    }

    @AuraEnabled
    public static void assignNewExecutive(String selectedNewExecutive, List<String> selectedTaggedAccount) {
        
        try {
            List<NPS__c> npsFromAccountList = new List<NPS__c>();
            
            npsFromAccountList = [SELECT Id, Account__c, Executive_Name__c FROM NPS__c WHERE Account__c IN: selectedTaggedAccount
                                     AND (Status__c = 'Open' OR Status__c = 'Onhold')]; 

            System.debug('npsFromAccountList is ** ' + npsFromAccountList);
            for(NPS__c npsRecords : npsFromAccountList) {
                npsRecords.Executive_Name__c = selectedNewExecutive;
            }
            System.debug('npsFromAccountList is ** ' + npsFromAccountList);
            if(!npsFromAccountList.isEmpty() && npsFromAccountList.size() > 0) {
                Update npsFromAccountList;
            }
            
        } catch(Exception ex) {
            System.debug('Exception occured in assignNewExecutive ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        
    }

    @AuraEnabled
    public static List<String> getExecutiveNameList() {
        List<String> projectPickvals = new List<String>();
        try {
            /* code to fetch 'Executive Name' picklist value */
            Schema.DescribeFieldResult describesObject = Feedback__c.Call_Center_Person_Name__c.getDescribe(); 
            Schema.sObjectField fieldsOfPickList = describesObject.getSObjectField();
            List<PicklistEntry> entries = fieldsOfPickList.getDescribe().getPicklistValues();
            
            for(Schema.PicklistEntry iterateValues : entries) { //for all values in the picklist list
                projectPickvals.add(iterateValues.getValue());	//add the value  to our final list
            }
        } catch(Exception ex) {
            System.debug('Exception occured in getExecutiveNameList ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        return projectPickvals;
    }
    
    // Selected account field 'NpsTagged' will be updated and child record 'NPS' will created under Account.
    @AuraEnabled
    public static void createNPSRecords(String recordTypeName, String executiveName, List<String> selectedAccount) {
        try {
            List<NPS__c> npsList = new List<NPS__c>();
            List<Account> accList = new List<Account>();
            
            Id recordTypeId = Schema.SObjectType.NPS__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
            System.debug('recordTypeId **** ' + recordTypeId);
            System.debug('selectedAccount **** ' + selectedAccount);
            
            
            for(String accountId : selectedAccount) {
                NPS__c nps = new NPS__c();
                nps.Executive_Name__c = executiveName;
                nps.Account__c = accountId;
                nps.RecordTypeId = recordTypeId;
                nps.Status__c = 'Open';
                npsList.add(nps);
                
                Account acc = new Account();
                acc.NpsTagged__c = true;
                acc.Id = accountId;
                accList.add(acc);
            }
            System.debug('npsList is ** ' + npsList);
            if(!npsList.isEmpty() && npsList.size() > 0) {
                Insert npsList;
            }
            
            if(!accList.isEmpty() && accList.size() > 0) {
                System.debug(' in Update  ** ' + accList);
                Update accList;
            }
            
        } catch(Exception ex) {
            System.debug('Exception occured in createNPSRecords ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
    
    @AuraEnabled
    public static Map<String, Integer> npsAssignmentValidation(List<String> selectedAccount) {
        System.debug(' in npsAssignmentValidation method ** ' + selectedAccount);
        List<Account> accList = new List<Account>();
        Map<String, Integer> npsMap = new Map<String, Integer>();
        
        // Fetching nps record which are created today for select account
        if (selectedAccount.size() > 0 && !selectedAccount.isEmpty()) {
            for (NPS__c npsRecord : [SELECT Id, Name, Account__c, Account__r.Name FROM NPS__c WHERE CreatedDate = today AND Account__c IN : selectedAccount]) {
                String mapKey = npsRecord.Account__c + '@' + npsRecord.Account__r.Name;
                if (!npsMap.isEmpty() && npsMap.containsKey(mapKey) && npsMap.get(mapKey) != null) {
                    npsMap.put(mapKey, (npsMap.get(mapKey) + 1));
                } else {
                    npsMap.put(mapKey, 1);
                }
            }
        }
        System.debug(' in npsAssignmentValidation npsMap ** ' + npsMap);
        return npsMap;
    }

    @AuraEnabled
    public static List<AP_Taluk_Master__c> fetchTalukList(String stateName, String districtName) {
        List<AP_Taluk_Master__c> talukList;
        try {
            talukList = new List<AP_Taluk_Master__c>([SELECT Id, Name, State__c, District__c FROM AP_Taluk_Master__c WHERE State__c =: stateName AND District__c =: districtName]);           
            System.debug('talukList ' + talukList);
        } catch(Exception ex) { 
            System.debug('Exception occured in fetchTalukList method ** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        return talukList;
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
        
        public PicklistEntryWrapper() {
            
        }
    }
    
}
public with sharing class AddingDealerInBeatController{
    @AuraEnabled 
    public static Object fetchAccountWrapper(){     
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        Set<Id> beatMastetrId = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        Date todays =System.today();
        System.debug('todays.day()'+todays.day());  
        
        
        if( todays.day()> 0){
            for(Beat_Master__c beatMaster : [Select Id from Beat_Master__c]){
                beatMastetrId.add(beatMaster.Id);
                
            }
            for(Beat_Master_Account__c beat : [Select id,Account__c from Beat_Master_Account__c where Beat_Master__c In :beatMastetrId And Account__c != null]){
                accIds.add(beat.Account__c);
            }
            // query account records and create 'accountListWrapper' class instance for each record. 
            String s;
            for(Account acc : [Select id,Name,City__c,District__c,State__c,Sparsh_Code__c,Contact_Number_Mobile__c from Account where Id NOT IN : accIds And  Beat_Area__c =false And Party_Type__c ='Dealer' And RecordType.Name='Dealer' Order By Name]){
                s=acc.Name+(acc.Sparsh_Code__c != null && acc.Sparsh_Code__c != ''?acc.Sparsh_Code__c:'')+(acc.City__c != null && acc.City__c != ''?acc.City__c:'')+(acc.Contact_Number_Mobile__c != null && acc.Contact_Number_Mobile__c != ''?acc.Contact_Number_Mobile__c:'')+(acc.State__c != null && acc.State__c != ''?acc.State__c:'')+(acc.District__c != null && acc.District__c != ''?acc.District__c:'');
                // by default checkbox should be false 
                lstaccountListWrapper.add(new accountListWrapper(false,acc,s));
            } 
            // return the 'lstaccountListWrapper' list 
            return lstaccountListWrapper;  
        }else{
            return null;  
        }
        
        
        
        
    }
    
    /* wrapper class */  
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked;
        @AuraEnabled public account objAccount;
        @AuraEnabled public  String searchField;
        
        public accountListWrapper(boolean isChecked, account objAccount,String searchField){
            this.isChecked = isChecked;
            this.objAccount = objAccount;
            this.searchField =searchField;
        }
    }
    
}
@isTest
public class NpsController_Test {
    
    @testSetup static void setup() {
        Id DlrRcdType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        
        List<Account> accList = new List<Account>();
        
        PartyTypeCustomSetting__c partyName = new PartyTypeCustomSetting__c();
        partyName.Name = 'Dealer';
        partyName.PartyName__c = 'Dealer';
        Insert partyName;
        
        AP_Taluk_Master__c apTaluk = new AP_Taluk_Master__c();
        apTaluk.Name = 'Jaipur';
        apTaluk.State__c = 'Rajasthan';
        apTaluk.District__c = 'Jaipur';
        Insert apTaluk;
        
        User u = new User();
        u.Id = UserInfo.getUserId();
        
        Account acc = new Account();
        acc.Name ='akh';
        acc.Primary_Contact_Person_Name__c='Vivek Rungta ';
        acc.Classification__c='A';
        acc.Purchase_Cycle__c='Weekly';
        acc.Contact_Number_Mobile__c='9308622241';
        acc.Street_Address__c='Station road';
        acc.Display_of_our_product__c='Prominent';
        acc.Type_of_Dealer__c='Sanitary';
        acc.Media__c='Outshop';    
        acc.Market__c ='Existing';
        acc.Party_Type__c='Dealer';
        acc.Status__c = 'Existing'; 
        acc.OwnerId=u.id;
        acc.Discount__c=50.50;
        acc.VAT_CST_Number__c='123456789789123';
        acc.Annual_Ashirvad_Turnover__c=50;
        acc.Year_Since_in_Business__c='2018';
        acc.Conversion_Probability__c = 'Medium';
        acc.RecordTypeId = DlrRcdType;
        acc.NpsTagged__c = false;
        accList.add(acc);       
        Insert accList;
    }
    
    @isTest static void npsMethodDealer() {
        try {
            
            List<String> accListToSend = new List<String>();
            String npsId;
            Account a = new Account();
            String state = 'State__c';
            String dist = 'District__c';
            
            String selectedState = 'Rajasthan';
            String selectedDist = 'Jaipur';
            
            Id npsRecordType = Schema.SObjectType.NPS__c.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
            
            PartyTypeCustomSetting__c pName = [SELECT Id, PartyName__c FROM PartyTypeCustomSetting__c];
            
            String accId = [SELECT Id FROM Account].Id;
            List<String> listAccId = new List<String>();
            for(Account acc : [SELECT Id FROM Account]) {
                listAccId.add(acc.Id);
            }
            accListToSend.add(accId);
            System.debug('accListToSend *** ' + accListToSend);
            
            List<NPS__c> npsList = new List<NPS__c>();        
            NPS__c nps = new NPS__c();
            nps.Executive_Name__c = 'Call Center Executive 1';
            nps.Account__c = accId;
            nps.RecordTypeId = npsRecordType;
            nps.Status__c = 'Open';
            npsList.add(nps);
            Insert npsList;
            
            npsId = npsList[0].Id;
            
            Id apTalukId = [SELECT Id FROM AP_Taluk_Master__c LIMIT 1].Id;
            System.assertEquals('Dealer', pName.PartyName__c);
            
            NpsController.getDependentMap(a, state, dist); 
            NpsController.getPartyType();
            NpsController.getFilteredAccount('Rajasthan', 'Jaipur', System.today(), System.today()+2, 'Dealer', apTalukId,'10', '2', 'Existing');
            NpsController.getExecutiveNameList();
            NpsController.fetchTalukList(selectedState, selectedDist);
            NpsController.npsAssignmentValidation(listAccId);
            NpsController.createNPSRecords('Dealer', 'Call Center Executive 1', accListToSend);
            NpsController.decimalToBinary(5);
            NpsController.base64ToBits('testclass'); 
            NpsController.getStatus();
            NpsController.getTaggedAccount('Call Center Executive 1', '10', '2');
            NpsController.assignNewExecutive('Call Center Executive 1', accListToSend);
            customLookUpController.fetchLookUpValues('Test', 'Account');
            
        } catch(Exception ex) {
            System.debug('Exception in npsMethod test ' + ex);
        }
    }
    
}
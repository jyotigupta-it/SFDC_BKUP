/* 
* Name      : RegisterPlumber
* Purpose   : This class is used as an utility to Register new Plumber.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class RegisterPlumber{
    public class PlumberInput {
        @InvocableVariable(required = true)
        public String plumberName;
        @InvocableVariable(required = true)
        public String plumberPinCode;
        @InvocableVariable(required = true)
        public String plumberAddress;
        @InvocableVariable(required=true)
        public String endUserId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String Status;
        @InvocableVariable(required=true)
        public String plumberId;
    }
    @InvocableMethod(label='Register New Plumber')
    public static List<PlumberOutput> registerNewPlumber(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<MessagingEndUser> messagingUserList = new List<MessagingEndUser>();
        List<Pincode__c> pincodeList = new List<Pincode__c>();
        PlumberOutput pOutput = new PlumberOutput();
        String phNumber = '';
        pOutput.plumberId = '';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
        
        if(plumberInputs.size() > 0){
            Account acc = new Account();
            messagingUserList = [SELECT Id,Name FROM MessagingEndUser WHERE Id =:plumberInputs[0].endUserId];
            phNumber = messagingUserList[0].Name.right(10);
            pincodeList = [SELECT Id,City__c,City__r.Name,District__c,District__r.Name,State__c,State__r.Name FROM Pincode__c WHERE Name =:plumberInputs[0].plumberPinCode];
            acc.Name = plumberInputs[0].plumberName;
            acc.Contact_Number_Mobile__c = phNumber;
            acc.RecordTypeId = recordTypeId;
            acc.Party_Type__c = 'Plumber';
            acc.Plumber_Club_Member_Category__c = 'Purple';
            acc.PIN_Code__c = plumberInputs[0].plumberPinCode != null ? plumberInputs[0].plumberPinCode : '';
            acc.District__c = pincodeList.size() > 0 && pincodeList[0].District__c != null ? pincodeList[0].District__r.Name : '';
            acc.State__c = pincodeList.size() > 0 && pincodeList[0].State__c != null ? pincodeList[0].State__r.Name : '';
            acc.Street_Address__c = plumberInputs[0].plumberAddress;
            INSERT acc;
            
            pOutput.Status = 'Success';
            pOutput.plumberId = acc.Id;
        }
        else
            pOutput.Status = 'Error';
        
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
/* 
* Name      : WhatsAppCaseCreation
* Purpose   : This class is used as an utility to create case from WhatsApp BOT.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class WhatsAppCaseCreation{
    public class PlumberInput {
        @InvocableVariable
        public String plumberId;
        @InvocableVariable
        public String claimID;
        @InvocableVariable
        public String issueDesc;
        @InvocableVariable
        public String issueType;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String status;
    }
    @InvocableMethod(label='Create Issue')
    public static List<PlumberOutput> createCase(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        PlumberOutput pOutput = new PlumberOutput();
        pOutput.status = 'Success';
        try{
            Case caseObj = new Case();
            List<Claim__c> claimList = new List<Claim__c>();
            Id caseRecTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Plumber Claim').getRecordTypeId();
            if(plumberInputs[0].claimID != null && plumberInputs[0].claimID != '')
                claimList = [SELECT Id FROM Claim__c WHERE Name =:plumberInputs[0].claimID];
            caseObj.AccountId = plumberInputs[0].plumberId;
            caseObj.Description = plumberInputs[0].issueDesc;
            if(claimList.size() > 0)
                caseObj.Claim__c = claimList[0].Id;
            caseObj.RecordTypeId = caseRecTypeId;
            caseObj.Origin = 'WhatsApp BOT';
            caseObj.Subject = plumberInputs[0].issueType;
            INSERT caseObj;
            System.debug(caseObj.Id);
        }
        catch(Exception e){
            System.debug(e.getStackTraceString());
        }
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
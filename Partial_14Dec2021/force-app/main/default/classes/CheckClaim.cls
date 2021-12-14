/* 
* Name      : CheckClaim
* Purpose   : This class is used as an utility to check Claim is valid.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class CheckClaim {
    public class PlumberInput {
        @InvocableVariable
        public String plumberId;
        @InvocableVariable
        public String claimId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String status;
    }
    @InvocableMethod(label='Check Claim Status')
    public static List<PlumberOutput> getClaimStatus(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Claim__c> claimList = new List<Claim__c>();
        PlumberOutput pOutput = new PlumberOutput();
        claimList = [SELECT Id FROM Claim__c WHERE Plumber_Scheme__r.Plumber__c =:plumberInputs[0].plumberId AND Name =:plumberInputs[0].claimId];
        if(claimList.size() >0)
            pOutput.status = 'Valid';
        else
            pOutput.status = 'InValid';
        
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
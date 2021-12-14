/* 
* Name      : FetchSchemeDetails
* Purpose   : This class is used as an utility to fetch all claims done by any plumber.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class FetchSchemeDetails {
    public class PlumberInput {
        @InvocableVariable
        public String plumberId;
        @InvocableVariable
        public String schemeId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String claimDetails;
        @InvocableVariable
        public String schemeId;
    }
    @InvocableMethod(label='Fetch Claim Details')
    public static List<PlumberOutput> getClaimDetails(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Claim__c> claimList = new List<Claim__c>();
        PlumberOutput pOutput = new PlumberOutput();
        Integer counter = 1;
        pOutput.claimDetails = '';
        claimList = [SELECT Id,Name,Status__c,Capacity__c FROM Claim__c WHERE Plumber_Scheme__r.Plumber__c =:plumberInputs[0].plumberId AND Plumber_Scheme__r.Scheme__r.Is_active__c = true];
        for(Claim__c cliamObj : claimList){
            pOutput.claimDetails += counter+'. Claim Id: '+cliamObj.Name+', Capacity: '+cliamObj.Capacity__c+', Status: '+cliamObj.Status__c+'\n';
            counter++;
        }
        if(pOutput.claimDetails == '')
            pOutput.claimDetails = 'No Claim Details Found!';
        pOutput.schemeId = plumberInputs[0].schemeId;
        
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
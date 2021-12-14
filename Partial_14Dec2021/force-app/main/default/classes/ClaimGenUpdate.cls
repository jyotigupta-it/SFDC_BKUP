/* 
* Name      : ClaimGenUpdate
* Purpose   : This class is used as an utility to update claim link generation time stamp.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class ClaimGenUpdate {
    public class PlumberInput {
        @InvocableVariable
        public String sessionId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String status;
    }
    @InvocableMethod(label='Update Claim Details')
    public static List<PlumberOutput> updateClaimDetails(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        PlumberOutput pOutput = new PlumberOutput();
        try{
            pOutput.status = 'Success';
            if(plumberInputs[0].sessionId != null && plumberInputs[0].sessionId != '')
                UPDATE new MessagingSession(Id = plumberInputs[0].sessionId,Claim_Page_Access_Time__c = null);
        }
        catch(Exception e){}
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
/* 
* Name      : FetchCapacity
* Purpose   : This class is used as an utility to fetch Capacity of claims by any plumber.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class FetchCapacity {
    public class PlumberInput {
        @InvocableVariable(required=true)
        public String plumberId;
    }
    public class PlumberOutput {
        @InvocableVariable(required=true)
        public String pCapacity;
    }
    @InvocableMethod(label='Get Capacity')
    public static List<PlumberOutput> getCapacity(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Account> accList = new List<Account>();
        PlumberOutput pOutput = new PlumberOutput();
        pOutput.pCapacity = '';
        accList = [SELECT Id,Total_Purchased_Capacity__c  FROM Account WHERE Id =:plumberInputs[0].plumberId];
        if(accList.size() > 0 && accList[0].Total_Purchased_Capacity__c != null)
            pOutput.pCapacity = accList[0].Total_Purchased_Capacity__c;
        else
            pOutput.pCapacity = '0L';
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
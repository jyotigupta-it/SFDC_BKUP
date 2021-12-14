/* 
* Name      : UpdatePlumberDetails
* Purpose   : This class is used as an utility to update Plumber Details.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class UpdatePlumberDetails {
	public class PlumberInput {
        @InvocableVariable
        public String plumberId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public String Status;
    }
    @InvocableMethod(label='Update Plumber Details')
    public static List<PlumberOutput> UpdatePlumberDetails(List<PlumberInput> plumberInputs){
    	List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Sales_scheme__c> schemeList = new List<Sales_scheme__c>();
        List<Plumber_Scheme_Relation__c> plumberSchemeJunkList = new List<Plumber_Scheme_Relation__c>();
        PlumberOutput pOutput = new PlumberOutput();
        String schemeName = 'Plumber Special – Silver Dhamaka';
        List<Plumber_Scheme_Relation__c> plumberSchemeJuncList = new List<Plumber_Scheme_Relation__c>();
        
        schemeList = [SELECT Id FROM Sales_scheme__c WHERE Name = 'Plumber Special – Silver Dhamaka'];
        plumberSchemeJuncList = [SELECT Id FROM Plumber_Scheme_Relation__c WHERE Plumber__c =:plumberInputs[0].plumberId AND Scheme__r.Name =:schemeName];
        if(plumberInputs.size() > 0){
            String plumberId = plumberInputs[0].plumberId;
            if(plumberId != null && plumberId != ''){
                Account accObj = new Account();
                accObj.Id = plumberId;
                accObj.Plumber_Registered_for_Schemes__c = true;
                UPDATE accObj;
                
                if(plumberSchemeJuncList.size() == 0){
                    plumberSchemeJunkList.add(new Plumber_Scheme_Relation__c(Plumber__c = accObj.Id,Scheme__c = schemeList[0].Id));
                    INSERT plumberSchemeJunkList;
                }
                pOutput.status = 'Success';
            }
            else
                pOutput.status = 'Error';
        }
        else
            pOutput.status = 'Error';
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
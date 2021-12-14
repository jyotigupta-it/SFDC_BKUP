/* 
* Name      : CheckSchemeRegistration
* Purpose   : This class is used as an utility to check is plumber is registered for the scheme.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class CheckSchemeRegistration {
public class PlumberInput {
        @InvocableVariable
        public String plumberId;
    }
    public class PlumberOutput {
        @InvocableVariable
        public Boolean status;
    }
    @InvocableMethod(label='Check Scheme Registration Status')
    public static List<PlumberOutput> getSchemeRegistrationStatus(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Plumber_Scheme_Relation__c> plumberSchemeJuncList = new List<Plumber_Scheme_Relation__c>();
        PlumberOutput pOutput = new PlumberOutput();
        String schemeName = 'Plumber Special – Silver Dhamaka';
        
        plumberSchemeJuncList = [SELECT Id FROM Plumber_Scheme_Relation__c WHERE Plumber__c =:plumberInputs[0].plumberId AND Scheme__r.Name =:schemeName];
        if(plumberSchemeJuncList.size() > 0)
            pOutput.status = true;
        else
            pOutput.status = false;
        
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}
public class OpportunitySearchController {

private ApexPages.StandardController controller {get; set;}
    // the actual account
    private Account a;
    public boolean display{get;set;}
    // the results from the search.
    public List<Influencer__c> searchResults {get;set;}

  public OpportunitySearchController(ApexPages.StandardController controller) {

        //initialize the stanrdard controller
        this.controller = controller;
        this.a = (Account)controller.getRecord();
        display = true;
        searchInflu();

    }
   public void searchInflu(){
    display = true;
    searchResults =[select id,Opportunity__r.Name, Opportunity__r.Approximate_Project_Value__c,Opportunity__r.Project_District__c,Opportunity__r.CreatedDate from Influencer__c where Account__r.Id=:a.id];
   
    if(searchResults.isEmpty()){
     display = false;
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'No results found')); 
    }
   }
}
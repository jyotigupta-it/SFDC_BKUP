/*******************************************************************
 * Custom controller for the "Custom Lookup" recipe. Executes a 
 * search based on a query string entered by a user. 
 *******************************************************************/
public with sharing class LookupController 
{
    // the query string entered by the user
    public String query {get; set;}
    
    // the matchin>g accounts
    public List<Account> accounts {get; set;}
    
    // has a search been executed?
    public Boolean doneLookup {get; set;}
    
    // constructor
    public LookupController()
    {
        doneLookup=false;
    }
    
    // executes the search
    public PageReference runQuery()
    {
        accounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,District__c, State__c, Status__c, Party_type__c FROM Account WHERE status__c ='Existing' AND Party_Type__c = 'Distributor' and name LIKE: query+'%' limit 999]);
           
        accounts.addAll(searchResults);
        doneLookup=true;
        return null;
    }
}
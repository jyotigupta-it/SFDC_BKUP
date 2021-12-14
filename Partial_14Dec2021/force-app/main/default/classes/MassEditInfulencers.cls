/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :29-Dec-2014
Modified Date   :
Version         :1.0
Description     :

********************XXX***********************************/
public class MassEditInfulencers {

    public String projectId {get;set;} 
    public List<Influencer__c> influencerList {get;set;}
    public String recordTypeId {get;set;}
    
    public MassEditInfulencers(){

        projectId = ApexPages.currentPage().getParameters().get('ProjectId');
        influencerList = new List<Influencer__c>();
        influencerList = [SELECT Id, Account__c,Account__r.Name ,Account__r.Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c,Inf_Order__c,Source__c FROM Influencer__c WHERE Opportunity__c = :projectId ORDER by Inf_Order__c];
        recordTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Individual Contacts'].id;
    }

    public void updateInfluencers(){

        try{
            
            update influencerList;
        }
        catch(exception e){

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));

        }
    }
    
    
    public PageReference cancel(){

        PageReference pf = new PageReference('/'+projectId);
        return pf;
    }
       // the query string entered by the user
    public String orderQuery {get; set;}
    // the matchin>g accounts
    public List<Account> orderAccounts {get; set;}
    
     // executes the search
    public void runOrderQuery()
    {   
        System.debug('coming inside');
        if(orderQuery != null) {
            orderQuery = orderQuery .trim();
        }
        
        String nameCond = '%'+orderQuery +'%';
        String cond = orderQuery +'%';
        orderAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name, Primary_Contact_Person_Name__c, Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, Status__c, Street_Address__c, Ramco_ID__c  FROM Account WHERE  (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR Contact_Number_Mobile__c LIKE :cond ) limit 999]);
        
        orderAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +orderAccounts);
        
    }
 
    
    }
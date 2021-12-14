/*
Created by : Deepak Singh
Created date : 1/08/2020
Description : Controller for dealer authentication page which is force.com site which published to take online orders
*/

public class DealerAuthenticationController {
    
    public Boolean require {get;private set;}
    public  string phone {get;set;}
    public List<SelectOption> accountSelectList{get;private set;}
    public Boolean showSelect {get;private set;}
    public  Boolean prospectPhoneNumberPresent {get;private set;}
    public Boolean showSignUp {get;private set;}
    public  Account acc {get;private set;}
    public  Boolean accountSelected {get;private set;}
    public  Boolean OneDealer{get;private set;}
    public boolean showSubmit{get;private set;}
    public boolean disablePhone{get;private set;}
    public Account distributor{get;private set;}
    
    
    public DealerAuthenticationController() {
        prospectPhoneNumberPresent = false;
        accountSelected = false;
        accountSelectList = new List<SelectOption>();
        showSelect = false;
        showSignUp = false;
        require = true;
        showSubmit = true;
        disablePhone = false;
        
        
        
    }
    public void reInitialize(){
        System.debug('executing re initialize');
        accountSelected = false;
        accountSelectList = new List<SelectOption>();
        showSelect = false;
        showSignUp = false;
        prospectPhoneNumberPresent = false;
        OneDealer = false;
        disablePhone = false;
        
    }
    public  void searchRetailerThroughPhone(){
        reInitialize();
            phone = String.escapeSingleQuotes(phone);
            try{
                //added Manual CRUD and FLS check
                
                acc = [SELECT Id,Name,ParentId FROM Account WHERE Contact_Number_Mobile__c=:phone AND (Order_portal_status__c = 'Dealer' Or Order_portal_status__c=Null) limit 1];
                if (!Schema.sObjectType.Account.fields.ParentId.isAccessible()){
          			System.debug(LoggingLevel.Error, 'You don\'t have access to the account parentId field');
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Insufficient access'));
        		}
                else
                {
                    if(acc != null){
                    	if(acc.ParentId != null){
                        	distributor = [select id, name from account where id = :acc.ParentId limit 1];
                    	}
                    
                    	showSelect = true;
                    	OneDealer = true;
                    	showSubmit = false;
                    	disablePhone = true;
                    	SelectedRetailer();
                	}
                }
            }
            catch(exception e){
                System.debug('Error at line:'+e.getLineNumber());
                System.debug('Error Message: '+e.getMessage());
                if(e.getMessage() == 'List has no rows for assignment to SObject'){
                    showSubmit = false;
                    showSignUp = true;
                }
            }
        }
    
    
    public Pagereference goToSignUpPage(){
        require = true;
        Pagereference px2 = page.DealerSignPage;
        px2.setRedirect(true);
        return px2;
    }
    public  PageReference SelectedRetailer(){//100
        Map<String,Order_portal_session_Id__c> sessionIdMap = Order_portal_session_Id__c.getAll();
        string sessionId;
        if(sessionIdMap.containsKey(acc.Id)){
			sessionId = String.valueOf(sessionIdMap.get(acc.id).session_id__c);
        }
        else{
            try{
            	Order_portal_session_Id__c cs = new Order_portal_session_Id__c();
            	cs.name = acc.Id;
            	cs.session_id__c = 100;
            	insert cs;
            	sessionId = '100';
            }
            catch(exception e){
                System.debug('Error at line:'+e.getLineNumber());
            	System.debug('Error Message: '+e.getMessage());
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Unable to insert Order Portal Session Id'));
                return null;
            }
        }
        require = true;
        Pagereference px2 = page.ShoppinCartPageTemp;
        String dealerId = acc.Id;
        px2.getParameters().put('dealer',ShoppingCartPageTempController.encryptData(dealerId));
        px2.getParameters().put('sessionId',sessionId);
        px2.setRedirect(true);
        return px2;
    }
}
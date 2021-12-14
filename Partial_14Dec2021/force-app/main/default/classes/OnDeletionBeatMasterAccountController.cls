public class OnDeletionBeatMasterAccountController {
    String recordId{get;set;}
    public String message{get;set;}
    
    public OnDeletionBeatMasterAccountController(ApexPages.StandardController standardController)
    {
        recordId=ApexPages.currentPage().getParameters().get('id');
    }
    public PageReference submitForApproval()
    {
        try
        {
            Date todays =System.today();
            System.debug('todays.day()'+todays.day());  
            if(todays.day() ==28 || todays.day() ==29 || todays.day() ==30 || todays.day() ==31|| todays.day() ==1|| todays.day() ==2 || todays.day() ==3 || todays.day() ==4 || todays.day() ==5){
                Beat_Master_Account__c tObj = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                System.debug('tObj'+tObj);
                update tObj;
                message='Submitted for Approval';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,message));
            }else{
                message='Beyond the Date';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,message));
                Beat_Master_Account__c tObj1 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                System.debug('tObj'+tObj1);
                Beat_Master_Account__c tObj2 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                System.debug('tObj'+tObj2);
                Beat_Master_Account__c tObj3 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj4 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj5 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj6 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj7 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj9 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj34 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                Beat_Master_Account__c tObj344 = new Beat_Master_Account__c(id=recordId,Status__c='Submitted');
                return null;
                
            }
        } 
        catch(Exception e)
        {
            System.debug('Exception At Line number '+ e.getLineNumber());
            System.debug('Exception :='+ e.getMessage());
        }
        return null;
    } 
}
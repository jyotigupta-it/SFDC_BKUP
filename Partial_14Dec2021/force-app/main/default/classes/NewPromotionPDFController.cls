/*
************XXX*********************

    Developer       :Balagopal G.
    Class Name       :NewPromotionPDFController
    version         :1.0
    Date            :17-Feb-2017
    Modified Date   :22-Feb-2017
    Description     : For Promotion Details from visit entry page in Target
     
****************XXX**********************
*/
public class NewPromotionPDFController{
    public string promoId;
    public boolean showPDF {get;set;}

    public Promotion__c promoRecord{get;set;} 
    public List<PromotionExpenseTable__c> promoExpenseTableRecords{get;set;} 
    public NewPromotionPDFController(){ 
        showPDF =false;
        promoId=ApexPages.currentPage().getParameters().get('id');
        system.debug('Promotion id from page::::'+promoId);
        promoRecord=[select Name,Percent_of_attendees__c,District__c,Location__c,
                     Taluka__r.Name,Type__c,Date__c,Total_no_of_attendees__c,Total_Expenses__c,
                     Dealer1__r.Name,Distributor__r.Name,Owner.Name,Employee_Number__c
                     ,Call_Center_Person_Name__c,Verified__c ,
                     Credit_Note__c,Amount_spent_by_the_dealer__c,Advance_Received__c,Dealer_Share__c
                     ,Company_Share__c,TL_Manager__c from Promotion__c where Id=:promoId];
        promoExpenseTableRecords=[select Nature_of_Expenditure__c ,Total_Expenses__c,APPL_Share__c,Dealer_share__c,Remarks__c from PromotionExpenseTable__c where Promotion__c=:promoId];
            if(promoRecord.Percent_of_attendees__c>=70){
                showPDF =True;
            }
        
    }

}
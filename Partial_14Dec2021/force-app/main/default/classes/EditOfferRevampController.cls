/*****************************************************************************************************************************************
*Created By:  Subhajit Ghosh
*Company:     KVP
*Created Date : 23.09.2019
*Description: This page is for edit of offers in the new project revamp structure. VF- EditOfferRevampSection
*Test:        EditOfferRevampControllerTest
***********************************************************************************************************************************/

public class EditOfferRevampController {
    
    public List<New_Special_Pricing_Request__c> newsprUpdateList{get;set;}
    public String uniqueSprId{get;set;}
    public String oppProId{get;set;}
    public EditOfferRevampController(){
        uniqueSprId=Apexpages.currentPage().getParameters().get('id');
        system.debug('uniqueSprId--'+uniqueSprId);
        oppProId=Apexpages.currentPage().getParameters().get('projectId');
        newsprUpdateList=new List<New_Special_Pricing_Request__c>();
        
        if(uniqueSprId!=NULL){
            newsprUpdateList=[SELECT ID,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                              MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,Unique_SPR__r.Unique_Name__c,
                              ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,Product_Status__c,Others_Lost_Sales__c,
                              Loss_to_brand__c,Reason_of_lost_sales__c,Reason__c,Offer_Probability__c,Tentative_Order_Date__c,Price_List_Date__c 
                              FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                              AND Unique_SPR__c=:uniqueSprId AND Product_Status__c != 'Loss']; 
            system.debug('newsprUpdateList---'+newsprUpdateList);
            system.debug('newsprUpdateList---'+newsprUpdateList.size());
        }
        
        
    }
    public PageReference saveUpdatedOffers() { 
        try{
            
            Integer orderLoss=0;
            Integer otherLossReason=0;
            integer orderWin=0;
            integer selectPrevDates=0;
            system.debug('newsprUpdateList----'+newsprUpdateList);
             for(New_Special_Pricing_Request__c newOff:newsprUpdateList){
            if(newOff.Product_Status__c=='Loss' && (newOff.Loss_to_brand__c==NULL || newOff.Reason_of_lost_sales__c==NULL)){
              ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Product Status is Loss then please fill the Lost to brand and Reason for lost sales');
            ApexPages.addMessage(theMessage);
            return null;   
            }
            if(newOff.Product_Status__c=='Loss' && newOff.Reason_of_lost_sales__c=='Others' && newOff.Others_Lost_Sales__c==NULL){
               ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Reason for lost sales is others then please fill the Others(Reason) field next to it');
            ApexPages.addMessage(theMessage);
            // new myException('Please fill the extra discount field in order to submit it for special pricing request for the selected products');
            return null;
            }
            if((newOff.Product_Status__c=='Win' || newOff.Product_Status__c==NULL) && (newOff.Loss_to_brand__c!=NULL || newOff.Reason_of_lost_sales__c!=NULL || newOff.Others_Lost_Sales__c!=NULL) ){
               ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Product status is Win/--None-- then Lost to brand,Reason Of Lost Sales, Others(Reason) must be empty');
            ApexPages.addMessage(theMessage);
            return null;
            }
            
             } 
            
            upsert newsprUpdateList;
            PageReference pf = new PageReference('/'+oppProId);
            return pf;
        }
        catch(Exception e){
            system.debug('in exception block');
            PageReference pf = new PageReference('/'+oppProId);
            return pf;
        }
        
        
    }
    public PageReference cancelEdit() { 
        try{
            
            PageReference pf = new PageReference('/'+oppProId);
            return pf;
        }
        catch(Exception e){
            system.debug('in exception block');
            PageReference pf = new PageReference('/'+oppProId);
            return pf;
        }
        
        
    }
    
}
/*****************************************************************************************************************************
 Created By     :Subhajit Ghosh
Created Date    :25-Sept-2019
Modified Date   :
Version         :1.0
Description     :Controller of EditSprByManager Page. This class is used for editing the records in the offer section by the manager and sys admin only.

****************************************************************************************************************************/
global class EditSprByManagerController {
    public List<New_Special_Pricing_Request__c> newsprUpdateList{get;set;}
    public String uniqueSprId{get;set;}
    public String oppProId{get;set;}
    public String UniqueSPRName{get;set;}
    public String ProductName{get;set;}//to get history
    public EditSprByManagerController(){
        uniqueSprId=Apexpages.currentPage().getParameters().get('id');
        oppProId=Apexpages.currentPage().getParameters().get('projectId');
        newsprUpdateList=new List<New_Special_Pricing_Request__c>();
        UniqueSPRName='';
        if(uniqueSprId!=NULL){
            newsprUpdateList=[SELECT ID,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                              MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,Unique_SPR__r.Unique_Name__c,
                              ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c 
                              FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                              AND Unique_SPR__c=:uniqueSprId AND (Approval_Status__c='Pending' OR Approval_Status__c='Approved')];
            UniqueSPRName=newsprUpdateList[0].Unique_SPR__r.Unique_Name__c;
        }
        
        
    }
    public PageReference saveUpdatedOffers() { 
        try{
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
    @RemoteAction
    global static  List<New_Special_Pricing_Request__c> getApprovalHistory(String nm,String proId){
        try{
            List<New_Special_Pricing_Request__c>  newsprHistoryList=new List<New_Special_Pricing_Request__c>();
        String ProductName=nm;
        String oppProId=proId;
        system.debug('called from javascript-----------------'+ProductName);
    system.debug('called from javascript-----------------'+oppProId);
        newsprHistoryList=[SELECT ID,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                              MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,Unique_SPR__r.Unique_Name__c,
                              ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,Approval_Status__c,Unique_SPR__r.Approver_Comments__c 
                              FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                              AND Project__c=:oppProId AND Product_name__c=:ProductName AND (Approval_Status__c='Approved' OR Approval_Status__c='Rejected') ORDER BY Approval_Rejection_Date__c  DESC LIMIT 5];
        
       
            system.debug('newsprHistoryList---'+newsprHistoryList);
            return newsprHistoryList;
             
    }
        catch(exception e){
            system.debug('exception occured'+e.getMessage());
             system.debug('exception occured'+e.getLineNumber());
            return null;
        }
        }
       
   
}
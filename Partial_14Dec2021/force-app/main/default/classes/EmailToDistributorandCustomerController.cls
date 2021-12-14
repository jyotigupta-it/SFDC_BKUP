/**************************************************************************************************************************
Created By      :Subhajit Ghosh, KVP Business Soln
Created Date    :1.10.2019
Modified Date   :
Description     : Whenever the email Customer/ Email To DP button is checked the email with this template is fired to the customer


***********************************************************************************************************************************/

public class EmailToDistributorandCustomerController {
    public String oppId{get;set;}
    public Integer count{get;set;}
    public String uniqueSprId{get;set;}
    public String uniqueSprName{get;set;}
    public String projectName{get;set;}
    public String DistributorName{get;set;}
    public String customerName{get;set;}
    public opportunity oppDetails{get;set;}
    public string OriginalApprover{get;set;}
    public String OwnerName{get;set;}
    public Unique_SPR__c uniqueSprRecord{get;set;}
    // public List<offerSectionParentWrapper> offSectionParentList{get;set;}
    public List<New_Special_Pricing_Request__c> approvedSprList{get;set;}
    public EmailToDistributorandCustomerController(){
      uniqueSprRecord=new Unique_SPR__c(); 
        approvedSprList=new list<New_Special_Pricing_Request__c>();
        oppId=ApexPages.currentPage().getParameters().get('projectId');
        system.debug('oppId--'+oppId);
        uniqueSprId=ApexPages.currentPage().getParameters().get('uniqueSPRId');
        system.debug('uniqueSprId--'+uniqueSprId);
        if(uniqueSprId != NULL && oppId != NULL){
            
            uniqueSprRecord=[SELECT id,Approved_Rejected_Date__c,Approved_Rejected_Date_WF__c,Approval_Status__c,Approval_date__c,Average_Discount_Provided__c,CreatedDate,L1_Approver__r.Name,L2_Approver__r.Name,Approver_Comments__c,Project__r.Owner.Name,Record_App_Rej_By__c FROM Unique_SPR__c where 
                            id=: uniqueSprId LIMIT 1];
            if(uniqueSprRecord.Average_Discount_Provided__c <= 7.5){
                OriginalApprover=uniqueSprRecord.L1_Approver__r.Name;
            }else{
                 OriginalApprover=uniqueSprRecord.L2_Approver__r.Name;
            }
            
            OwnerName=uniqueSprRecord.Project__r.Owner.Name;
            approvedSprList=[SELECT ID,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Extra_Discount__c,
                             MRP_Post_Discount2__c,MRP_Value__c,Net_Invoice_Value_from_APPL2__c,Price_List_Date__c,Offer_Probability__c,Additional_Disc_on_APPL_disc2__c,
                             ORC_MARGIN_TO_DLR_DIST__c,Reason__c,Project__c,Project_Value__c,Tentative_Order_Date__c,Validity_for_the_Price__c,Approval_Rejection_Date__c,Unique_SPR__r.Unique_Name__c 
                             FROM New_Special_Pricing_Request__c where Approval_Status__c=:'Approved' AND Unique_SPR__c=: uniqueSprId AND Project__c =: oppId];
            
            uniqueSprName=approvedSprList[0].Unique_SPR__r.Unique_Name__c ;
            
            
            oppDetails=[SELECT Id,Project_By__r.Name,Name,Freight__c,Project_Number__c,Average_Discount_Provided__c,Delivery__c,Price_Basis__c,No_of_Bathrooms__c,No_of_Floors__c,Delivery_Lots__c,Project_Type__c,CloseDate,Distributor__r.Name,Taxes__c,
                        Offer_Valid_Till__c,Project_Location__c,Number_of_towers__c,State_Auto_Populate__c,Project_By__c,Number_of_kitchens__c,Payment_Term__c,Delivery_Conditions_Gurantee__c,Order_Placement__c FROM Opportunity WHERE Id =:oppId LIMIT 1];
            
            RecordType Rt = [select Id from RecordType where Name ='Project Visit' and SobjectType = 'AP_Site_Visit__c'];
            List<AP_Site_Visit__c> l = [select id from AP_Site_Visit__c where Party_Name__c=:oppDetails.Project_By__c AND Project_Name__c=:oppId AND AP_Site_Visit__c.recordtypeId =: Rt.id ];
            count=l.size();
        }
    }
    

}
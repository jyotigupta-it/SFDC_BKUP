/******************************************************************************************************
 * Created By: Subhajit Ghosh
 * Created Date: 17.9.2019
 * Company: KVP Business Solutuons Pvt. Ltd.
 * Description: This trigger captures the latest approval comments and stores in the Unique SPR level.
                This is used to get approval history and comments on the basis on line items

**************************************************************************************************/

trigger UpdateApprovalCommentsTrigger on Unique_SPR__c (before update,after update) {
     if(trigger.isUpdate && trigger.isBefore){
        UpdateApprovalCommentController.updateApprovalComment(trigger.new);
      
    }
 
}
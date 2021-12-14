public with sharing class ProjectClass {
    Public Id AccountId;
    Public Account acc{get;set;}
    Public List<Order__c> orders{get;set;}
    

    public ProjectClass (ApexPages.StandardController controller) {
        
        AccountId=ApexPages.CurrentPage().getParameters().get('Id');
        acc=[SELECT id,Name From Account WHERE id=:AccountId];
        orders=[SELECT id,Name,Products__c,Order_Value__c,APPL_STD_Discount__c,Disc_to_Customer_on_MRP__c,Disc_to_Customer_on_MRP_Amount__c,
        ORC_Margin_to_Dlr_Dist__c,ORC_Margin_to_Dlr_Dist_Amount__c,Total_Disc_on_MRP_CTC__c,Final_Order_Value_after_Discount__c,Addl_disc_on_APPL_STD_Disc__c FROM Order__c WHERE Projects__c=:acc.id];
    }

}
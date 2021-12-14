public class EditOrderPage2Controller {
    Public List<Order_Line_Item__c> orderLineItemList{get;set;}
    public String ProjectId{get;set;}
    
    public EditOrderPage2Controller(){
        orderLineItemList=new List<Order_Line_Item__c>();
        ProjectId=ApexPages.currentPage().getParameters().get('id');
       orderLineItemList= [SELECT ID,Product_name__c, MRP_Post_Discount__c,Extra_Discount__c,Net_Invoice_Value_from_APPL2__c,ORC_Status__c,ORC_Markup__c,
                            Supply_End_Date__c,Competitors_name__c,ORC_MARGIN_TO_DLR_DIST__c,Payment_Terms__c,Project__c,APPL__c,Order_Status__c,Validity_for_the_Price__c,
                            Price_List_Date__c,Unique_Name_relation__c,Order_Value__c,Offer_Probability__c,MRP_Value__c,Tentative_Order_Date__c,Supply_Start_Date__c 
                             FROM Order_Line_Item__c WHERE Project__c=:ProjectId Order BY Product_name__c];
    }
    
    public PageReference onSave(){
        try{
            upsert orderLineItemList;
             PageReference pf = new PageReference('/'+ProjectId);
             return pf; 
            
        }
        catch(Exception e){
             PageReference pf = new PageReference('/'+ProjectId);
             return pf;
        }
    }
    
   public PageReference onCancel(){
        try{
             PageReference pf = new PageReference('/'+ProjectId);
             return pf; 
            
        }
        catch(Exception e){
             PageReference pf = new PageReference('/'+ProjectId);
             return pf;
        }
    }

}
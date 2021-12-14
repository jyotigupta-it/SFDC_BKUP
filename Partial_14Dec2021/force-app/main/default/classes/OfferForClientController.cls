/**************************************************************************************************************************
Created By      :Subhajit Ghosh
Created Date    :23-July-2019
Modified Date   :
Description     : generates the PDF for Offer for Client Button in the Project Detail Page 

***********************************************************************************************************************************/

public class OfferForClientController {
    public List<New_Special_Pricing_Request__c> offerList{set;get;}
    public List<New_Offer_Section__c> sprReviewList{set;get;}
    public Opportunity oppDetails{set;get;}
    public Decimal netInvoiceValueSum{set;get;}
    public String projectId{get;set;}
    public boolean emptyTCProject{set;get;}
    public List<Decimal> netInvoiceValueList;
    public List<Decimal> netMRPPostDisc2SumList;
    public Decimal mrpPostDiscSum{get;set;}
    public Decimal AverageDisc{get;set;}
    
    public OfferForClientController(){
        offerList=new List<New_Special_Pricing_Request__c>();
        sprReviewList=new List<New_Offer_Section__c>();
        emptyTCProject=false;
        netInvoiceValueSum=0;
        mrpPostDiscSum=0;
        AverageDisc=0;
        netInvoiceValueList=new List<Decimal>();
        netMRPPostDisc2SumList=new List<Decimal>();
        oppDetails=new Opportunity();
        projectId=ApexPages.currentPage().getParameters().get('id');
        system.debug('************projectId*********'+projectId);
        if(projectId != NULL){
            netInvoiceValueList.clear();
            oppDetails=[SELECT Id,Project_By__r.Name,Name,Freight__c,Delivery__c,Price_Basis__c,Delivery_Lots__c,Taxes__c,Offer_Valid_Till__c,Payment_Term__c,Delivery_Conditions_Gurantee__c,Order_Placement__c FROM Opportunity WHERE Id =:projectId];
            if(oppDetails.Freight__c == NULL || oppDetails.Delivery__c ==NULL || oppDetails.Price_Basis__c == NULL || oppDetails.Delivery_Lots__c == NULL || oppDetails.Taxes__c == NULL 
               || oppDetails.Offer_Valid_Till__c == NULL || oppDetails.Payment_Term__c == NULL || oppDetails.Delivery_Conditions_Gurantee__c == NULL || oppDetails.Order_Placement__c == NULL){
                   emptyTCProject=true;
               }
            
            offerList=[SELECT ID,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                       MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,
                       ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,
                       Price_List_Date__c,Offer_Probability__c,Tentative_Order_Date__c,Reason__c
                       FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                       AND Project__c=:projectId AND Approval_Status__c='Approved'];
            
            if(offerList.size()>0){
                for(New_Special_Pricing_Request__c nos:offerList){
                    if(nos.Net_Invoice_Value_from_APPL2__c != NULL ){
                        netInvoiceValueList.add(nos.Net_Invoice_Value_from_APPL2__c);
                    }
                    if(nos.Net_Invoice_Value_from_APPL2__c != NULL){
                        netInvoiceValueList.add(0);
                    }
                    if(nos.MRP_Post_Discount2__c != NULL ){
                        netMRPPostDisc2SumList.add(nos.MRP_Post_Discount2__c);
                    }
                    if(nos.MRP_Post_Discount2__c == NULL){
                        netMRPPostDisc2SumList.add(0); 
                    }
                }
            }
            if(netInvoiceValueList.size()>0){
                for(Decimal sum:netInvoiceValueList){
                    netInvoiceValueSum=netInvoiceValueSum+sum;             
                } 
            }
            if(netMRPPostDisc2SumList.size()>0){
                for(Decimal sum:netMRPPostDisc2SumList){
                    mrpPostDiscSum=mrpPostDiscSum+sum;             
                } 
            }
            if(mrpPostDiscSum != 0){
                decimal AverageDisc2= ((mrpPostDiscSum - netInvoiceValueSum)/ mrpPostDiscSum)*100;
                AverageDisc=AverageDisc2.setScale(2);
            }
            
            sprReviewList=[SELECT id,Product_Name__c,MRP_Value__c,APPL__c,Extra_Discount__c,CTC__c,Additional_Disc_on_APPL_disc__c,Net_Invoice_Value_from_APPL__c,ORC_MARGIN_TO_DLR_DIST__c,Competitors_name__c,MRP_Post_Discount__c,Delivery_Start_Date__c,Tentative_Order_Date__c,Discounted_Price__c,Approval_Status__c ,Validity_for_the_Price__c,Project__c FROM New_Offer_Section__c WHERE Project__c =: projectId];
        }
        String myGeneratedFileName = 'Offerfor'+oppDetails.Name;
        //Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+myGeneratedFilename);
        Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename='+myGeneratedFilename); 
        
        
    }
    
    
}
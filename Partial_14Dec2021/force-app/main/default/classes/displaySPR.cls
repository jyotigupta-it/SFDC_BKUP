// For SPR scrtions
public class displaySPR{

   /* public displaySPR(ApexPages.StandardController acon) {

    }
    */

public String oppId{get;set;}
public List<wrapOLI> sprOLD {get;set;}
public List<wrapOLI> sprNEW {get;set;}
 public String removeRowType {get;set;}
    public  displaySPR(){
    oppId  = ApexPages.CurrentPage().getParameters().get('id');
    List<OpportunityLineItem>allListSPR=new List<opportunityLineItem>();
    try{
    allListSPR=[SELECT Id,checked_if_Approved__c,OpportunityId,Competitor_name_offer__c,PricebookEntryId,product2.name,MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Distributor__c,Offer_MRP__c,APPL_Type__c,Offer_Check__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitor_name1__c,Product_Specified__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true ];
    opportunity oppobj=new opportunity();
        oppobj=[select id,Special_Pricing_Request_Approval__c from opportunity where id=:oppId limit 1];
        system.debug('All OLI List');  
     sprOLD = new List<wrapOLI>();
     sprNEW =new List<wrapOLI>();
   
    for(OpportunityLineItem op:allListSPR){
    wrapOLI temp=new wrapOLI();
       // if(oppobj.Special_Pricing_Request_Approval__c=='Approved'){
       if(op.checked_if_Approved__c==true){
        temp.oli=op;
        sprOLD.add(temp);
        }
        else{
        temp.oli=op;
        sprNEW.add(temp);
        }
    }
    }
    catch(exception e){
     system.debug('message'+e.getMessage());
    }
    system.debug('before'+sprOLD);
    system.debug('after'+sprNEW);
        if(sprNEW.size()==0){
          ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'There are no New SPR for Approval' );
          ApexPages.addmessage(msg);
        } 
        if(sprOLD.size()==0){
          ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'There are no previous SPR ' );
          ApexPages.addmessage(msg);
        }
        
    }
    
    // Remove Row
     public PageReference  removeRow() { 
     PageReference pageRef =new PageReference('/'+oppId);

       try {
            string x_count = string.valueOf(Apexpages.currentPage().getParameters().get('rowNum'));
            system.debug('id is '+x_count); 
            opportunityLineItem  del=new opportunityLineItem ();
            del=[select id from opportunityLineItem where id=:x_count limit 1];
            delete del;
            system.debug('message in try');
             ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'You have deleted SPR ' );
            ApexPages.addmessage(msg);
           del=new opportunityLineItem();
            return pageRef;
           }
           catch(exception e){
           system.debug('message'+e.getMessage());
           return pageRef ;
           }
     }
    public class wrapOLI{
    public OpportunityLineItem oli{get;set;}
    }   
    
}
/***********************************************************************************************
* Created By: Subhajit Ghosh
* Company: KVP
* Description: Used when the edit button is clicked for the editing the Indicative product fitment list. It is used to update the offers in the
              new offer section.
*Test  :     EditAllNewOfferTest
*******************************************************************************************/
public class EditAllNewOfferSection_Controller {
    public String oppProId{get;set;}
    
    
    
    // public List<WrapperNewOffer> wrapListOfferList{set;get;}
    public  List<New_Offer_Section__c> newOfferSectlist{set;get;}
    public Opportunity oppTC {get;set;}
    public List<Opportunity> oppTClist;
    public String pageTypeValue{get;set;}// to get the fromPage value from URL so that one the basis it would return to respective page
    
    public EditAllNewOfferSection_Controller(){
        //wrapListOfferList=new List<WrapperNewOffer>();
        newOfferSectlist=new List<New_Offer_Section__c>();
        oppTC=new Opportunity();
        oppProId = Apexpages.currentPage().getParameters().get('id'); 
        pageTypeValue=Apexpages.currentPage().getParameters().get('fromPage');
        oppTClist=new List<Opportunity>();
        system.debug('oppProId  @@@'+oppProId);
        if(oppProId != NULL){
            newOfferSectlist=[SELECT id,Product_Name__c,MRP_Value__c,Send_for_SPR__c,Net_Invoice_Value_from_APPL__c,Lost_to_brand__c,Reason_of_lost_sales__c,Others_Lost_Sales__c,APPL__c,Extra_Discount__c,ORC_MARGIN_TO_DLR_DIST__c,Tentative_Order_Date__c,Offer_Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,
                              Competitors_name__c,Distributor__c,MRP_Post_Discount__c,Product_Specified__c,Payment_terms__c,Delivery_Schedule__c,Product_Status__c ,Project_Value__c,Why_Additional_Discount__c,Validity_for_the_Price__c FROM New_Offer_Section__c WHERE Project__c =: oppProId AND Send_for_SPR__c != TRUE];
            
            oppTC = [SELECT Id,Freight__c,Delivery__c,Price_Basis__c,Delivery_Lots__c,Taxes__c,Offer_Valid_Till__c,Payment_Term__c,Delivery_Conditions_Gurantee__c,Order_Placement__c FROM Opportunity WHERE Id =:oppProId];  
        }
        
    }
    public PageReference saveUpdatedOffers() { 
        oppTClist.add(oppTC);
        Integer orderLoss=0;
        Integer otherLossReason=0;
        integer orderWin=0;
        integer selectPrevDates=0;
        integer projvalue=0;
        
        system.debug('oppProId PageReference-->>'+oppProId);
        for(New_Offer_Section__c newOff:newOfferSectlist){
            if(newOff.Product_Status__c=='Loss' && (newOff.Lost_to_brand__c==NULL || newOff.Reason_of_lost_sales__c==NULL)){
                orderLoss++;
            }
            if(newOff.Product_Status__c=='Loss' && newOff.Reason_of_lost_sales__c=='Others' && newOff.Others_Lost_Sales__c==NULL){
                otherLossReason++;
            }
            if((newOff.Product_Status__c=='Win' || newOff.Product_Status__c==NULL) && (newOff.Lost_to_brand__c!=NULL || newOff.Reason_of_lost_sales__c!=NULL || newOff.Others_Lost_Sales__c!=NULL) ){
                orderWin++;
            }
            
            if(newOff.Delivery_Start_Date__c < Date.today() || newOff.Validity_for_the_Price__c < date.today()){
                selectPrevDates++;
            }
            
            if(newOff.Project_Value__c ==NULL){
                projvalue++;
            }
            
        }
        if(orderLoss > 0){
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Product Status is Loss then please fill the Lost to brand and Reason for lost sales');
            ApexPages.addMessage(theMessage);
            return null;   
        }
        if(otherLossReason > 0){
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Reason for lost sales is others then please fill the Others(Reason) field next to it');
            ApexPages.addMessage(theMessage);
            // new myException('Please fill the extra discount field in order to submit it for special pricing request for the selected products');
            return null;
        }
        if(orderWin>0){
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If Product status is Win/--None-- then Lost to brand,Reason Of Lost Sales, Others(Reason) must be empty');
            ApexPages.addMessage(theMessage);
            return null;
        }
        if(selectPrevDates>0){
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Delivery Start Date and Validity of the Price dates cannot be less than today');
            ApexPages.addMessage(theMessage);
            return null;
        }
        if(projvalue>0){
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Project Value cannot be empty');
            ApexPages.addMessage(theMessage);
            return null;
        }   
        
        for(Opportunity opp:oppTClist){
            if(opp.Freight__c==NULL || opp.Delivery__c==NULL || opp.Price_Basis__c==NULL || opp.Delivery_Lots__c==NULL || opp.Payment_Term__c==NULL || opp.Taxes__c==NULL || opp.Offer_Valid_Till__c==NULL || opp.Delivery_Conditions_Gurantee__c==NULL || opp.Order_Placement__c==NULL){
                ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill all the fields in terms and conditions section');
                ApexPages.addMessage(theMessage);
                return null;
            }
        }
        try{
            system.debug('newOfferSectlist-->>'+newOfferSectlist);
            system.debug('newOfferSectlist-------@@@@@@@@@@@@@@@@@@@@@@'+newOfferSectlist.size());
            upsert newOfferSectlist;
            upsert oppTC;
            if(pageTypeValue.equalsIgnoreCase('SPRPage') ){
                //PageReference pf = new PageReference('/'+oppProId);
                PageReference pf=new PageReference('/apex/SPR_NewOffer?id='+oppProId+'&applType=offerType');
                return pf;
            }
            else{
                PageReference pf = new PageReference('/'+oppProId);
                return pf;
            }
            
            
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return null;
        }
        
    }
    public PageReference cancelEdit() { 
        try{
             if(pageTypeValue.equalsIgnoreCase('SPRPage') ){
                //PageReference pf = new PageReference('/'+oppProId);
                PageReference pf=new PageReference('/apex/SPR_NewOffer?id='+oppProId+'&applType=offerType');
                return pf;
            }
            else{
                PageReference pf = new PageReference('/'+oppProId);
                return pf;
            }
            
        }
        catch(Exception e){
            system.debug('exception occured while cancelling page---'+e);
             PageReference pf = new PageReference('/'+oppProId);
             return pf;
        }
        
        
    }
    
}
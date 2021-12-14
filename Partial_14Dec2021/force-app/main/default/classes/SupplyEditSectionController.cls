/*******************XXX**********************************

Created By      :Subhajit Ghosh
Created Date    :11-05-2019
Modified Date   :
Version         :1.0
Description     :Controller of SupplyEditSectionVF page, Edit the supply on click of edit button

test            :SupplyEditSectionTest
********************XXX***********************************/
public class SupplyEditSectionController {
    
     public String oppProId {get;set;}
    public String applType {get;set;}
   
   // public Opportunity oppTc {get; set;}
    public Opportunity opp;
   
   // public List<Order> parentOrderList;
    public List<SupplyLineItem__c> SupplyItemList;
    public List<Supply__c> parentSupplyRecord;
    public List<SupplyLineItem__c> supplyLineItemsList;
    public List<SupplyWrapperClass>SupplyItemWrapperList;
   // public Boolean saveOrder {get;set;}
    public Boolean saveSupply {get;set;}

    
    public String delID {get;set;}
 
    
     public SupplyEditSectionController(ApexPages.StandardController stdController) {
         SupplyItemWrapperList=new List<SupplyWrapperClass>();
         supplyLineItemsList=new List<SupplyLineItem__c>();
        SupplyItemList=new List<SupplyLineItem__c>();
         oppProId = Apexpages.currentPage().getParameters().get('id');   
        applType = Apexpages.currentPage().getParameters().get('applType'); 
         system.debug('oppProId--'+oppProId);
         system.debug('applType--'+applType);
     }
    
    public PageReference savePage() {   

        PageReference pf = new PageReference('/'+oppProId);
        try{
            
          if(applType == 'supplyType' && SupplyItemWrapperList.size() > 0) {
                List<SupplyLineItem__c> supplyLineItemList = new List<SupplyLineItem__c>();
                for(SupplyWrapperClass tempObject : SupplyItemWrapperList) {
                    SupplyLineItem__c supplyItemObject  = new SupplyLineItem__c();
                    supplyItemObject = tempObject.SupplyLineItemInstance;
                    supplyLineItemList.add(supplyItemObject);
                } 
               Update supplyLineItemList;
               return pf;
        }
        }
            catch(exception e){
                system.debug('eroror occured at line number----'+e.getLineNumber() );
                 return pf;
            }

        return pf;           
       
       
    }
    
      public list<SupplyWrapperClass> getSupplyListPro() {

        SupplyItemWrapperList = new List<SupplyWrapperClass>();
        supplyLineItemsList = new List<SupplyLineItem__c>([SELECT Id, Distributor_Name__c, Distributor_Name__r.name,OrderLineItem__c, Product_name__c, 
                                                           Product__r.Name, Quantity__c, Unit__c, Order_Value__c, Invoice_Date__c, Payment_Terms__c,
                                                           Supply_Status__c, ORC_Markup__c, ORC_Status__c,SupplyDetails__r.New_Order__r.Name 
                                                           from SupplyLineItem__c WHERE Project__c=:oppProId  ORDER BY SupplyDetails__r.New_Order__r.Name ASC]); //WHERE SupplyDetails__c = : parentSupplyRecord[0].Id
        
      system.debug('supplyLineItemsList--'+supplyLineItemsList);
          for (SupplyLineItem__c  tempSupplyItem : supplyLineItemsList) {

            SupplyWrapperClass supplyWrpObj = new SupplyWrapperClass();
            supplyWrpObj.SupplyLineItemInstance = tempSupplyItem;
            
            /*supplyWrpObj.SupplyLineItemInstance.Product__c = tempSupplyItem.Product__c;
            //supplyWrpObj.SupplyLineItemInstance.Quantity__c = tempSupplyItem.Quantity__c;
           // supplyWrpObj.SupplyLineItemInstance.Unit__c = tempSupplyItem.Unit__c;
            supplyWrpObj.SupplyLineItemInstance.Order_Value__c = tempSupplyItem.Order_Value__c;
            supplyWrpObj.SupplyLineItemInstance.Invoice_Date__c = tempSupplyItem.Invoice_Date__c;
            supplyWrpObj.SupplyLineItemInstance.Payment_Terms__c = tempSupplyItem.Payment_Terms__c;
            supplyWrpObj.SupplyLineItemInstance.Supply_Status__c = tempSupplyItem.Supply_Status__c;*/
            
            //supplyWrpObj.SupplyLineItemInstance.Supply_End_Date__c = tempOrderItem.EndDate;
            supplyWrpObj.productName = tempSupplyItem.Product_name__c;
            SupplyItemWrapperList.add(supplyWrpObj);
        }
        system.debug('supplyLineItemsList:: ' + supplyLineItemsList);
        return SupplyItemWrapperList;        
    }

    public class SupplyWrapperClass {    
        
        public SupplyLineItem__c SupplyLineItemInstance {get; set;} 
        public String productName {get; set;}
        
        public SupplyWrapperClass() {
            SupplyLineItemInstance = new SupplyLineItem__c();
            productName = '';
        }   
    }

   /* public void deleteRow() {

        String delId = Apexpages.currentPage().getParameters().get('delId');
        if(delId.length() != 0){

            OpportunityLineItem delOLI= [SELECT id from OpportunityLineItem where id=:delId];
            //system.debug('*******delId********'+delId);
            if(delOLI != null) {

               delete delOLI;
            }
            
        }
    }*/

    public void deleteData() {

        String emptyDataId = Apexpages.currentPage().getParameters().get('emptyDataId');
        //System.debug('@@@@@@@@@'+emptyDataId);
        //OpportunityLineItem delOLI;
        try{            
            
           if(applType == 'supplyType') {

                SupplyLineItem__c deleteRecord = new SupplyLineItem__c();
                deleteRecord.Id = emptyDataId;
                delete deleteRecord;
                /*delOLI.Supply_Quantity__c       = null;
                delOLI.Invoice_Value__c         = null;
                delOLI.Invoice_Date__c          = null;
                delOLI.Supply_Check__c          = false;*/
            
            }  
            
           /* else if if(applType == 'orderLost'){
                delOLI.Order_Loss_Check__c = false;
            }*/
           // update delOLI;
           
            
        }catch(Exception e) {
             system.debug('error at line number--'+e.getLineNumber() );
             system.debug('error at line number--'+e.getMessage() );
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));  
        }
     
    }

}
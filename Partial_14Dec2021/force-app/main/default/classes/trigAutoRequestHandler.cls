/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Vasanthi
Email: Vasanthi_KN@infosys.com
Description:  Handler class for trigAutoRequestHandler used to create the auto request for CSO
 ****************************************************************************************/
public class trigAutoRequestHandler{

    List<case> listOfopenCase = new List<case>();
    // public String value = null;
    public decimal stock = 0.0;
    integer check = 0;

    RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
    List<inventory_request__c> openCaseInventory = new List<inventory_request__c>();
    Decimal i =0;
    Boolean isdupes = false;
    List<user> userdetail = [select address, depo__c,depot_zone__c, Head_office__c from  User ];

    public void raiseAutoRequest(){
        try{
        listOfOpenCase = [select status, case.ownerid, caseNumber from case where status !='Completed' and case.recordtypeId =: Rt.id and origin ='User'];
        Set<Id> caseid = new Set<Id>();
        for(Case cases: listOfOpenCase ){
        caseid.add(cases.id);
        }
       
        openCaseInventory = [select type_of_item__c,name,type_of_item__r.Threshold__c, type_of_item__r.Dispatch_Size__c, Request_Rasied_by__c from inventory_request__c inr
                             where inr.Inventory_Request_Number__c in : caseid and (type_of_item__r.IsCSO_User__c = true or type_of_item__r.Is_Depo_User__c = true)]; 
        
        
        List<inventory__c> inventoryRecords=new List<inventory__c>();
        List<inventory_request__c> invRequest=new List<inventory_request__c>();
        Set<Id> userIds = new Set<Id>();
        for(sobject sampleData : trigger.new){
            inventory__c samples = (inventory__c)sampleData ;
            if(samples.IsCSO_User__c == true || samples.Is_Depo_User__c == true){
            inventoryRecords.add(samples);  
            userIds.add(samples.Owner_Account__c); }
        }  
        
     
        map<id, List<inventory_request__c>> invmap = new map<id, List< inventory_request__c>>();
        
        for(Id ids : userIds){
        List<inventory_request__c> invent = new List<inventory_request__c>();
        for (inventory__c sample : inventoryRecords) {
       
        isdupes = false;
           if(sample.Owner_Account__c == ids){
          
            stock = sample.Closing_Stocks__c;    
            if((sample.Threshold__c != null && sample.Threshold__c != 0) && (sample.Dispatch_Size__c != null && sample.Dispatch_Size__c !=0)){
            Decimal coll_threshold = sample.Threshold__c;
             
            if (stock <= coll_threshold){
                inventory_request__c inr = new inventory_request__c();

                inr.Request_Rasied_by__c = sample.Owner_Account__c;
                inr.Required_Quantity__c = sample.Dispatch_Size__c;
                if(sample.type__c == System.Label.GIFT_ITEMS && sample.type_of_meet__c =='Mega Meet'){
                    inr.inventory_mega__c = sample.Id;
                    
                }
                else if(sample.type__c == System.Label.GIFT_ITEMS && sample.type_of_meet__c =='Mini Meet'){
                    inr.inventory_mini__c = sample.Id;
                    
                }
                else if(sample.type__c == System.Label.PRODUCT_COLLATERALS){ inr.inventory_Product__c =sample.Id;}
                else if(sample.type__c == System.Label.SAMPLES){inr.inventory_Sample__c=sample.Id;}
                else if(sample.type__c == System.Label.PACKING_MATERIALS){inr.inventory_PackMaterials__c = sample.Id;}


                inr.Type_of_Item__c = sample.Id;
              
                inr.type_of_item__r = sample;
                if(openCaseInventory.size() != 0){
                    for(inventory_request__c checkdupe : openCaseInventory){
                        if(checkdupe.Type_of_Item__c.equals(inr.Type_of_Item__c) && 
                                checkdupe.Request_Rasied_by__c.equals(inr.Request_Rasied_by__c)){
                            isdupes = true;
                            
                            break;
                        }

                    }
                    if(!isdupes){
                           invent.add(inr);
                        }
                    }
                else{
                     invent.add(inr);
                       
                    }

                   
                }
                }
            }
            }
           if(invent.size() != 0){
            invmap.put(ids, invent);}
}

        List<case> collcase = new List<case>();
        for(Id userid : invmap.keySet()){
            Case collaterCase = new Case();
            collaterCase.Description='This is an auto request raised for the below collaterals. The automatic request will not be raised if the request is not approved once the stock is received.'; 
            collaterCase.recordtypeId= Rt.id;
            collaterCase.status = 'Auto Approved';
            collaterCase.Origin = 'User';
            collaterCase.Priority = 'Medium';

            collaterCase.Request_Raised_By__c = userId;
            collaterCase.ownerid= userId;

            for(User user : userDetail){

                Address addr = user.Address;

                if (user.id == userId){
                    if(addr != null){
                        collaterCase.Shipping_Address__c = addr.getStreet()+ ' ' + addr.getcity() + ' '  + addr.getstate()+ ' '
                        +  addr.getPostalCode() +' '+ addr.getcountry();
                    }
                    else
                        collaterCase.Shipping_Address__c ='';
                    
                    if(user.Head_Office__c == null){
                    collaterCase.Head_Office__c=userId;
                    }
                    else{
                  collaterCase.Head_Office__c=user.Head_Office__c;  
                  collaterCase.depot_zone__c = user.depot_zone__c;
                  }
                }

            }
           
            collaterCase.Subject ='Auto Request Raised';  
            collcase.add(collaterCase);
        }

        insert collcase;
       
        List<inventory_request__c> finalList = new List<inventory_request__c>();
         List<case> caseToUpdate= new List<case>();
        boolean giftcheck = false;
        boolean collcheck = false;
         boolean depoUser = false;
        for(case c : collcase){
        giftcheck = false;
        collcheck = false;
        depoUser = false;
            List<inventory_request__c> invList = new  List<inventory_request__c>();
            invList= invmap.get(c.Request_Raised_By__c);
            for(inventory_request__c inreq : invList){
                inreq.Inventory_Request_Number__c = c.id;
         
                if(inreq.type_of_item__r.type__c == System.Label.GIFT_ITEMS){
                giftcheck= true;
                }
                if(inreq.type_of_item__r.type__c == System.Label.PRODUCT_COLLATERALS){
                collcheck= true;
                }
               
                 if(inreq.type_of_item__r.Is_Depo_User__c == true){
                 depoUser = true;
                 }
                finalList.add(inreq);
               
            }
           if(giftcheck){
           c.Check_Gifts__c = true;}
           if(collcheck){
           c.collateral_check__c = true;
           }
           if(depoUser){
           c.Collateral_Flows__c='Depot';
           }
           else{
            c.Collateral_Flows__c='CSO';
           }
          
           caseToUpdate.add(c);

           

        }
        insert finalList;
        update caseToUpdate;
        
        List<caseShare> caseShareList = new List<caseShare>();
        for(Case cses : caseToUpdate){
        if(cses.Collateral_Flows__c=='Depot'){
        CaseShare caseShare=new CaseShare();
        caseShare.UserOrGroupID = cses.head_office__c;
        caseShare.CaseAccessLevel= 'Edit';
        caseShare.CaseId= cses.Id;
        caseShare.RowCause = 'Manual';
        caseShareList.add(CaseShare); 
        
        }
        
        }
        if(caseShareList.size()!=0 && caseShareList !=null){
        upsert caseShareList;
        }
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        for(case c : collcase){
            app.setObjectId(c.id);
            app.setComments('The request auto submitted for CSO approval...'); 

            Approval.ProcessResult result = Approval.process(app);
        }
        }
         catch(Exception e){
        system.debug(e.getMessage());
          }
    }


}
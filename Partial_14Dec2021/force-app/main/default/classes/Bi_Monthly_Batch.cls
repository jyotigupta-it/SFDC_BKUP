/*  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * File Name  : Bi_Monthly_Batch
 * Description: Batch Apex for syncing values of opening and closing stock for object 'inventory'.
 * Author     : Renjay Surendran
 * Modification Log 
 * ===================================================================== 
 * Ver   Date        Author                         Modification 
 * ---------------------------------------------------------------------
 * 1.0   10-Sept-2015   Renjay Surendran            Initial Code 
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/ 
global class Bi_Monthly_Batch implements Database.Batchable<sObject>{

    //Id n='00530000003m5lD';
    //List<String> qu=new List<String> {'PRODUCT COLLATERALS','SAMPLES'};
    global String query ='select firstname,Address,depo__c,depo__r.depot_zone__c, team_lead__c, head_office__c, lastname, id from user where isactive=true';

    global  database.QueryLocator start(Database.BatchableContext BC)
    {
        // Initiate the Batch context
       return Database.getQueryLocator(query);
       //return null;      
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
       execbatch((list<user>) scope);
    }
    
    public void execbatch(list<user> userInfo1)
    {   system.debug('####'+userInfo1.size());
        set<id> userId = new set<id>();
        List<Case> caseList = new List<Case>();
        List<Inventory_Request__c> batchInv = new List<Inventory_Request__c>();
        Map<id,List<inventory__c>> invMap = new Map<id,List<inventory__c>>();
        
        List<String> qu=new List<String> {'PRODUCT COLLATERALS','SAMPLES'};
        list<inventory__c> inventList=[select ID, Name, IsCSO_User__c, Is_Depo_User__c, Color_Language_Size__c, Item_Code__c, Product__c, Product_Description__c, Type__c, Owner_Account__c from inventory__c where Is_Depo_User__c<>true AND IsCSO_User__c<>true AND Type__c IN: qu]; //AND Owner_Account__c=:n';

        
        RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
        
        List<Bi_Monthly_Batch__c> batchList= [select name, Product__c, Product_Discription__c, Item_Code__c, Color_Language_Size__c, Category__c, Batch_Size__c from Bi_Monthly_Batch__c];
           
        for(inventory__c val : inventList)
        {
            userId.add(val.Owner_Account__c); 
        }  
        for(id i:userId)
        {
            List<inventory__c> inv= new List<inventory__c>();
            for(inventory__c val : inventList)
            {
                if(val.Owner_Account__c==i)
                {
                    inv.add(val);
                }
            }
            invMap.put(i,inv);
        }
        
        //system.debug('userId::'+ userId);
      //  List<user> userInfo=[select firstname,Address,depo__c, team_lead__c, head_office__c, lastname, id from user where id =: userId and isactive=true];
         List<user> userInfo = new List<user>();
        for(User users : userInfo1){
            for(Id setUser : userId){
            
            if(users.id == setUser){
            userInfo.add(users);
            break;
            }
            }
        
        }
        
        system.debug('userInfo:::'+userInfo.size());
        for(user i: userInfo)
        {
            Case cases = new Case();
            cases.subject = 'Bi-Monthly Batch Lot for User' +  i.firstname + ' ' + i.lastname;
            cases.ownerid =  i.id;
            cases.Request_Raised_By__c = i.id;
            cases.recordtypeId= Rt.id;
            cases.status = 'Auto Approved for Bi-Monthly Batch';
            cases.Origin = 'User';
            cases.Priority = 'Medium';
            cases.collateral_flows__c = 'BiMonthlyRequest';
            cases.description = 'Batch Lot to be dispatched for the user ' +  i.firstname + ' ' + i.lastname;
            Address addr = i.Address;
            if(addr != null){
            cases.Shipping_Address__c =addr.getStreet()+ ' ' + addr.getcity() + ' '  + addr.getstate()+ ' '
            +  addr.getPostalCode() +' '+ addr.getcountry();
            }
            else
            {
            cases.Shipping_Address__c ='';
            }
            cases.Depo__c=i.depo__c;
            cases.Head_Office__c=i.Head_office__c;
            cases.team_lead__c = i.team_lead__c;
            if(i.depo__c !=null){
            cases.depot_zone__c =i.depo__r.depot_zone__c;}
            caseList.add(cases);
           
            }
            
           insert caseList; 
           
           system.debug('caseList::::'+caseList.size());
            
            for(Case cases : caseList){
                 system.debug('how many times??');       
            for(inventory__c val: invMap.get(cases.ownerid))
            {              
               for(Bi_Monthly_Batch__c b: batchList)
                {               
                    if(val.Type__c==b.Category__c && val.Product__c==b.Product__c && val.Product_Description__c==b.Product_Discription__c && val.Color_Language_Size__c==b.Color_Language_Size__c && val.Item_Code__c==b.Item_Code__c)
                    {
                        Inventory_Request__c invReq = new Inventory_Request__c();
                        invReq.Inventory_Request_Number__c = cases.id;
                        invReq.Comments_Remarks__c = 'Batch Request';
                        invReq.Request_Rasied_by__c = cases.ownerid;
                        invReq.Required_Quantity__c = b.Batch_Size__c;
                        invReq.Type_of_Item__c = val.id;
                        
                        if(val.Type__c=='PRODUCT COLLATERALS')
                        {
                            invReq.inventory_Product__c = val.id;
                             batchInv.add(invReq);
                        }
                        else{
                           invReq.inventory_Sample__c = val.id;
                            batchInv.add(invReq); }
                        
                        //batchInv.add(invReq);
                    }
                }
                }
            } 
       
        system.debug('batchInv.size()::'+batchInv.size());
        insert batchInv;
        
        
         List<caseShare> caseShareList = new List<caseShare>();
         
         for(Case currentCase : caseList){
            if(currentCase.Team_Lead__c != null){
               CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.Team_Lead__c;
               caseShare.CaseAccessLevel= 'Read';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare);      
            }
           if(currentCase.depo__c !=null){
            CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.depo__c;
               caseShare.CaseAccessLevel= 'Edit';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare); 
           }
           if(currentCase.head_office__c !=null){
            CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.head_office__c;
               caseShare.CaseAccessLevel= 'Edit';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare); 
           }
           }
          if(caseShareList.size()!=0 && caseShareList !=null){
           insert caseShareList;}
           
           system.debug('!!!!'+caseList);
        system.debug('@@@@'+batchInv);
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        for(case c : caseList){
            app.setObjectId(c.id);
            app.setComments('BatchLot..'); 

            Approval.ProcessResult result = Approval.process(app);
        }
                  
    }   
    global void finish(Database.BatchableContext BC)
    {
       
    }     
    
}
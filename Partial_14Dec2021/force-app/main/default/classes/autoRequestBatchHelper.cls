public class autoRequestBatchHelper{

    RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];

    public String getCurrentMonth(){
        String month;

        Date currentDate = Date.today();

        if(currentDate.month() == 1){
            month = 'January'  + ' '+ '-' + ' ' +  currentDate.year();
        }
        else if(currentDate.month() == 2){
            month = 'February' + ' '+ '-' + ' ' +  currentDate.year();
        }
        else if(currentDate.month() == 3){
            month = 'March'  + ' '+ '-' + ' ' +  currentDate.year();
        }
        else if(currentDate.month() == 4){
            month = 'April'  + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 5){
            month = 'May' + ' '+ '-' + ' ' +  currentDate.year();
        }
        else if(currentDate.month() == 6){
            month = 'June' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 7){
            month = 'July' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 8){
            month = 'August' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 9){
            month = 'September' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 10){
            month = 'October' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() ==11){
            month = 'November' + ' '+ '-' + ' ' + currentDate.year();
        }
        else if(currentDate.month() == 12){
            month = 'December' + ' '+ '-' + ' ' + currentDate.year();
        }
   
        return month;
       

    }

    public void executeAutoRequestForMeet(List<Target__c> targets){
        
       String currentMonth=getCurrentMonth();
        List<Inventory__C> userInventories = new List<Inventory__C>();
        List<AP_Tour_Plan__c> bdmTourPlan = new List<AP_Tour_Plan__c>();
        Map<Id, Map<String,Decimal>> inventoryThresholdMap = new Map<Id, Map<String,Decimal>>();
        List<User> userInfo = new List<User>();
        List<Id> targetId = new List<Id>();
        Set<Id> bdmList = new Set<Id>();
        for(Target__c tar : targets){
            targetId.add(tar.id);
            bdmList.add(tar.ownerId);
            
        }
        system.debug('bdmList:::' + bdmList);
        userInventories = [select product__C,type_of_meet__c, name, Type__c,Product_Description__c, Color_Language_Size__c, opening_stock__c, Used_Stock__c,Received_Stock__c, Closing_Stocks__c, Owner_Account__c  from inventory__c
                           where Owner_Account__c in : bdmList and type__c ='GIFT ITEMS'];

        userInfo  = [select firstname,Address,depo__c,depo__r.depot_zone__c, team_lead__c, head_office__c, lastname,Mega_Meet_Threshold__c, Mini_Meet_Threshold__c, id from user where id =: bdmList and Gifts_Required_For_Meet__c = true and isactive=true];
        
        Map<id, List<Inventory_Gift_Request__c>> inrGiftMap = new map<id, List<Inventory_Gift_Request__c>>();
        
        List<Case> caseList = new List<Case>();
        
        inventoryThresholdMap = getGiftInventoryCount(userInfo, userInventories);
        system.debug('inventoryThresholdMap:::'+inventoryThresholdMap);
        system.debug('userInfo:::' + userInfo);
        for(User userdata : userInfo){
         Map<String, Decimal>  invThresholdData = new Map<String, Decimal>();
            Decimal megaMultiplier=0.0;
            Decimal miniMultiplier=0.0;
      
           
            for(Target__c tar : targets){
            if(tar.ownerid == userdata.id){
            Decimal MegaMeetColumn =0.0;
             Decimal MegaMeetPlumbing =0.0;
              Decimal MegaMeetProjects =0.0;
             Decimal MiniMeetColumn =0.0;
             Decimal MiniMeetPlumbing =0.0;
              Decimal MiniMeetProjects =0.0; 
             system.debug('MegaMultiplier::'+ tar.Mega_Meets_Column__c);
             system.debug('miniMultiplier:::' + tar.Mini_Meets_Column__c);
            if(tar.Mega_Meets_Column__c != null){ MegaMeetColumn = tar.Mega_Meets_Column__c; }
            if(tar.Mega_Meets_Plumbing__c != null){ MegaMeetPlumbing  = tar.Mega_Meets_Plumbing__c;}
            if(tar.Mega_Meets_Project__c != null){ MegaMeetProjects  = tar.Mega_Meets_Project__c ;}
            if(tar.Mini_Meets_Column__c != null) {MiniMeetColumn  = tar.Mini_Meets_Column__c;}
            if(tar.Mini_Meets_Plumbing__c !=null) { MiniMeetPlumbing  = tar.Mini_Meets_Plumbing__c ;}
            if(tar.Mini_Meets_Project__c != null) {MiniMeetProjects  = tar.Mini_Meets_Project__c ;}
            MegaMultiplier = MegaMeetColumn  + MegaMeetPlumbing  + MegaMeetProjects ;
            miniMultiplier = MiniMeetColumn  + MiniMeetPlumbing + MiniMeetProjects;
            }
           }
           
            invThresholdData=inventoryThresholdMap.get(userdata.id);
            
            if(invThresholdData != null && invThresholdData.size()!=0){
            system.debug('invThresholdData:::'+invThresholdData.keyset());
           
           
           List<Inventory_Gift_Request__c> inrGiftList = new List<Inventory_Gift_Request__c>();
                
            for(String meet: invThresholdData.keyset()){
               Inventory_Gift_Request__c inrGift = new Inventory_Gift_Request__c();
                if(meet == 'Mega Meet'){
                    if(megaMultiplier!=0){
                    if(invThresholdData.get(meet) <= (userdata.Mega_Meet_Threshold__c * megaMultiplier)){

                        inrGift.Request_Raised_by__c = userdata.id;
                        inrGift.Required_Quantity__c = (userdata.Mega_Meet_Threshold__c * megaMultiplier) - invThresholdData.get(meet);
                        inrGift.Type_Of_Meet__c ='Mega Meet';
                        inrGift.comments__c='Need the requested Quantity of gifts for Mega Meet';
                        inrGiftList.add(inrGift);
                        }
                    }
                }
                else if(meet == 'Mini Meet'){
                    if(miniMultiplier !=0){
                   
                    if(invThresholdData.get(meet) <= (userdata.Mini_Meet_Threshold__c* miniMultiplier )){

                        inrGift.Request_Raised_by__c = userdata.id;
                        inrGift.Required_Quantity__c = (userdata.Mini_Meet_Threshold__c * miniMultiplier ) - invThresholdData.get(meet);
                        inrGift.Type_Of_Meet__c ='Mini Meet';
                        inrGift.comments__c='Need the requested Quantity of gifts for Mini Meet';
                        inrGiftList.add(inrGift);
                        
                     }
                    }
                }
               
                
            }
            if(inrGiftList.size() != 0 && inrGiftList !=null){
                inrGiftMap.put(userdata.id,inrGiftList);             
                system.debug('inrGiftList::' + inrGiftList);
               
            }
         List<Inventory_gift_request__c> invList1= inrGiftMap.get(userdata.id);
            if(invList1 != null && invList1.size() !=0){
            Case cases = new Case();

                cases.subject = 'Supply of Mega and Mini Meet gifts for the BDM ' +  userdata.firstname + ' ' + userdata.lastname;
                cases.ownerid =  userdata.id;
                cases.Request_Raised_By__c = userdata.id;
                cases.recordtypeId= Rt.id;
                cases.status = 'Auto Approved for Mini-Mega Meet';
                cases.Origin = 'User';
                cases.Priority = 'Medium';
                cases.Check_Gifts__c = true;
                cases.collateral_flows__c = 'Requestor';
                cases.description = 'The user ' +  userdata.firstname + ' ' + userdata.lastname +' has '+ megaMultiplier + ' Mega Meet and ' + miniMultiplier + ' Mini Meet for the Month '+ currentMonth +'. As the user is falling short of the gifts, an auto request is raised to dispatch the required quantity for the meets';
                Address addr = userdata.Address;
                if(addr != null){
                    cases.Shipping_Address__c =addr.getStreet()+ ' ' + addr.getcity() + ' '  + addr.getstate()+ ' '
                    +  addr.getPostalCode() +' '+ addr.getcountry();
                }
                else{
                    cases.Shipping_Address__c ='';}
                cases.Depo__c=userdata.depo__c;
                cases.Head_Office__c=userdata.Head_office__c;
                cases.team_lead__c = userData.team_lead__c;
                cases.depot_zone__c=userdata.depo__r.depot_zone__c;
                caseList.add(cases);
        }
        }
        }
        system.debug('caseList::'+caseList.size());
        insert caseList;
        
        List<Inventory_Gift_Request__c> finalList = new List<Inventory_Gift_Request__c>();
        for(case c : caseList){
            List<Inventory_gift_request__c> invList= inrGiftMap.get(c.Request_Raised_By__c);
            system.debug('invList:::'+invList);
            for(Inventory_Gift_Request__c inreq : invList){
                inreq.Case__c = c.id;
                finalList.add(inreq);
            }

        }
       system.debug('finalList::'+finalList.size());
       
        
        insert finalList;

        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        for(case c : caseList){
            app.setObjectId(c.id);
            app.setComments('Auto Approved..'); 

            Approval.ProcessResult result = Approval.process(app);
        }
        
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

    }


    public Map<Id, Map<String,Decimal>> getGiftInventoryCount(List<User> userInfo, List<Inventory__C> giftList){
        Map<Id, Map<String,Decimal>> returnMap = new Map<Id, Map<String,Decimal>>();
        List<Inventory__C> miniMeetList= new List<Inventory__C>();
        List<Inventory__C> megaMeetList= new List<Inventory__C>();
        Map<String, Decimal> maptoAdd = new Map<String, Decimal>();
        for(Inventory__c inv : giftList){

            if(inv.type_of_meet__c =='Mega Meet'){
                megaMeetList.add(inv);
            }
            else if (inv.type_of_meet__c =='Mini Meet'){
                miniMeetList.add(inv);
            }
        }


        for(User user : userInfo){
            maptoAdd.clear();
            Decimal megaCount = 0.0;
            Decimal miniCount =0.0;
            boolean checkMega=false;
            boolean checkMini=false;
            for(Inventory__c inv : megaMeetList){
                if(inv.Owner_Account__c == user.id){
                checkMega=true;
                    megaCount = megaCount + inv.Closing_Stocks__c;
                }  
            }
            if(checkMega){
            maptoAdd.put('Mega Meet', megaCount );
            }
            for(Inventory__c inv : miniMeetList){
                if(inv.Owner_Account__c == user.id){ 
                checkMini=true;
                    miniCount = miniCount + inv.Closing_Stocks__c;    
                }   
            }
            
                              
            if(checkMini){
            maptoAdd.put('Mini Meet', miniCount);
            
            }
            
            if(maptoAdd.size()!=0){
            
            returnMap.put(user.id, maptoAdd);
            }
         system.debug('maptoAdd:::'+maptoAdd);   
          
        }
        system.debug('returnMap:::'+ returnMap);
        return returnMap;

    }

}
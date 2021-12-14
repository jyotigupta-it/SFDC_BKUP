/*******************XXX**********************************
Created By      :Mohd.Numaan Ahmed
Created Date    :22-Jan-2015
Modified Date   :
Version         :2.0
Description     :Controller of ProjectDetailPageOverride page
Modified By     :Subhajit Ghosh,Surya Priya.S
Test            :ProjDetailOverrideControllerTest
********************XXX***********************************/
public with sharing virtual class ProjDetailOverride_Controller {
    
    public boolean check{get;set;}
    public String oppId{get;set;}
    public String DistributorName;
    public String CustomerName;
    public List<Influencer__c> influList;
    public List<Project_Tracker__c> projectTrackList;
    public List<New_Offer_Section__c> orderLossList;
    map<id,string> lastactormap= new map<id,string>();
    // public List<OrderItemWrapperClass> ordItmWrpList;
    public List<Order> parentOrderList;
    public List<Supply__C> parentSupplyList;
    public List<orderLossProducts> newOrderLossList{get;set;}
    //public List<NewOfferSectionWrapper> NewOfferSectionWrapperList{get;set;}
    public boolean flag{get;set;}
    public boolean spr{get;set;}
    public String newListofusers='';
    public boolean newus=true;
    public boolean emailalert{get;set;}
    public boolean delflag{get;set;}
    public Order ordid{get;set;}
    public Decimal totalOrderValue {get;set;}
    public Decimal totalOrderQuantity {get;set;}
    public Decimal totalSupplyValue {get;set;}
    public Decimal totalSupplyQuantity {get;set;}
    public integer percnt;
    public string username;
    // public List<SprCheckWrapper> sprWrapList {get;set;} 
    public List<New_Special_Pricing_Request__c> displayNewSprList{get;set;}
    public  List<New_Offer_Section__c> newOfferSectlist{set;get;}
    public boolean editButtonDisabled{set;get;}
    public String DistributorId;//to get the distributor Id from project level and populate in the order/supply
    public String projectById;//to get the ProjectBy Id from project level and populate in the order/supply
    public List<SpecialPriceRequestWrapper> sprWrapperList{get;set;}
    public String unsprId{get;set;} // to get the unique spr id on click of approve or reject button
    public Id currentUserLoginId;//current logged in user id for button disable 
    public Map<Id,Integer> approverIdMap{get;set;}// gets the target object id and its actorId . Basis of this the approve reject button is displayed
    public List<Id> targetObjectIdList;
    public List<offerSectionParentWrapper> offSectionParentList{get;set;}
    public String uniqueSprOfferId{get;set;}// it gets the value unique spr on clcik of the chekbox 
    public Map<Id,Integer> mapOfferSelected{get;set;}//to get the value if checcked and unchecked
    public List<String> uniqueSprOfferIdList{get;set;}
    public List<generateOrderWrapper> orderList1{get;set;}
    public String distributorEmail;// contains the email id of the distributor
    //public list<string> Distributormailforuniquespr;
    public String customerEmail;// contains the email id of the customer
    public String projectName;// name of the project
    public string Projectowneremail;
    public boolean IsPlumbing;
    public Id projectOwnerId;
    public List<String> newsprList3{get;set;}
    public opportunity oppRecord{get;set;}
    list<opportunity> opplist= new list<opportunity>();
    public ProjDetailOverride_Controller(){
        
    }
    
    public ProjDetailOverride_Controller(ApexPages.StandardController controller) {
        oppRecord = (Opportunity)controller.getRecord();
        system.debug('lmop---'+oppRecord);
        newsprList3 = new List<String>();
        //system.debug('sprCheckWrapperList-->>>'+sprCheckWrapperList);
        
        offSectionParentList=new List<offerSectionParentWrapper>();
        newOfferSectlist=new List<New_Offer_Section__c>();
        uniqueSprOfferIdList=new List<String>();
        //sprWrapList = new List<SprCheckWrapper>();
        sprWrapperList=new List<SpecialPriceRequestWrapper>();
        targetObjectIdList=new List<Id>();
        approverIdMap=new Map<ID,Integer>();
        
        mapOfferSelected = new Map<Id,Integer>();
        orderList1=new list<generateOrderWrapper>();
        // newOfferSectList=new List<New_Offer_Section__c>();
        flag=false;
        spr=false;
        currentUserLoginId=UserInfo.getUserId();
        Profile pro = [select id,name from profile  where name ='System Administrator' LIMIT 1];// also used for enabling the approve button for admin
        if(pro.Id == userinfo.getprofileid()){
            delflag=false;
            
        }else{
            
            delflag=true;
            
        }
        /**************************/
        emailalert=false;
        
        boolean probFlag;
        // Integer st=Integer.valueof(opp1.Probability_New__c);
        
        
        String chk = ApexPages.CurrentPage().getParameters().get('check');
        
        if(chk=='true' ){
            check=true;
        }else{
            check=false;
        }
        System.debug('check is '+check);
        /**************************/
        oppId               = ApexPages.CurrentPage().getParameters().get('id');
        influList           = new List<Influencer__c>();
        projectTrackList    = new List<Project_Tracker__c>();
        ordid               = new Order();
        System.debug('oppId is ***** ' + oppId);
        //Renjay 
        
        Opportunity opp=[select Name,Probability__c,Project_By__c,Probability_New__c,Distributor__c,Distributor__r.Email_Id__c,Project_By__r.Email_Id__c,
                         Distributor__r.Name,Project_By__r.Name,owner.name,Owner.Email,Owner.updateIsPlumbing__c,ownerId  from Opportunity where Id =: oppId limit 1];
        //system.debug(opp.Distributor__r.Email_Id__c);
        distributorEmail=opp.Distributor__r.Email_Id__c;
        customerEmail=opp.Project_By__r.Email_Id__c;
        DistributorId=opp.Distributor__c;
        projectById=opp.Project_By__c;
        projectName=opp.Name;
        Projectowneremail=opp.owner.Email;
        IsPlumbing=opp.Owner.updateIsPlumbing__c;
        projectOwnerId = opp.ownerId;
        DistributorName=opp.Distributor__r.Name;
        CustomerName=opp.Project_By__r.Name;
        system.debug(opp.Probability_New__c);
        if(opp.Probability_New__c!=null){
            string s=''+opp.Probability_New__c;
            
            List<string> st=s.split('%');
            percnt=integer.valueof(st[0]);
            
            
            if(opp.Probability__c<101)
            {
                flag=true;
            }
        }
        
        /* if(percnt<80){
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Need probability more than 80% to submit'));

}*/
        
        
        system.debug(opp.Probability_New__c);
        
        
        List<OpportunityLineItem> oli = [select OpportunityId, Special_Pricing_Request_Check__c  from OpportunityLineItem where OpportunityId=: oppId AND Special_Pricing_Request_Check__c = TRUE Limit 1];
        if(!oli.isEmpty() && percnt<80 ){
            spr = true;
        } 
        
        totalOrderValue = 0;
        totalOrderQuantity = 0;
        totalSupplyValue = 0;
        totalSupplyQuantity = 0;
        
        parentOrderList = new List<Order>([SELECT OpportunityId, (SELECT Id, OrderId, Distributor_Name__c, ORC_Markup__c,
                                                                  ORC_Status__c, Order_Status__c, Order_Value__c, Payment_Terms__c, Unit__c, Validity_for_Price__c, 
                                                                  PriceBookEntryId, PriceBookEntry.Product2.Name, Quantity, ServiceDate, EndDate FROM OrderItems) from Order where OpportunityId =: oppId LIMIT 1]);        
        
        if(parentOrderList.size()> 0) {
            for(OrderItem tempOrderItem : parentOrderList[0].OrderItems) {
                totalOrderValue += tempOrderItem.Order_Value__c != null ? tempOrderItem.Order_Value__c : 0;
                totalOrderQuantity += tempOrderItem.Quantity != null ? tempOrderItem.Quantity : 0;
            }        
        }
        
        parentSupplyList = new List<Supply__c>([SELECT Id, (SELECT  Product__c, Quantity__c, Unit__c, Order_Value__c, Invoice_Date__c, Payment_Terms__c, Supply_Status__c, Distributor_Name__c, 
                                                            ORC_Markup__c, ORC_Status__c FROM SupplyLineItems__r) FROM Supply__C WHERE Project__c = : oppId LIMIT 1]);
        
        if(parentSupplyList.size()> 0) {
            for(SupplyLineItem__c tempSupplyItem : parentSupplyList[0].SupplyLineItems__r) {
                totalSupplyValue += tempSupplyItem.Quantity__c != null ? tempSupplyItem.Quantity__c : 0;
                totalSupplyQuantity += tempSupplyItem.Order_Value__c != null ? tempSupplyItem.Order_Value__c : 0;                
            }
        }
        
        
        //Displaying data in the new offer section
        newOfferSectlist=[SELECT id,Name,Product_Name__c,MRP_Value__c,APPL__c,Extra_Discount__c,Additional_Disc_on_APPL_disc__c,CTC__c,
                          Net_Invoice_Value_from_APPL__c,MRP_Post_Discount__c,Discounted_Price__c,Send_for_SPR__c,Approval_Status__c ,
                          ORC_MARGIN_TO_DLR_DIST__c,Tentative_Order_Date__c,Offer_Probability__c,Delivery_Start_Date__c,
                          Delivery_End_Date__c,Competitors_name__c,Distributor__c,Product_Specified__c,Payment_terms__c,
                          Delivery_Schedule__c,Product_Status__c ,Validity_for_the_Price__c,Project_Value__c FROM New_Offer_Section__c WHERE Project__c =: oppId AND Send_for_SPR__c != TRUE order by  Product_Name__c ASC]  ;
        
        //to display data in the Special Pricing List
        //List<Unique_SPR__c> uniqueSprList;
        sprWrapperList.clear();
        List<Unique_SPR__c> uniqueSprList=new List<Unique_SPR__c>([SELECT ID,Unique_Name__c,Net_Invoice_Value_APPL_Sum__c,Average_Discount_Provided__c,Approval_Status__c,Remarks__c,
                                                                   Number_of_SPR_s__c,Approver_Comments__c,Approval_date__c,Current_approver__c,Distributor__c,
                                                                   (SELECT ID,Competitors_name__c,Delivery_Start_Date__c,Payment_Term__c,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Extra_Discount__c,
                                                                    Project_Value__c,MRP_Post_Discount2__c,MRP_Value__c,Distributor__c,Net_Invoice_Value_from_APPL2__c,Additional_Disc_on_APPL_disc2__c,
                                                                    ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,Approval_Rejection_Date__c
                                                                    FROM New_Special_Pricing_Requests__r order by Product_name__c LIMIT 200) 
                                                                   FROM Unique_SPR__c WHERE Project__c=:oppId AND Number_of_SPR_s__c>=:1 AND Approval_Status__c!=NULL ORDER BY Createddate DESC]) ;   
        if(uniqueSprList.size()>0){
            List<ProcessInstanceWorkItem> processlist=new List<ProcessInstanceWorkItem>([SELECT id,ProcessInstance.TargetObjectId,ActorId,Actor.FirstName,Actor.lastname FROM ProcessInstanceWorkItem
                                                                                         WHERE ProcessInstance.Status='Pending' AND ProcessInstance.TargetObjectId IN:uniqueSprList]);
            //list<ProcessInstance> processlist=[SELECT Id,LastActor.Name,LastActorId,targetobjectId from ProcessInstance where targetobjectId IN: uniqueSprList AND Status='Pending'];
            for(ProcessInstanceWorkItem p :processlist){
                lastActormap.put(p.ProcessInstance.TargetObjectId,p.Actor.FirstName+p.Actor.lastname);
            }
            
            
            
            system.debug('approval map...'+lastActormap);
            for(Unique_SPR__c un : uniqueSprList){
                
                if(un.New_Special_Pricing_Requests__r.size() > 0){
                    //for(New_Special_Pricing_Request__c nsp : un.New_Special_Pricing_Requests__r){
                    if(un.Approval_Status__c=='Pending' || un.Approval_Status__c=='Approved'){
                        targetObjectIdList.add(un.Id);
                    }                        
                    if(un.Approval_Status__c!='Pending'){
                        approverIdMap.put(un.Id,0);
                    }                        
                    
                    //system.debug('date value:: ' + nsp.Delivery_Start_Date__c);    
                    SpecialPriceRequestWrapper sprWrapObject = new SpecialPriceRequestWrapper();
                    sprWrapObject.Id = un.Id;
                    //sprWrapObject.selectbutton = false;                        
                    
                    sprWrapObject.countrows = Integer.valueOf(un.Number_of_SPR_s__c);
                    sprWrapObject.uniqueName = un.Unique_Name__c;
                    sprWrapObject.averagePercent = un.Average_Discount_Provided__c;
                    sprWrapObject.netInvoiceValue = un.Net_Invoice_Value_APPL_Sum__c;
                    sprWrapObject.ApproverComment = un.Approver_Comments__c; 
                    sprWrapObject.RemarksValue = un.Remarks__c;
                    if(un.Approval_Status__c=='Pending'){
                        sprWrapObject.CurrentApprover = lastActormap.get(un.id);
                        
                        system.debug('nameeeee...'+sprWrapObject.CurrentApprover);
                    }else{
                        sprWrapObject.CurrentApprover = un.Current_approver__c;
                    }
                    
                    if(un.Approval_date__c != null) 
                        sprWrapObject.Approvaldate = un.Approval_date__c;//Date.newInstance(un.Approval_date__c.Year(),un.Approval_date__c.Month(),un.Approval_date__c.Day());
                    system.debug('Approvaldate ...'+sprWrapObject.Approvaldate );
                    sprWrapObject.ApprovalStatus = un.Approval_Status__c;
                    sprWrapObject.pendingSprList = un.New_Special_Pricing_Requests__r;// adding entire subquery to the list
                    
                    //sprwrapObject.PaymentTerms = nsp.Payment_Term__c; //mapping Payment Terms 
                    //sprWrapObject.CompetitorName = nsp.Competitors_name__c; //mapping competitors name
                    //sprWrapObject.DeliveryStartDate = nsp.Delivery_Start_Date__c; //mapping delivery start date
                    
                    sprWrapperList.add(sprWrapObject);     
                    //}
                }
                
            }
            system.debug('***sprWrapperList--->>'+sprWrapperList);
            system.debug('***sprWrapperList SIZE--->>'+sprWrapperList.size());
            // if(targetObjectIdList.size()>0){
            List<ProcessInstanceWorkItem> proInsList=new List<ProcessInstanceWorkItem>([SELECT id,ProcessInstance.TargetObjectId,ActorId FROM ProcessInstanceWorkItem
                                                                                        WHERE ProcessInstance.Status='Pending' AND ProcessInstance.TargetObjectId IN:targetObjectIdList]);   
            
            List<ProcessInstance> processInstanceList=new List<ProcessInstance>([SELECT Id, Status, CreatedDate,LastActorId, 
                                                                                 CompletedDate,TargetObjectId FROM ProcessInstance where status='Approved' 
                                                                                 AND TargetObjectId IN:targetObjectIdList]);
            
            
            
            if(proInsList.size()>0){
                
                for(ProcessInstanceWorkItem pro1 : proInsList){
                    system.debug('**********');
                    system.debug('pro1.ActorId---'+pro1.ActorId);
                    system.debug('currentUserLoginId---'+currentUserLoginId);
                    //admin and the actorid has the permission to approve/reject the records
                    if((currentUserLoginId==pro1.ActorId) || (pro.Id == userinfo.getprofileid())){
                        approverIdMap.put(pro1.ProcessInstance.TargetObjectId,1);
                    }
                    else{
                        approverIdMap.put(pro1.ProcessInstance.TargetObjectId,0);
                    }
                    
                }
            }
            
            //For enabling edit buuton if record approved only for the manager and sys admin
            
            if(processInstanceList.size()>0){
                
                for(ProcessInstance pro1 : processInstanceList){
                    system.debug('**********');
                    system.debug('pro1.ActorId---'+pro1.LastActorId);
                    system.debug('currentUserLoginId---'+currentUserLoginId);
                    //admin and the actorid has the permission to approve/reject the records
                    if((currentUserLoginId==pro1.LastActorId) || (pro.Id == userinfo.getprofileid())){
                        system.debug('entering 244 if');
                        approverIdMap.put(pro1.TargetObjectId,2);
                    }
                    
                }
            }
            
        }
        //  }
        
        
        /************************for generating offer*****************************/
        //the lost products wont appear in the offer list
        List<Unique_SPR__c> uniqueSprList2=new List<Unique_SPR__c>([SELECT ID,Unique_Name__c,Net_Invoice_Value_APPL_Sum__c,Average_Discount_Provided__c,Approval_Status__c,Distributor__r.Email_Id__c,Remarks__c,
                                                                    Number_of_SPR_s__c,Approver_Comments__c,
                                                                    (SELECT ID,Competitors_name__c,Delivery_Start_Date__c,Payment_Term__c,Product_name__c,APPL__c,CTC_Value__c,Discounted_Price2__c,Extra_Discount__c,
                                                                     Project_value__c,MRP_Post_Discount2__c,MRP_Value__c,Net_Invoice_Value_from_APPL2__c,Price_List_Date__c,Offer_Probability__c,Additional_Disc_on_APPL_disc2__c,
                                                                     ORC_MARGIN_TO_DLR_DIST__c,Distributor__c,Reason__c,Project__c,Tentative_Order_Date__c,Validity_for_the_Price__c,Approval_Rejection_Date__c 
                                                                     FROM New_Special_Pricing_Requests__r where Approval_Status__c=:'Approved' AND Product_Status__c != 'Loss'  LIMIT 200) 
                                                                    FROM Unique_SPR__c WHERE Project__c=:oppId AND Number_of_SPR_s__c>=:1 AND Approval_Status__c=:'Approved' ORDER BY Createddate DESC]) ;  
        system.debug('uniqueSprList2..'+uniqueSprList2);
        if(uniqueSprList2.size()>0){
            for(Unique_SPR__c un : uniqueSprList2){
                system.debug('uniqueSprList2.test inside for.'+uniqueSprList2);
                //Distributormailforuniquespr=un.Distributor__r.Email_Id__c;
                //   system.debug('email from unique'+Distributormailforuniquespr);
                if(un.New_Special_Pricing_Requests__r.size() > 0){
                    
                    //for(New_Special_Pricing_Request__c nsp : un.New_Special_Pricing_Requests__r){
                    offerSectionParentWrapper sprWrapObject = new offerSectionParentWrapper();
                    /*sprWrapObject.CompetitorName = nsp.Competitors_name__c; //Competitior's Name
sprWrapObject.DeliveryDate = nsp.Delivery_Start_Date__c; //Delivery Start Date
sprWrapObject.ORC = nsp.ORC_MARGIN_TO_DLR_DIST__c; //ORC Markup
sprWrapObject.PaymentTerm = nsp.Payment_Term__c; //Payment Term*/
                    
                    sprWrapObject.uniqueName = un.Unique_Name__c;
                    sprWrapObject.isSelectParent=false;
                    sprWrapObject.Ids=un.Id;
                    //sprWrapObject.RemarksValue=un.Remarks__c;
                    
                    sprWrapObject.newsprList2 = un.New_Special_Pricing_Requests__r;// adding entire subquery to the list
                    offSectionParentList.add(sprWrapObject);
                    
                    //}
                }
            }
        }
        
        /***********************************************/
        
        
        //for generating Order
        
        
        
        
        
        
        List<Order_Line_Item__c> orderItemList=new List<Order_Line_Item__c>([SELECT ID,Product_name__c,MRP_Post_Discount__c,Extra_Discount__c,Net_Invoice_Value_from_APPL2__c,ORC_Status__c,ORC_Markup__c,New_Order__r.Name,
                                                                             Supply_End_Date__c,Competitors_name__c,ORC_MARGIN_TO_DLR_DIST__c,Payment_Terms__c,Project__c,APPL__c,Validity_for_the_Price__c,
                                                                             Price_List_Date__c,Distributor__r.Name,Unique_Name_relation__c,Order_Value__c,Offer_Probability__c,MRP_Value__c,Tentative_Order_Date__c,Supply_Start_Date__c 
                                                                             FROM Order_Line_Item__c WHERE Project__c=:oppId ORDER BY New_Order__r.Name Desc]);
        
        for(Order_Line_Item__c oli13:orderItemList){
            newsprList3.add(oli13.New_Order__r.Name);
        }
        
        if(orderItemList.size()>0){
            for(Order_Line_Item__c olitem : orderItemList){
                
                //creating an object of wrapper class and mapping OLI fields to it.
                
                generateOrderWrapper ord=new generateOrderWrapper();
                ord.ORC = olitem.ORC_MARGIN_TO_DLR_DIST__c;
                ord.generateSupplyOnClick=false;
                ord.orderId=olitem.New_Order__c;
                ord.orderName = olitem.New_Order__r.Name; //Order Name
                //ord.newsprList3 = olitem.Unique_Name_relation__c;
                ord.productName=olitem.Product_name__c;
                ord.orderValue=String.valueOf(olitem.MRP_Value__c); //String.valueOf(olitem.Order_Value__c);
                ord.PaymentTerms=olitem.Payment_Terms__c;
                ord.SupplyStartDate=olitem.Supply_Start_Date__c;
                ord.SupplyEndDate=olitem.Supply_End_Date__c;
                ord.priceValidity=olitem.Validity_for_the_Price__c;
                ord.competitorsName=olitem.Competitors_name__c;
                ord.orcMarkup=olitem.ORC_Markup__c;
                ord.orcStatus=olitem.ORC_Status__c;
                ord.distributor=olitem.Distributor__r.Name;
                
                orderList1.add(ord);
            }
            
        }                                                                                          
        
        
    }
    
    public pageReference offerPdf(){
        System.debug('pageReference outside ' + oppId);
        PageReference pf = new PageReference('/apex/OfferForClientPDF?att='+oppId);
        System.debug('pageReference outside ' + oppId);
        return pf;
    }
    
    /* This method will get all the influencer list */
    public List<Influencer__c> getInfluencerList() {
        
        influList = [SELECT Id, Account__c, Account__r.Firm_Name__c,Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c,Inf_Order__c,Source__c FROM Influencer__c WHERE Opportunity__c = :oppId Order BY Inf_Order__c Asc];
        
        return influList;
    }
    
    public PageReference editInfluencer(){ 
        
        PageReference pf = new PageReference('/apex/MassEditInfulencers?ProjectId='+oppId);
        return pf;
    } 
    
    
    public List<Project_Tracker__c> getProjectTrackerList() {
        
        projectTrackList = [SELECT Opportunity__c,Question__c,Remarks__c,Response__c,Probability__c,Project_Order__c,Action_Plan__c,Action_Date__c FROM Project_Tracker__c WHERE Opportunity__c = :oppId ORDER by Project_Order__c ASC];
        return projectTrackList;
    }
    
    public PageReference editProjectTrack(){
        
        PageReference pf = new PageReference('/apex/MassEditProjectTracker?ProjectId='+oppId);
        return pf;
    }
    
    /* public List<OpportunityLineItem> getOfferListPro()
{
offerList = [SELECT Id,OpportunityId,Competitor_name_Offer__c,PricebookEntry.Product_number__c,product2.name,product2Id,Offer_Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Distributor__c,Unit__c,Offer_MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c, Offer_Quantity__c,Reason__c,APPL_Type__c,Offer_Check__c,Discount_Offered__c,Price_List_Date__c,Price_Valid_Date__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true ORDER by PricebookEntry.Product_number__c];
if(offerList.size() != 0) {
return offerList;
}
else {
return null;
}
}*/
    
    
    
    public List<SupplyLineItem__c> getSupplyListPro()
    {   
        try{
            List<SupplyLineItem__c> temp = new List<SupplyLineItem__c>();
            parentSupplyList = new List<Supply__c>([SELECT Id, (SELECT SupplyDetails__r.New_Order__r.Name,Product_name__c,Quantity__c, Unit__c, Order_Value__c, Invoice_Date__c, Payment_Terms__c, Supply_Status__c, Distributor_Name__c, ORC_Markup__c, ORC_Status__c FROM SupplyLineItems__r) FROM Supply__C WHERE Project__c !=null and Project__c = : oppId and Number_of_SLI__c>:0  ORDER BY CreatedDate DESC ]);
            system.debug('parentSupplyList--'+parentSupplyList);
            if(parentSupplyList.size()>0){
                
                
                for(Supply__c each : parentSupplyList){
                    system.debug('each.SupplyLineItems__r---'+each.SupplyLineItems__r.size());
                    if(each.SupplyLineItems__r!=null)
                    {
                        system.debug('hey there');
                        system.debug('temp 0'+temp.size());
                        temp.addAll(each.SupplyLineItems__r); 
                    }
                    system.debug('temp 1'+temp.size()); 
                } 
            }
            system.debug('temp 2'+temp);
            
            if(temp.size()>0){
                system.debug('entered here in if**');
                return temp;      
            }
            else{
                system.debug('entered here in else');
                return null;
            } 
        }
        catch(Exception e){
            // system.debug('exception occured while displaying supply line item at line'+e.getLineNumber());
            system.debug('cause--'+e.getCause());
            system.debug('message--'+e.getMessage());
            system.debug('trace--'+e.getStackTraceString());
            return NULL;
        }
        
    }
    
    //this wrapper class gnerates order lost products from product fitment list and offer list    
    public class orderLossProducts{
        public string productName{get;set;}
        public Decimal mrpValue{get;set;}
        public Decimal ExtraDiscount{get;set;}
        public Decimal DiscountedPrice{get;set;}
        public String LostToBrand{get;set;}
        public String ReasonofLostSales{get;set;}
        public String otherReason{get;set;}
        
    }
    
    public List<orderLossProducts> getOrderLossProducts()
    {
        // orderLossList = [SELECT product2.name, PricebookEntry.Product_number__c, Order_Loss_by_Disc__c, Order_Lost_to_Competitor__c, Description, Order_Loss__c,Reason_for_Order_Loss__c FROM OpportunityLineItem where OpportunityId =:oppId and Order_Loss_Check__c = true ORDER by PricebookEntry.Product_number__c];
        newOrderLossList=new List<orderLossProducts>();
        List<New_Special_Pricing_Request__c> newchildsprList=new List<New_Special_Pricing_Request__c>([SELECT ID,Product_name__c,
                                                                                                       APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                                                                                                       MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,Unique_SPR__r.Unique_Name__c,
                                                                                                       ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,
                                                                                                       Price_List_Date__c,Reason_of_lost_sales__c,Others_Lost_Sales__c,Loss_to_brand__c,Offer_Probability__c,Tentative_Order_Date__c,Reason__c
                                                                                                       FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                                                                                                       AND Project__c=:oppId  AND Product_Status__c=:'Loss']);
        
        
        orderLossList=[SELECT id,Product_Name__c,MRP_Value__c,APPL__c,Extra_Discount__c,Net_Invoice_Value_from_APPL__c,MRP_Post_Discount__c,Discounted_Price__c,
                       Send_for_SPR__c,Approval_Status__c ,Reason_of_lost_sales__c,Others_Lost_Sales__c,Lost_to_brand__c,
                       ORC_MARGIN_TO_DLR_DIST__c,Tentative_Order_Date__c,Offer_Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,
                       Competitors_name__c,Distributor__c,Product_Specified__c,Payment_terms__c,Delivery_Schedule__c,Product_Status__c ,
                       Why_Additional_Discount__c,Validity_for_the_Price__c FROM New_Offer_Section__c 
                       WHERE Project__c =: oppId AND Product_Status__c = 'Loss' ];
        
        
        if(orderLossList.size()>0){
            for(New_Offer_Section__c loss:orderLossList){
                orderLossProducts orderloss=new orderLossProducts();
                orderloss.productName=loss.Product_Name__c;
                orderloss.mrpValue=loss.MRP_Value__c;
                orderloss.ExtraDiscount=loss.Extra_Discount__c;
                orderloss.DiscountedPrice=loss.Discounted_Price__c;
                orderloss.LostToBrand=loss.Lost_to_brand__c;
                orderloss.ReasonofLostSales=loss.Reason_of_lost_sales__c;
                orderloss.otherReason=loss.Others_Lost_Sales__c;
                
                newOrderLossList.add(orderloss);  
            }
        }
        if(newchildsprList.size()>0){
            for(New_Special_Pricing_Request__c loss:newchildsprList){
                orderLossProducts orderloss=new orderLossProducts();
                orderloss.productName=loss.Product_Name__c;
                orderloss.mrpValue=loss.MRP_Value__c;
                orderloss.ExtraDiscount=loss.Extra_Discount__c;
                orderloss.DiscountedPrice=loss.Discounted_Price2__c;
                orderloss.LostToBrand=loss.Loss_to_brand__c;
                orderloss.ReasonofLostSales=loss.Reason_of_lost_sales__c;
                orderloss.otherReason=loss.Others_Lost_Sales__c;
                
                newOrderLossList.add(orderloss);  
            } 
            
            
        }
        
        
        if(newOrderLossList.size() != 0) {
            
            //system.debug('*******oppOfferList**********'+oppOfferList);
            
            return newOrderLossList;
        }
        else {
            return null;
        }
    }
    /************************************************/
    
    //to display data in the new offer section this wrapper class is created
    public class SpecialPriceRequestWrapper{
        // public Unique_SPR__c uniquespr{get;set;}
        public String uniqueName{get;set;}
        public Integer countrows{get;set;}
        public Id Id{get;set;}
        public String ApproverComment{get;set;}
        public String CompetitorName{get;set;}
        public Date DeliveryStartDate{get;set;}
        public Decimal averagePercent{get;set;}
        public String CurrentApprover{get;set;}
        public Date Approvaldate{get;set;}
        public Decimal netInvoiceValue{get;set;}
        public String ApprovalStatus{get;set;}
        public boolean selectbutton{get;set;}
        public String PaymentTerms{get;set;}
        public String RemarksValue{get;set;}
        
        public List<New_Special_Pricing_Request__c> pendingSprList{get;set;}
        public SpecialPriceRequestWrapper(){
            uniqueName='';
            pendingSprList=new list<New_Special_Pricing_Request__c>();
            selectbutton=false;
        }
        
    }
    
    
    //on call of this method it takes to the standard approval page
    public PageReference approvalActions(){
        try{
            system.debug('app actions calleed');
            system.debug('unsprId---'+unsprId);
            Id processId=[SELECT Id from ProcessInstance where targetobjectId=: unsprId AND Status='Pending' LIMIT 1].Id;
            Id workItemId=[SELECT ID from ProcessInstanceWorkItem where ProcessInstanceId=:processId LIMIT 1].Id;
            PageReference pf = new PageReference('/' +workItemId);
            system.debug('pf--'+pf);
            return pf;
            
        }
        catch(Exception e){
            system.debug('exception occured during approval button is clicked');
            PageReference pf = new PageReference('/'+oppId);
            return pf;
        }  
        
    }
    
    public void UniuesprIdMethod(){
        system.debug('uniqueSprOfferId---'+uniqueSprOfferId);
        if(!uniqueSprOfferIdList.contains(uniqueSprOfferId)){
            uniqueSprOfferIdList.add(uniqueSprOfferId);
            system.debug('uniqueSprOfferIdList-1-'+uniqueSprOfferIdList);
        }
        else if(uniqueSprOfferIdList.contains(uniqueSprOfferId)){
            for (Integer i = 0; i < uniqueSprOfferIdList.size(); i++) {
                if(uniqueSprOfferIdList[i]==uniqueSprOfferId){
                    uniqueSprOfferIdList.remove(i);
                }
            }
            system.debug('uniqueSprOfferIdList-2-'+uniqueSprOfferIdList); 
        }
        
        
        
    }
    
    public Pagereference generateOrder(){
        
        system.debug('generate offer is clicked');
        system.debug('mapOfferSelected---'+mapOfferSelected);
        
        
        try{
            if(uniqueSprOfferIdList.size()==0 || uniqueSprOfferIdList.size() == NULL){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Atleast one offer must be selected for generating order'));
                return null;
            }
            
            system.debug('uniqueSprOfferIdList---'+uniqueSprOfferIdList);
            
            List<New_Special_Pricing_Request__c> newchildsprList=new List<New_Special_Pricing_Request__c>([SELECT ID,Competitors_name__c,Delivery_Start_Date__c,Payment_Term__c,Product_name__c,
                                                                                                           APPL__c,CTC_Value__c,Discounted_Price2__c,Additional_Disc_on_APPL_disc2__c,Extra_Discount__c,MRP_Value__c,
                                                                                                           MRP_Post_Discount2__c,Net_Invoice_Value_from_APPL2__c,Unique_SPR__c,Unique_SPR__r.Unique_Name__c,
                                                                                                           ORC_MARGIN_TO_DLR_DIST__c,Project__c,Validity_for_the_Price__c,
                                                                                                           Price_List_Date__c,Offer_Probability__c,Tentative_Order_Date__c,Reason__c
                                                                                                           FROM New_Special_Pricing_Request__c WHERE Unique_SPR__r.Number_of_SPR_s__c>=:1
                                                                                                           AND Project__c=:oppId AND Unique_SPR__c IN:uniqueSprOfferIdList AND Product_Status__c!='Loss']);
            
            system.debug('newchildsprList'+newchildsprList);
            system.debug('newchildsprList--------'+newchildsprList.size());
            List<New_Order__c> norder=new List<New_Order__c>([SELECT id,Order_Number__c FROM New_Order__c ORDER BY Order_Number__c desc limit 1]);
            //insert order 
            if(newchildsprList.size()>0){
                New_Order__c orderObj=new New_Order__c();
                orderObj.Order_Number__c=norder.size()==NULL || norder.size()==0?1:norder[0].Order_Number__c+1;
                orderObj.Project__c=oppId;
                orderObj.Account__c=projectById;
                insert orderObj;
                
                
                List<Order_Line_Item__c> oliToInsert=new List<Order_Line_Item__c>();
                for(New_Special_Pricing_Request__c sprToInsert:newchildsprList){
                    Order_Line_Item__c oli=new Order_Line_Item__c();
                    
                    oli.Competitors_name__c=sprToInsert.Competitors_name__c; //Competitor's Name
                    oli.Supply_Start_Date__c=sprToInsert.Delivery_Start_Date__c; //Delivery Start Date
                    oli.ORC_MARGIN_TO_DLR_DIST__c =sprToInsert.ORC_MARGIN_TO_DLR_DIST__c; //ORC
                    oli.Payment_Terms__c = sprToInsert.Payment_Term__c; //Payment Terms
                    oli.ORC_Markup__c=String.valueOf(sprToInsert.ORC_MARGIN_TO_DLR_DIST__c);
                    oli.Product_Name__c=sprToInsert.Product_name__c;
                    oli.Extra_Discount__c=sprToInsert.Extra_Discount__c;
                    oli.MRP_Post_Discount__c=sprToInsert.MRP_Post_Discount2__c;
                    oli.APPL__c=sprToInsert.APPL__c;
                    oli.MRP_Value__c=sprToInsert.MRP_Value__c;
                    oli.Offer_Probability__c=sprToInsert.Offer_Probability__c; 
                    oli.Tentative_Order_Date__c=sprToInsert.Tentative_Order_Date__c;
                    oli.Price_List_Date__c=sprToInsert.Price_List_Date__c; 
                    oli.Validity_for_the_Price__c=sprToInsert.Validity_for_the_Price__c; 
                    oli.New_Order__c=orderObj.Id;
                    oli.Project__c=oppId;
                    oli.Unique_Name_relation__c=sprToInsert.Unique_SPR__r.Unique_Name__c;
                    oli.Distributor__c=DistributorId;
                    oliToInsert.add(oli);
                    
                }
                if(oliToInsert.size()>0){
                    insert oliToInsert;
                    //mapOfferSelected.clear();
                    uniqueSprOfferIdList.clear();
                }
            }
            PageReference pf = new PageReference('/'+oppId);
            return pf;
        }
        catch(Exception e){
            system.debug('exception occued--'+e.getMessage()); 
            PageReference pf = new PageReference('/'+oppId);
            return pf;
        }
        
    }
    //for generating supply whne the supply button is clciked--- added by subhajit
    public PageReference generateSupply(){
        system.debug('orderList1: ' + orderList1);
        Integer anyOrderSelectCount=0;//for counting whether any orders have been selected for supply
        //system.debug('orderList1--->'+orderList1[0].generateSupplyOnClick);
        try{
            for(generateOrderWrapper ord1:orderList1){
                if(ord1.generateSupplyOnClick==true){
                    anyOrderSelectCount++;
                    break;
                }
            }
            if(anyOrderSelectCount==0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Atleast one order must be selected for generating supply'));
                return null;
            }
            List<SupplyLineItem__c> supLineItem=new  List<SupplyLineItem__c>();
            for(generateOrderWrapper ord:orderList1){
                if(ord.generateSupplyOnClick==true){
                    system.debug('yes true present');
                    Supply__c supply=new Supply__c();
                    supply.New_Order__c=ord.orderId;
                    supply.Project__c=oppId;
                    insert supply;
                    system.debug('yes true presen1t');
                    
                    if(supply.id!=NULL){
                        SupplyLineItem__c sli=new SupplyLineItem__c();
                        sli.ORC_Markup__c=String.valueOf(ord.ORC);
                        sli.ORC_Status__c=ord.orcStatus;
                        //sli.Order_Value__c=ord.ordervalue==NULL?0:Decimal.valueOf(ord.ordervalue);
                        //sli.Order_Name__c = ord.orderName;
                        sli.Order_Value__c = Decimal.valueOf(ord.ordervalue); 
                        sli.Payment_Terms__c=ord.paymentTerms;
                        sli.Project__c=oppId;
                        sli.SupplyDetails__c=supply.Id;
                        sli.Product_name__c=ord.productName; //product from ORDER to SUPPLY
                        sli.Distributor_Name__c=distributorId;
                        supLineItem.add(sli);
                        system.debug('yes true presen2t');
                    }
                    
                } 
            }
            if(supLineItem.size()>0){
                insert supLineItem;
                system.debug('inserte true present');
            }
            // }
            PageReference pf = new PageReference('/'+oppId);
            return pf; 
        }
        catch(Exception e){
            system.debug('exception occured while generating supply--'+e.getMessage());
            system.debug('exception occured while in line----'+e.getLineNumber());
            system.debug('error');
            PageReference pf = new PageReference('/'+oppId);
            return pf;
            
        }
        
        
        
    }
    
    
    //to display data in the offer section
    //Parent Wrapper containing parent record along with child record list for display in offer section
    public class offerSectionParentWrapper{
        public String CompetitorName{get;set;} //Competitor Name
        public Date DeliveryDate{get;set;} //Delivery Date
        public Decimal ORC{get;set;} //ORC Markup
        public String PaymentTerm{get;set;} //Payment Terms
        
        public String uniqueName{get;set;}
        public String Ids{get;set;}
        public boolean isSelectParent{get;set;}
        public List<New_Special_Pricing_Request__c> newsprList2{get;set;}
    }
    
    
    
    //for generating orders in the order section this wrapper class is used
    public class generateOrderWrapper{
        public Decimal ORC{get;set;}
        
        public boolean generateSupplyOnClick{get;set;}
        public String productName{get;set;}
        public String OrderValue{get;set;}
        public String orderId{get;set;}
        public String orderName{get;set;}
        public Date SupplyStartDate{get;set;}
        public Date SupplyEndDate{get;set;}
        public Date priceValidity{get;set;}
        public String PaymentTerms{get;set;}
        public String CompetitorsName{get;set;}
        public string DistributorName{get;set;}
        public String orcMarkUp{get;set;}
        public string orcStatus{get;set;}
        public String distributor{get;set;}
        
        
        /*public List<String> newsprList3{get;set;}

public generateOrderWrapper(){
newsprList3=new list<String>();
}*/
        
    }
    
    //on click of Email To DP button--- this function sends email to the distributor
    
    public PageReference emailDP(){
        
        
        
        try{
             System.debug('inside try '+Projectowneremail);
                LIST<Opportunity> EmailName  = new  List<Opportunity>([SELECT Id,Name FROM  Opportunity WHERE Id =: oppId LIMIT 1]);
                String fileName = EmailName[0].Name;
            system.debug('IsPlumbing'+IsPlumbing);
            if(IsPlumbing == true || projectOwnerId=='0053A00000EmhIOQAZ' || projectOwnerId=='0053A00000EnG6CQAV' || projectOwnerId=='00530000008y6uVAAQ' || projectOwnerId=='0053A00000FG3plQAD'|| projectOwnerId=='00530000003mqMzAAI'|| projectOwnerId=='0053A00000E64VWQAZ'|| projectOwnerId=='0053A00000E64X3QAJ'|| projectOwnerId=='0053A00000EmhxWQAR'|| projectOwnerId=='0053A00000EnG6HQAV'|| projectOwnerId=='0053A00000DMVTnQAP')
            {
                List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
                
            System.debug('inside If isPlumbing');
                
                pagereference pg=new pagereference('/apex/EmailToDistributorVF?projectId='+oppId+'&uniqueSPRId='+unsprId);
                pg.getParameters().put('projectId',oppId);
                blob pdf;
                 if(test.isRunningTest()){
                  pdf = blob.valueOf('testclass');
    
                }
                else{
                    pdf=pg.getContentAsPdf();
                }
                
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('SpecialPricingRequest_'+fileName +'.pdf');
                efa.setContentType('application/pdf');
                efa.setBody(pdf);
               /* String ccaddressEmails;
                List<CC_EmailsToDistributor__c> ccList=new List<CC_EmailsToDistributor__c>([select id,Additional_Email__c from CC_EmailsToDistributor__c Order by Createddate desc LIMIT 1]);
                if(ccList.size() > 0){
                    ccaddressEmails=ccList[0].Additional_Email__c;
                }*/
                
                //String addresses=Distributormailforuniquespr;
                String addresses=distributorEmail;
                system.debug('addresses---'+addresses);
                if(addresses==NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No email address found for distributor. Email Id field must be empty '));
                    unsprId='';
                    return null;
                }
                
                
                List<String> toAddresses = addresses.split(',');
                List<String> ccAddress= new List<String>();
                system.debug(ccAddress);
                ccAddress.add('retail.projects@ashirvad.com');
                ccAddress.add('prakash.tripathi@ashirvad.com');
                ccAddress.add(Projectowneremail);
                system.debug('toAddresses---'+toAddresses);
                system.debug('ccAddress--- in if condition....'+ccAddress);
                emailalert=true;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses( toAddresses ); 
                email.setCcAddresses(ccAddress);
                email.setSubject(projectName+'-Approved SPRs');
                email.setHtmlBody('Dear'+'&nbsp;'+ DistributorName+','+'<br/>' +'<br/>' +'Special Pricing Request for '+projectName+' '+'project has been approved.'+'<br/>'+'PDF is attached to the Email that contains a detail information of Project. '+'<br/>'+'<br/>'+'<br/>'+'<br/>'+'Thank You'+'<br/>'+UserInfo.getName()); 
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                emails.add(email);
                Messaging.sendEmail(emails);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email Sent '));
                PageReference pf = new PageReference('/'+oppId);
                unsprId='';
                
                return pf;

            }
            else{
                System.debug('inside else '+Projectowneremail);
                if(Projectowneremail=='bogala.meganath@ashirvad.com'|| Projectowneremail=='radhakrishna.pabbati@ashirvad.com'||Projectowneremail=='nanduru.avinash@ashirvad.com'){
                
                List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
                
            System.debug('inside if Projects ');
                
                pagereference pg=new pagereference('/apex/EmailToDistributorVF?projectId='+oppId+'&uniqueSPRId='+unsprId);
                pg.getParameters().put('projectId',oppId);
                blob pdf;
                 if(test.isRunningTest()){
                  pdf = blob.valueOf('testclass');
    
                }
                else{
                    pdf=pg.getContentAsPdf();
                }
                
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('SpecialPricingRequest_'+fileName +'.pdf');
                efa.setContentType('application/pdf');
                efa.setBody(pdf);
                String ccaddressEmails;
                List<CC_EmailsToDistributor__c> ccList=new List<CC_EmailsToDistributor__c>([select id,Additional_Email__c from CC_EmailsToDistributor__c Order by Createddate desc LIMIT 1]);
                if(ccList.size() > 0){
                    ccaddressEmails=ccList[0].Additional_Email__c;
                }
                
                //String addresses=Distributormailforuniquespr;
                String addresses=distributorEmail;
                system.debug('addresses---'+addresses);
                if(addresses==NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No email address found for distributor. Email Id field must be empty '));
                    unsprId='';
                    return null;
                }
                
                
                List<String> toAddresses = addresses.split(',');
                List<String> ccAddress=ccaddressEmails.split(',');
                system.debug(ccAddress);
                ccAddress.add('dhananjaya.yattapu@ashirvad.com');
                ccAddress.add(Projectowneremail);
                system.debug('toAddresses---'+toAddresses);
                system.debug('ccAddress--- in if condition....'+ccAddress);
                emailalert=true;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses( toAddresses ); 
                email.setCcAddresses(ccAddress);
                email.setSubject(projectName+'-Approved SPRs');
                email.setHtmlBody('Dear'+'&nbsp;'+ DistributorName+','+'<br/>' +'<br/>' +'Special Pricing Request for '+projectName+' '+'project has been approved.'+'<br/>'+'PDF is attached to the Email that contains a detail information of Project. '+'<br/>'+'<br/>'+'<br/>'+'<br/>'+'Thank You'+'<br/>'+UserInfo.getName()); 
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                emails.add(email);
                Messaging.sendEmail(emails);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email Sent '));
                PageReference pf = new PageReference('/'+oppId);
                unsprId='';
                
                return pf;
            } 
              
          
        
            
            else{
                
                System.debug('inside else Projects ');
                List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
                
                
                pagereference pg=new pagereference('/apex/EmailToDistributorVF?projectId='+oppId+'&uniqueSPRId='+unsprId);
                system.debug('pg===>'+pg);
                pg.getParameters().put('projectId',oppId);
                blob pdf;
              //   system.debug('pdf===>'+pg.getContentAsPdf());
                if(test.isRunningTest()){
                  pdf = blob.valueOf('testclass');
    
                }
                else{
                    pdf=pg.getContentAsPdf();
                }
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('SpecialPricingRequest_'+fileName+'.pdf');
                efa.setContentType('application/pdf');
                efa.setBody(pdf);
                String ccaddressEmails;
                List<CC_EmailsToDistributor__c> ccList=new List<CC_EmailsToDistributor__c>([select id,Additional_Email__c from CC_EmailsToDistributor__c Order by Createddate desc LIMIT 1]);
                if(ccList.size() > 0){
                    ccaddressEmails=ccList[0].Additional_Email__c;
                }
                
                //String addresses=Distributormailforuniquespr;
                String addresses=distributorEmail;
                system.debug('addresses---'+addresses);
                if(addresses==NULL){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No email address found for distributor. Email Id field must be empty '));
                    unsprId='';
                    return null;
                }
                
                
                List<String> toAddresses = addresses.split(',');
                List<String> ccAddress=ccaddressEmails.split(',');
                ccAddress.add(Projectowneremail);
                system.debug('toAddresses---'+toAddresses);
                system.debug('ccAddress---'+ccAddress);
                emailalert=true;
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses( toAddresses ); 
                email.setCcAddresses(ccAddress);
                email.setSubject(projectName+'-Approved SPRs');
                email.setHtmlBody('Dear'+'&nbsp;'+ DistributorName+','+'<br/>' +'<br/>' +'Special Pricing Request for '+projectName+' '+'project has been approved.'+'<br/>'+'PDF is attached to the Email that contains a detail information of Project. '+'<br/>'+'<br/>'+'<br/>'+'<br/>'+'Thank You'+'<br/>'+UserInfo.getName()); 
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                emails.add(email);
                Messaging.sendEmail(emails);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Email Sent '));
               
            }
                 
        }
            PageReference pf = new PageReference('/'+oppId);
                unsprId='';
                
                return pf;

                
    }
                    
   
        
        catch(Exception e){
            system.debug('error occured while sending emails--'+e.getMessage());
            system.debug('eror line--'+e.getLineNumber());
            unsprId='';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Email not delivered/ Invalid email... Contact admin'));
            return null;
            
        }
    } 
    //on click of Email To customer button--- this function sends email to the distributor
    public PageReference emailCustomer(){
        try{
            
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
            pagereference pg=new pagereference('/apex/EmailToCustomerVF?projectId='+oppId+'&uniqueSPRId='+unsprId);
            pg.getParameters().put('projectId',oppId);
            blob pdf;
             if(test.isRunningTest()){
                  pdf = blob.valueOf('testclass');
    
                }
                else{
                   pdf=pg.getContentAsPdf();
                }
                
           
            
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('SpecialPricingRequest_Customer.pdf');
            efa.setContentType('application/pdf');
            efa.setBody(pdf);
            
            String addresses=customerEmail;
            system.debug('addresses---'+addresses);
            if(addresses==NULL){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No email address found for customer. Email Id field must be empty '));
                unsprId='';
                return null;
            }
            
            String[] toAddresses = addresses.split(',');
            system.debug('toAddresses---'+toAddresses);
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses( toAddresses ); 
            email.setSubject(projectName+'-Approved SPRs');
            email.setHtmlBody('Dear'+'&nbsp;'+ CustomerName+','+'<br/>' +'<br/>' +'Attached below are the list of items/products that has been approved and are moved to offer.'+'<br/>'+'<br/>'+'<br/>'+'<br/>'+'Thank You'+'<br/>'+UserInfo.getName()); 
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            emails.add(email);
            Messaging.sendEmail(emails);
            
            PageReference pf = new PageReference('/'+oppId);
            unsprId='';
            return pf;
        }
        
        
        catch(Exception e){
            system.debug('error occured while sending emails--'+e.getMessage());
            system.debug('eror line--'+e.getLineNumber());
            unsprId='';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Email not delivered/ Invalid email... Contact admin'));
            return null;
            
        }
    } 
    public pageReference pagref(){
        
        return new pagereference('https://appl-ashirvadpipes--projectrev.lightning.force.com/c/Test_Application.app?'+oppRecord.id);
    }
}
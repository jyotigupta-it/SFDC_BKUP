/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :13-Jan-2015
Modified By     :Pooja K
Modified Date   :12-Jun-2017
Version         :32.0
Description     :Controller of Addl_Disc_Req_Approved Component

********************XXX***********************************/




global class Addl_Disc_Component_Controller {

/********************************************ADDED*****************************************/

    public Decimal averageOfPro {get;set;}
    public Decimal averageOfPro1 {get;set;}
    public Decimal Special_Pricing_Request_Offer {get;set;}
    public Decimal orderValue=0,totalValue=0,totalValueAddl=0,total=0   ;
    public Decimal orderValue1=0,totalValue1=0,totalValueAddl1=0,total1=0   ;
    //public String oppId_1{get;set;}
    global List<wrapProcessInstance > sprOLD_1 {get;set;}
    global List<wrapProcessInstance > sprNEW_1 {get;set;}
    global list<ProcessInstance> lstApproval{get;set;}
    global List<wrapProcessInstance> listofApproval{get;set;}
    global List<wrapProcessInstance> listofApprovalNew{get;set;}
    
    global List<wrapProcessInstance> joinApprovalOldSPR{get;set;}
    
    global string OwnerName{get;set;}


/*****************************************ADDED ENDS*****************************************/


    
    global List<statusCorrection> changeStatus{get;set;}
    
    global Id oppId {get;set;}
    global  String customerName{get;set;}
    global Integer count {get; set;}
    global String  statusCase{get;set;}
    global List<String> statusList{get;set;}
    public list<ProcessInstanceStep> lstProcessInstanceStep{get;set;}
    
    global List<OpportunityLineItem >oz{get;set;}
    global Opportunity opportunityObj{get;set;}

    public List<statusCorrection> sprOLD {get;set;}
    public List<statusCorrection> sprNEW {get;set;}
    
    
    
    public String getData(){
           listofApproval=new list<wrapProcessInstance>();


     listofApprovalNew=new list<wrapProcessInstance>();
     try{
        // oppId = ApexPages.CurrentPage().getParameters().get('opporId');
         //System.debug('WantedList oppId '+oppId );
         System.debug('Opportunity ID %%%%%'+oppId);
         Opportunity opOwner=new Opportunity();
         opOwner=[select id,Owner.name from opportunity where id=:oppId limit 1];
         wrapProcessInstance temp1=new wrapProcessInstance();
         OwnerName=opOwner.owner.name;
         lstApproval = new list<ProcessInstance>();
         lstApproval=[SELECT Id, Status, CreatedDate,LastActorId, CompletedDate, TargetObjectId,
                                                 (SELECT Id, StepStatus, Actor.Name,
                                                 CreatedDate, ProcessNodeId, ProcessNode.Name, Comments
                                                 FROM StepsAndWorkitems order by CreatedDate),(SELECT Id, StepStatus, Comments FROM Steps)
                                                 from ProcessInstance
                                                 Where TargetObjectId =: OppID order by CreatedDate DESC ];

         System.debug('testing'+lstApproval.size());



        for(integer i=0;i<lstApproval.size();i++){

            wrapProcessInstance temp=new wrapProcessInstance();
            temp.historyCompletedDate=lstApproval[i].CompletedDate;

            System.debug(lstApproval[i].StepsAndWorkitems.size());
            if(lstApproval[i].StepsAndWorkitems.size()>0){
                for (integer j = 0; j<lstApproval[i].StepsAndWorkitems.size(); j++) {

                    if (lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name == 'Step 1') {
                        temp.actorNameStep1 = lstApproval[i].StepsAndWorkitems[j].Actor.Name;

                      //temp.actorComment1 +=lstApproval[i].Steps[j].comments;
                        temp.actorComment1 =lstApproval[i].StepsAndWorkitems[j].comments;

                     } else if (lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name == 'Step 2') {

                        temp.actorNameStep2 = lstApproval[i].StepsAndWorkitems[j].Actor.Name;

                      //temp.actorComment2 +=lstApproval[i].Steps[j].comments;
                        temp.actorComment2 =lstApproval[i].StepsAndWorkitems[j].comments;

                     }
                     temp.InnerCreatedDate = lstApproval[i].StepsAndWorkitems[j].CreatedDate;
                     temp.stepStatus = lstApproval[i].StepsAndWorkitems[j].StepStatus;

                }

        }
          listofApproval.add(temp);
     }


       /******************************Latest Approval Comments Only *****************************/
            integer i=0;
            wrapProcessInstance temp=new wrapProcessInstance();
            temp.historyCompletedDate=lstApproval[i].CompletedDate;

            System.debug(lstApproval[i].StepsAndWorkitems.size());
            if(lstApproval[i].StepsAndWorkitems.size()>0){

                for (integer j = 0; j<lstApproval[i].StepsAndWorkitems.size(); j++) {

                    if (lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name == 'Step 1') {
                        temp.actorNameStep1 = lstApproval[i].StepsAndWorkitems[j].Actor.Name;

                      //temp.actorComment1 +=lstApproval[i].Steps[j].comments;
                        temp.actorComment1 +=lstApproval[i].StepsAndWorkitems[j].comments;

                     } else if (lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name == 'Step 2') {

                        temp.actorNameStep2 = lstApproval[i].StepsAndWorkitems[j].Actor.Name;

                      //temp.actorComment2 +=lstApproval[i].Steps[j].comments;
                        temp.actorComment2 +=lstApproval[i].StepsAndWorkitems[j].comments;

                     }
                     temp.InnerCreatedDate = lstApproval[i].StepsAndWorkitems[j].CreatedDate;
                     temp.stepStatus = lstApproval[i].StepsAndWorkitems[j].StepStatus;

                }

        }
          listofApprovalNew.add(temp);
  /****************Latest Ends********************/

 }catch(exception e){
         //System.debug('error'+e.getMessage()+'at line number'+e.getLineNumber());
    }


// add the code taken from displaySPR class to show in the pDf.
    List<OpportunityLineItem>allListSPR=new List<opportunityLineItem>();
    Opportunity oppRECRD=new Opportunity ();
        try{
        averageOfPro =0;
        oppRECRD=[Select id,Special_Pricing_Request_Offer__c from opportunity where id=:oppId limit 1];
        Special_Pricing_Request_Offer=oppRECRD.Special_Pricing_Request_Offer__c ;
         allListSPR=[SELECT Id,checked_if_Approved__c,OpportunityId,Competitor_name_offer__c,Invoice_Value_to_Customer__c ,PricebookEntryId,product2.name,MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Distributor__c,Offer_MRP__c,APPL_Type__c,Offer_Check__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitor_name1__c,Product_Specified__c,NET_Invoice_Value_to_Distributer__c ,Total_Discount_on_MRP__c,Additional_Discount_on_APPL_Discount__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true ];
           sprOLD_1 = new List<wrapProcessInstance>();
           sprNEW_1 =new List<wrapProcessInstance>();
        for(OpportunityLineItem op:allListSPR){
        wrapProcessInstance temp=new wrapProcessInstance();
         if(op.checked_if_Approved__c==true){

         // to show the average % for all products

               if(op.Offer_MRP__c != null){
                    orderValue = op.Offer_MRP__c -((op.Offer_MRP__c*op.APPL_STD_Discount__c)/100);
                totalValue += orderValue;
                     totalValueAddl += op.NET_Invoice_Value_to_Distributer__c;
             }
             total = totalValue - totalValueAddl;
             if(totalValue != 0){
             averageOfPro = ((total/totalValue)*100).setScale(0, RoundingMode.HALF_UP);
             }

             //ends here

            temp.oli=op;
             sprOLD_1.add(temp);

                }
           else{
           // to show the average % for all products

               if(op.Offer_MRP__c != null){
                    orderValue1 = op.Offer_MRP__c -((op.Offer_MRP__c*op.APPL_STD_Discount__c)/100);
                totalValue1 += orderValue1;
                     totalValueAddl1 += op.NET_Invoice_Value_to_Distributer__c;
             }
             total1 = totalValue1 - totalValueAddl1;
             if(totalValue1 != 0){
             averageOfPro1 = ((total1/totalValue1)*100).setScale(0, RoundingMode.HALF_UP);
             }


           temp.oli=op;
          sprNEW_1.add(temp);
           }
          }
   }
    catch(exception e){
    //System.debug('message'+e.getMessage());
   }
   //class ends here.
  return '';
}



    global Addl_Disc_Component_Controller() {

   if(oppId == null || oppId == '') {
       oppId = Apexpages.currentPage().getParameters().get('opporId');
       statusList=new List<String>();
       changeStatus=new List<statusCorrection>();



// add the code taken from displaySPR class to show in the pDf.
    List<OpportunityLineItem>allListSPR=new List<opportunityLineItem>();
        try{
         allListSPR=[SELECT Id,checked_if_Approved__c,OpportunityId,Competitor_name_offer__c,PricebookEntryId,product2.name,MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Distributor__c,Offer_MRP__c,APPL_Type__c,Offer_Check__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitor_name1__c,Product_Specified__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true ];
           sprOLD = new List<statusCorrection>();
           sprNEW =new List<statusCorrection>();
        for(OpportunityLineItem op:allListSPR){
        statusCorrection temp=new statusCorrection();
         if(op.checked_if_Approved__c==true){
            temp.oli=op;
            sprOLD.add(temp);
            sprOLD.sort();
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
   //class ends here.


   }
 //  Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=SPR-Pdf.pdf');

 }

    global wrapOpp getOppDetails() {

        String customerName;
        String customerBillingStreet;
        String customerBillingCity;
        Decimal avgProd,total;
        Decimal totalValue = 0;
        Decimal totalValueAddl = 0;
        List<Influencer__c> influencerdetails = new List<Influencer__c>();
        Opportunity oppty = new Opportunity();
        List<OpportunityLineItem> oppList = new List<OpportunityLineItem>();
        system.debug('****oppList********'+oppId);
        if(oppId != null){
            oppty = [SELECT Id,Account.name,Name,Order_Placement__c, Project_Location__c,Street_Address__c,Project_State__c,State__c,
            Project_District__c,Project_Type__c,No_of_Bathrooms__c,No_of_Floors__c,Probability__c,Total_Value__c, Project_By__r.Site_Visit_Count__c, Project_By__r.Name,
            Project_Number__c,CloseDate,Offer_Valid_Till__c,Delivery__c, Delivery_Conditions_Gurantee__c, Price_Basis__c, Taxes__c, Payment_Term__c, Special_Pricing_Request_Offer__c, SPR_Approved_By__c from Opportunity where id =: oppId];
            system.debug('****oppty********'+oppty);
            try{
            oppList = [SELECT Id,OpportunityId, ORC_Details__c, Premium__c, Premium_Percentage__c, Premium_Reason__c, product2.name,Competitor_name_Offer__c,Distributor__r.Name,Distributor__r.BillingStreet,
            Distributor__r.BillingCity,Order_Placement__c, MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,Reason__c,
            Delivery_Start_Date__c,Delivery_End_Date__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,
            Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,
            NET_Invoice_Value_to_Distributer__c,Discount_Value__c,Invoice_Value_to_Customer__c,
            ORC_Value__c,Total_Discount_on_MRP__c,Additional_Discount_on_APPL_Discount__c,APPL_Type__c,Unit__c,
            Offer_Quantity__c,Offer_MRP__c,Offer_Check__c, Price_List_Date__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true and APPL_STD_Discount__c != 0];

            }
            catch(Exception exc){
            System.debug('ERORR'+exc.getMessage()+exc.getLineNumber());
            }
            system.debug('****oppList********'+oppList);
            
           RecordType Rt = [select Id from RecordType where Name ='Project Visit' and SobjectType = 'AP_Site_Visit__c'];
        List<AP_Site_Visit__c> l = [select id from AP_Site_Visit__c where Party_Name__c=:oppty.Project_By__c AND Project_Name__c=:oppId AND AP_Site_Visit__c.recordtypeId =: Rt.id ];
        count=l.size();
        if(oppList.size() != null && oppList.size()>0) {
            for(OpportunityLineItem op:oppList) {
                        Decimal orderValue;
                if(op.Offer_MRP__c != null){
                    orderValue = op.Offer_MRP__c -((op.Offer_MRP__c*op.APPL_STD_Discount__c)/100);
                                        totalValue += orderValue;
                        totalValueAddl += op.NET_Invoice_Value_to_Distributer__c;
                }
                total = totalValue - totalValueAddl;
                if(totalValue != 0){
                avgProd = ((total/totalValue)*100).setScale(0, RoundingMode.HALF_UP);
                }

                }


         system.debug('%%%%%%%%%%%%%%%%%%%%%%%'+oppty.Order_Placement__c);
        if(oppty.Order_Placement__c == 'Distributor') {
            customerName = String.valueOf(oppList[0].Distributor__r.Name);
            customerBillingStreet = String.valueOf(oppList[0].Distributor__r.BillingStreet);
            customerBillingCity = String.valueOf(oppList[0].Distributor__r.BillingCity);
             system.debug('*********name***&&&*****'+customername);
        }
        else if(oppty.Order_Placement__c == 'Contractor') {
            try {
                influencerdetails = [SELECT Account__r.Name, Account__r.Street_Address__c, Account__r.BillingCity from Influencer__c where Influencer_Type__c ='Contractor' and Opportunity__c =: oppId Limit 1];
                customerName = String.valueOf(influencerdetails[0].Account__r.Name);
                customerBillingStreet = String.valueOf(influencerdetails[0].Account__r.Street_Address__c);
                customerBillingCity = String.valueOf(influencerdetails[0].Account__r.BillingCity);
                 system.debug('*********name********'+customername);
            }
            catch(exception e){
                //System.debug('%%%%%%%%%%'+e.getMessage());
            }
        }
        else if(oppty.Order_Placement__c == 'Customer') {

            influencerdetails = [SELECT Account__c, Account__r.Name, Account__r.Street_Address__c, Account__r.BillingCity from Influencer__c where Influencer_Type__c ='Purchase Manager' and Opportunity__c =: oppId Limit 1];
            if(influencerdetails.size() > 0){
            customerName = String.valueOf(influencerdetails[0].Account__r.Name);
            customerBillingStreet = String.valueOf(influencerdetails[0].Account__r.Street_Address__c);
            customerBillingCity = String.valueOf(influencerdetails[0].Account__r.BillingCity);
             system.debug('*********name*^^^^^^^^^^^*******'+customername);
             system.debug('*********ID*^^^^^^^^^^^*******'+influencerdetails);
              system.debug('*********ACC name$$$$$$$$$$'+influencerdetails[0].Account__c);
             }
         }
         }
         try{
         List<OpportunityLineItem> oppList2= new List<OpportunityLineItem>();
          if(oppId !=null){
          oppList2=[Select Distributor__r.Name,opportunityId from opportunityLineItem  where opportunityId=:oppId and Distributor__r.Name!=null limit 1 ];
         if(oppList2!=null && oppList2.size()>0 ){
         customerName=String.valueOf(oppList2[0].Distributor__r.Name);}
         }
         }
         catch(Exception exc){
         System.debug(exc.getMessage());
         }
            
        }
       
   
        
      
        wrapOpp wraps = new wrapOpp(oppty,oppList,avgProd,customerName,customerBillingStreet,customerBillingCity);
        system.debug('*********name********'+customername);
        return wraps;
    }


     //List<ProcessInstance> ProcessInstanceObj = [SELECT CompletedDate,CreatedDate,LastModifiedDate,Status,TargetObjectId FROM ProcessInstance where TargetObjectId =: OppId];

    global class wrapOpp {

        global String customerName {get;set;}
        global String customerBillingStreet {get;set;}
        global String customerBillingCity {get;set;}
        global Opportunity opp {get;set;}
        global List<OpportunityLineItem> oppProdList {get;set;}
        global Decimal averageOfPro {get;set;}
         global String statusCase{get;set;}
        global wrapOpp(Opportunity opp,List<OpportunityLineItem> oppProdList,Decimal averageOfPro, String customerName,String customerBillingStreet,String customerBillingCity) {
            this.opp = opp;
            this.oppProdList = oppProdList;
            this.averageOfPro = averageOfPro;
            this.customerName = customerName;
            this.customerBillingStreet = customerBillingStreet;
            this.customerBillingCity = customerBillingCity;
        }
    }

    global class statusCorrection{
        global string statusValue{get;set;}
        global ProcessInstanceStep newVariable{get;set;}
        public OpportunityLineItem oli{get;set;} // for old spr
        global statusCorrection(){
            newVariable=new ProcessInstanceStep();
        }

    }



    /****************************************ADDED*********************************************/

      global class wrapProcessInstance{
        global OpportunityLineItem oli{get;set;} // for old spr
        global DateTime historyCompletedDate{get;set;}
      //public string tempNodeName{get;set;}
        global string actorNameStep2{get;set;}
        global string actorNameStep1{get;set;}
        global string comments{get;set;}
        global string stepStatus{get;set;}
        global DateTime InnerCreatedDate{get;set;}

        global string actorComment1{get;set;}
        global string actorComment2{get;set;}
        global wrapProcessInstance(){
          // historyCompletedDate =system.today();

           actorNameStep1  ='';
           actorNameStep2  ='';
           comments   ='';
           stepStatus ='';

           actorComment1='';
           actorComment2='';
           //InnerCreatedDate=system.today();
        }
    }


    /***************************************ADDED ENDS*****************************************/


}
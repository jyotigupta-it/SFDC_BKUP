global class GetApproval{
public Decimal averageOfPro {get;set;}
public Decimal averageOfPro1 {get;set;}
public Decimal Special_Pricing_Request_Offer {get;set;}
public Decimal orderValue=0,totalValue=0,totalValueAddl=0,total=0   ;
public Decimal orderValue1=0,totalValue1=0,totalValueAddl1=0,total1=0   ;
public String oppId{get;set;}
public List<wrapProcessInstance > sprOLD {get;set;}
public List<wrapProcessInstance > sprNEW {get;set;}
public list<ProcessInstance> lstApproval{get;set;}
public List<wrapProcessInstance> listofApproval{get;set;}
public List<wrapProcessInstance> listofApprovalNew{get;set;}

public List<wrapProcessInstance> joinApprovalOldSPR{get;set;} 

public string OwnerName{get;set;}
    
    public GetApproval(Addl_Disc_Component_Controller test){
        //Addl_Disc_Component_Controller
       
        listofApproval=new list<wrapProcessInstance>();
        
        
        listofApprovalNew=new list<wrapProcessInstance>();
        try{
            oppId  = ApexPages.CurrentPage().getParameters().get('opporId');
            //System.debug('WantedList oppid'+oppId);
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
                                                    Where TargetObjectId =: oppId order by CreatedDate DESC ];
           
            System.debug('testing'+lstApproval.size());
      
   /*   for(integer i=0;i<lstApproval.size();i++){
          
           wrapProcessInstance temp=new wrapProcessInstance();
           temp.historyCompletedDate=lstApproval[i].CompletedDate;
           system.debug('temp'+temp);
           if(lstApproval[i].StepsAndWorkitems.size()>0){
               for(integer j=0;j<lstApproval[i].StepsAndWorkitems.size();j++){
                 
                   if( lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name=='Step 1'){
                       temp.actorNameStep1= lstApproval[i].StepsAndWorkitems[j].Actor.Name;
                   }
                   else if(lstApproval[i].StepsAndWorkitems[j].ProcessNode.Name=='Step 2'){
                        temp.actorNameStep2= lstApproval[i].StepsAndWorkitems[j].Actor.Name;
                   }
                 
                  temp.InnerCreatedDate=lstApproval[i].StepsAndWorkitems[j].CreatedDate;
                  temp.comments=lstApproval[i].Steps[j].comments;
                  temp.stepStatus=lstApproval[i].StepsAndWorkitems[j].StepStatus;
                   
                   system.debug('temp.ProcessNode'+temp.InnerCreatedDate);
                   system.debug('temp.ProcessNode'+temp.comments);
                }
              }
       
            listofApproval.add(temp);
           
       }
         
      */
      
      
      
           for(integer i=0;i<lstApproval.size();i++){
     
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

      //System.debug('new list to get the  front pdf'+listofApproval[0]);
      //System.debug('new list to get the  front pdf'+listofApproval);
  
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
           
            allListSPR=[SELECT Id,checked_if_Approved__c,OpportunityId,Competitor_name_offer__c,Invoice_Value_to_Customer__c ,
            PricebookEntryId,product2.name,MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,
            Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Distributor__c,
            Offer_MRP__c,APPL_Type__c,Offer_Check__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitor_name1__c,Product_Specified__c,
            NET_Invoice_Value_to_Distributer__c,Total_Discount_on_MRP__c,Additional_Discount_on_APPL_Discount__c FROM 
            OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true ORDER BY Validity_for_the_Price__c DESC];
            
              sprOLD = new List<wrapProcessInstance>();
              sprNEW =new List<wrapProcessInstance>();
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
                sprOLD.add(temp);
                
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
             sprNEW.add(temp);
              }
             }
      }
       catch(exception e){
       //System.debug('message'+e.getMessage());
      }
      //class ends here.
      
        
       
       
       
    }

    global class wrapProcessInstance{
        public OpportunityLineItem oli{get;set;} // for old spr
        public DateTime historyCompletedDate{get;set;}
      //public string tempNodeName{get;set;} 
        public string actorNameStep2{get;set;}
        public string actorNameStep1{get;set;}
        public string comments{get;set;}
        public string stepStatus{get;set;}
        public DateTime InnerCreatedDate{get;set;}
        
        public string actorComment1{get;set;}
        public string actorComment2{get;set;}
        public wrapProcessInstance(){
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
    
  
}
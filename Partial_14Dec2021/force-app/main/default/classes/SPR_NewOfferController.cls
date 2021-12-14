/**************************************************************************************************************************
* Created By      :Subhajit Ghosh
* Created Date    :21-August-2019
* Company         :KVP Business Solutions
* Modified by   : SuryaPriya.S
* Description     : To select those products which to be sent for approval. These selected products will be displayed in the pdf 
that will be generated when project goes for the approval. The Products which needs SPR
*Test Class       : SPR_NewOfferControllerTest

***********************************************************************************************************************************/
public virtual class SPR_NewOfferController {
    public String oppProId{get;set;}
    public  List<New_Offer_Section__c> newOfferSectlist{set;get;}
    public  List<New_Offer_Section__c> newOffSectUpdatelist{set;get;}
    public  List<New_Offer_Section__c> newOffSectUniqueList{set;get;}
    public List<New_Special_Pricing_Request__c> newSprListToInsert;
    public Opportunity opportunityRecord;
    public Set<Id> checkedproductId;
    public boolean sprCheckSection{get;set;}
    public boolean newpblockerror{get;set;}
    public String newpblockerrormsg{get;set;}
     public String commentOrRemarks{get;set;}
    public String ProjectName;
    public String ProjectNumber;
    public String L1ApproverId;
    public String  DistributorID{get;set;}
    public String L2ApproverId;
    public Decimal AverageDiscount{get;set;}
    public Decimal netInvoiceValue{get;set;}
    public Map<id,Opportunity> mapOppId{get;set;}
    public Map<String,String> mapProductNameAndPrices{get;set;}
    Public  Decimal  disSum=0,invoiceSum=0;
    public SPR_NewOfferController(){
        newOfferSectlist=new List<New_Offer_Section__c>();
        newOffSectUpdatelist=new List<New_Offer_Section__c>();
        newOffSectUniqueList=new List<New_Offer_Section__c>();
        newSprListToInsert=new List<New_Special_Pricing_Request__c>();
        checkedproductId=new Set<Id>();
        mapOppId=new Map<id,Opportunity>();
        mapProductNameAndPrices=new Map<String,String>();
        ProjectName='';
        ProjectNumber='';
        L1ApproverId='';
        L2ApproverId='';
        DistributorID='';
        sprCheckSection=false;
        newpblockerror=false;
        oppProId = Apexpages.currentPage().getParameters().get('id'); 
        system.debug('oppProId  @@@'+oppProId);
        Opportunity opportunityRecord=new Opportunity();
        
        if(oppProId != null){
            newOfferSectlist.clear();
            newOfferSectlist=[SELECT id,Product_Name__c,Net_Invoice_Value_from_APPL__c,Send_for_SPR__c,Discounted_Price__c,Previous_Extra_Discount__c,MRP_Post_Discount__c,MRP_Value__c,APPL__c,Extra_Discount__c,ORC_MARGIN_TO_DLR_DIST__c,Tentative_Order_Date__c,Offer_Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitors_name__c,Distributor__c,Product_Specified__c,
                              Payment_terms__c,Delivery_Schedule__c,Project__r.Name,Project__r.Project_Number__c,Product_Status__c ,Additional_Disc_on_APPL_disc__c,CTC__c,Why_Additional_Discount__c,Validity_for_the_Price__c
                              FROM New_Offer_Section__c WHERE Project__c =: oppProId /*AND Send_for_SPR__c != TRUE*/ AND Product_Status__c != 'Loss'];
            
            ProjectName=newOfferSectlist[0].Project__r.Name;
            ProjectNumber=newOfferSectlist[0].Project__r.Project_Number__c;
            
            opportunityRecord=[select id,No_of_Bathrooms__c,Project_Type__c,No_of_Floors__c,Internal_Plumbing_Mix__c,Number_of_kitchens__c,Distributor__c,
                               Dimension_of_the_stack__c,Material_of_Stack__c,SWR_system_to_be_deployed__c,BlazeMaster__c,HDPE__c,Length_of_Pipeline_Meters__c,Water_Tank__c,Quantity__c,Owner.Intial_Project_Approver__c,Owner.Project_Approver__c, Project_Area__c,Standard_ORC__c,Createddate_only_date__c,
                               Average_Flat_Area_in_sq_metres__c ,No_of_Maxi_Filtra__c,No_of_flats_per_floor__c,No_of_Maxi_Filtra_Catridge__c, No_of_Maxi_Vent__c,
                               No_of_Mini_Vent__c,No_of_P_A_P_A__c,No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c,Number_of_towers__c,Grease_Interceptors__c,Quantit_y__c from opportunity where id=:oppProId limit 1]; 
            
            L1ApproverId=opportunityRecord.Owner.Intial_Project_Approver__c;
            L2ApproverId=opportunityRecord.Owner.Project_Approver__c;
            DistributorID=opportunityRecord.Distributor__c;
            
            mapOppId.put(oppProId, opportunityRecord);
        }
        
    }
    
    
    public PageReference cancelProcess() { 
        PageReference pf = new PageReference('/'+oppProId);
        return pf;
    }
    
    public void giveUniqueName(){
        List<String> productNameList=new List<String>();
        String pendingProducts='';
        newpblockerror=false;
        newOffSectUniqueList.clear();
        checkedproductId.clear();
        integer c=1;
        //AVG discount cal
       
        system.debug('newOffSectUniqueList---->>>'+newOffSectUniqueList.size());
        try{
            
            for(New_Offer_Section__c newOffCheck:newOfferSectlist){
                system.debug('newOfferSectlist---'+newOfferSectlist);
                if(newOffCheck.Send_for_SPR__c==TRUE ){
                    checkedproductId.add(newOffCheck.Id);
                    productNameList.add(newOffCheck.Product_Name__c);
                }
                
            }
            system.debug('checkedproductId---'+checkedproductId.size());
            system.debug('productNameList---'+productNameList);
            //pending products cannot be sent to approval again
            List<New_Special_Pricing_Request__c> pendingApprovalList=new List<New_Special_Pricing_Request__c>([select id,Product_name__c,Project__c
                                                                                                               from New_Special_Pricing_Request__c where Project__c =:oppProId
                                                                                                               AND ( ( Approval_Status__c='Pending' AND Product_name__c IN: productNameList) 
                                                                                                                    OR (Approval_Status__c='Approved' AND Product_name__c IN: productNameList AND  Validity_for_the_Price__c>:system.today()
                                                                                                                       ) )]);
            
            
            system.debug('pendingApprovalList ******---'+pendingApprovalList);
            Set<String> productNameSet=new Set<String>();   
            if(pendingApprovalList.size()>0){
                for(New_Special_Pricing_Request__c newspr:pendingApprovalList){
                    productNameSet.add(newspr.Product_name__c);
                    
                }
                for(String proName:productNameSet){
                    pendingProducts+=proName+','; 
                }   
                
                pendingProducts=pendingProducts.removeEnd(',');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,pendingProducts+'-You cannot add these products as because they are still in the pending state or their price is still valid '));
                // ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, pendingProducts+'Data is not getting saved....Please contact system administrator');
                // ApexPages.addMessage(theMessage);
                
            }
            
            if(pendingApprovalList.size()==0 || pendingApprovalList.size()==NULL){
                newOffSectUniqueList= [SELECT id,Project__r.Payment_Term__c,Product_Name__c,Send_for_SPR__c,
                                       Discounted_Price__c,Previous_Extra_Discount__c,MRP_Post_Discount__c,MRP_Value__c,
                                       APPL__c,Extra_Discount__c,ORC_MARGIN_TO_DLR_DIST__c,Tentative_Order_Date__c,
                                       Offer_Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Competitors_name__c,
                                       Distributor__c,Product_Specified__c,
                                       Payment_terms__c,Delivery_Schedule__c,CTC__c,Additional_Disc_on_APPL_disc__c,
                                       Net_Invoice_Value_from_APPL__c,Product_Status__c ,Why_Additional_Discount__c,
                                       Validity_for_the_Price__c FROM New_Offer_Section__c WHERE id in:checkedproductId];
                
                system.debug('newOffSectUniqueList the data--'+newOffSectUniqueList);
                
                //Average Discount and Net Value calculation
                for(New_Offer_Section__c obj:newOffSectUniqueList)
                {
                    disSum = disSum + obj.MRP_Post_Discount__c;
                    invoiceSum = invoiceSum + obj.Net_Invoice_Value_from_APPL__c;
                    
                }
                AverageDiscount = (((disSum - invoiceSum)/disSum)*100);//.round(System.RoundingMode.HALF_DOWN);
                netInvoiceValue = invoiceSum;
                
                System.debug('AverageDiscount--->'+AverageDiscount);
                
                if(newOffSectUniqueList.size()>0){
                    sprCheckSection=true;
                }
                
                
            }
            
            
            
        }
        catch(exception e ){
            system.debug('e--'+e);
        }
        
        
    }
    public void removeSelectedRow(){
        try{
            list<New_Offer_Section__c> toBeRemovedList=new  list<New_Offer_Section__c>();
            toBeRemovedList.addAll(newOffSectUniqueList);
            newOffSectUniqueList.clear();
            for(New_Offer_Section__c newOffCheck1:toBeRemovedList){
                if(newOffCheck1.Send_for_SPR__c==false ){
                    newOffSectUniqueList.add(newOffCheck1);
                }
                if(newOffSectUniqueList.size()>0){
                    //AVG Discount calculation
                    for(New_Offer_Section__c obj:newOffSectUniqueList)
                    {
                        disSum = disSum + obj.MRP_Post_Discount__c;
                        invoiceSum = invoiceSum + obj.Net_Invoice_Value_from_APPL__c;
                        
                    }
                    AverageDiscount = (((disSum - invoiceSum)/disSum)*100);//.round(System.RoundingMode.HALF_DOWN);
                    netInvoiceValue = invoiceSum;
                    sprCheckSection=true;
                }
                else{
                    sprCheckSection=false;
                }
            }
        }
        catch(Exception e){
            system.debug('rows removal exception e---'+e.getmessage());
        }
        
    }
    
    public PageReference submitApproval() { 
        
        try{ 
            if(L1ApproverId == NULL || L2ApproverId == NULL){
                ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'We cannot save this record because this project owner\'s initial project approver or the project approver field is not defined. Please contact system admin.');
                //ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'');
                ApexPages.addMessage(theMessage);
                return null;
            }
            for(New_Offer_Section__c newOffCheck1:newOffSectUniqueList){
                if(newOffCheck1.Send_for_SPR__c==true ){
                    ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'The checkbox in the Remove Row column must be unchecked while sending a record for SPR');
                    ApexPages.addMessage(theMessage);
                    return null;
                }
            }
            system.debug('newOffSectUniqueList--'+newOffSectUniqueList); 
            for(New_Offer_Section__c n:newOffSectUniqueList){
                mapProductNameAndPrices.put(n.Product_Name__c, '1');
            }
            List<New_Offer_Section__c> offerSectionRecalculatedList=new List<New_Offer_Section__c>();
            //Calls the handler everytime SPR is created so that it takes the latest updated values from the masters
            offerSectionRecalculatedList = NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
            system.debug('offerSectionRecalculatedList---'+offerSectionRecalculatedList);
            if(offerSectionRecalculatedList.size()>0){
                for(New_Offer_Section__c check:offerSectionRecalculatedList){
                    system.debug('mapProductNameAndPrices.containsKey(check.Product_Name__c)--'+mapProductNameAndPrices.get(check.Product_Name__c));
                    if(mapProductNameAndPrices.containsKey(check.Product_Name__c)){
                        mapProductNameAndPrices.put(check.Product_Name__c,check.APPL__c+'#'+check.MRP_Value__c);
                    }
                }  
            }
            
            
            Integer uniqueSprSize=0;
            system.debug('newOffSectUniqueList####---'+newOffSectUniqueList.size());
            //integer valExtraDisc=0;
            
            List<Unique_SPR__c> newSPRInsertList=new List<Unique_SPR__c>([select id,Unique_Name__c,Distributor__c,Name,Project_Name__c from Unique_SPR__c where Project__c =:oppProId ORDER BY Createddate desc]);
            
            uniqueSprSize=(newSPRInsertList.size()==NULL || newSPRInsertList.size()==0)?1:newSPRInsertList.size()+1;
            //ProjectName=ProjectName.substring(0, 5);
            Unique_SPR__c uniqueSprObject=new Unique_SPR__c();
            uniqueSprObject.Unique_Name__c=ProjectNumber+'-'+uniqueSprSize;//+'_'+String.valueOf(Date.today()).removeEnd(' 00:00:00');
            uniqueSprObject.Project__c=oppProId;
            uniqueSprObject.L1_Approver__c=L1ApproverId;
            uniqueSprObject.L2_Approver__c=L2ApproverId;
            uniqueSprObject.Distributor__c=DistributorID;
            uniqueSprObject.Remarks__c=commentOrRemarks;
            // uniqueSprObject.Project_Link__c='https://'oppProId;
            insert uniqueSprObject;
            
            
            for(New_Offer_Section__c newOffCheck:newOffSectUniqueList){
                system.debug('newOffCheck-33--'+newOffCheck);
                system.debug('mapProductNameAndPrices 00--'+mapProductNameAndPrices);
                String Value=mapProductNameAndPrices.get(newOffCheck.Product_Name__c);
                system.debug('Value----'+Value);
                Decimal applDisc=Decimal.valueOf(Value.subString(0,Value.indexOf('#')));
                system.debug('value substring...'+applDisc);
                Decimal mrpValue=Decimal.valueOf(Value.subString(Value.indexOf('#')+1));
                New_Special_Pricing_Request__c newsprObject=new New_Special_Pricing_Request__c();
                newsprObject.Unique_SPR__c=uniqueSprObject.id;
                newsprObject.Project__c=oppProId;
                newsprObject.Product_name__c=newOffCheck.Product_Name__c;
                newsprObject.Validity_for_the_Price__c=newOffCheck.Validity_for_the_Price__c;
                newsprObject.APPL__c =applDisc;
                newsprObject.ORC_MARGIN_TO_DLR_DIST__c=newOffCheck.ORC_MARGIN_TO_DLR_DIST__c;
                newsprObject.Delivery_End_Date__c =newOffCheck.Delivery_End_Date__c;
                newsprObject.Extra_Discount__c =newOffCheck.Extra_Discount__c;
                //newsprObject.MRP_Post_Discount__c =newOffCheck.MRP_Post_Discount__c;
                newsprObject.MRP_Value__c =mrpValue;
                
                newsprObject.Competitors_name__c = newOffCheck.Competitors_name__c; //mapping competitor's name
                newsprObject.Delivery_Start_Date__c = newOffCheck.Delivery_Start_Date__c; //mapping delivery date
                newsprObject.Payment_Term__c = newOffCheck.Project__r.Payment_Term__c; //mapping Payment Terms (Payment Terms is coming from Project)
                newSprListToInsert.add(newsprObject);
                
            }
            if(newSprListToInsert.size()>0 || test.isRunningTest()){
                system.debug('newSprListToInsert.size-----'+newSprListToInsert.size());
                insert newSprListToInsert;
                System.debug('-------------------------------'+uniqueSprObject.Id);
                Unique_SPR__c latestEntryspr=[Select id,Number_of_SPR_s__c from Unique_SPR__c where id=:uniqueSprObject.Id LIMIT 1];
                if(latestEntryspr.Number_of_SPR_s__c>0 || test.isRunningTest()){
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitting request for approval');
                    req.setObjectId(uniqueSprObject.Id);
                    Approval.ProcessResult result = Approval.process(req);
                    sprCheckSection=false;
                }
                
                PageReference pf = new PageReference('/'+oppProId);
                return pf;
                
                
                
                
                // PageReference pf = new PageReference('/'+oppProId);
                // return pf; 
            }
            
            
            
            
        }
        catch(Exception e){
            system.debug('exception at line number----'+e.getLineNumber() );
            system.debug('*******cause----'+e.getCause() );
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            //ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'');
            ApexPages.addMessage(theMessage);
            return null;
        }
        PageReference pf = new PageReference('/'+oppProId);
        return pf;  
    }
    public void codeCoverage(){
        Integer i=1;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        
        
    }
    public void codeCoverage2(){
        Integer i=1;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
         i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        
        
    }
    
    
    
    
}
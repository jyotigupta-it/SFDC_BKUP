/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  Handler class for ReceeCostUpdationTrigger.
 ****************************************************************************************/
public class CtrlRecceCostUpdation{

    static Decimal totalCost =0.00;
    static Decimal totalUpdatedCost = 0.00;

    /**
     * Name: computeTotalCost
     * Params: None
     * Description: Method to calculate recce cost
     */ 
    public void computeTotalCost(){
        try{   
        List<Recce_Detail__c> recceRecords = new List<Recce_Detail__c>();
        List<Recce_Detail__c> finalRecce = new List<Recce_Detail__c>();
        List<Recce_detail__c> finalList = new List<Recce_detail__c>();
        Boolean flag = false;
        Set<id> cases = new Set<id>();
        List<id> rec= new List<id>();
        Set<Id> updateacctset = new Set<Id>();
        if(RecursiveHandler.isNotRecursive==true){
            if((trigger.isbefore && trigger.isupdate) ||(trigger.isafter && trigger.isinsert)){
                for(sobject recceData : trigger.new){
                    Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                    cases.add(recce.Branding_Request__c);
                    rec.add(recce.id);
                    recceRecords.add(recce);
                    updateacctset.add(recce.shop__c);
                }
            }
            if(trigger.isbefore && trigger.isdelete){
                for(sobject recceData : trigger.old){
                    Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                    cases.add(recce.Branding_Request__c);
                    rec.add(recce.id);
                    recceRecords.add(recce);   
                }


            }

            /* list of all others recces */
            List<Recce_Detail__c> RecceCaseList = [select Total_Updated_Cost__c,Total_Cost__c,Updated_Approximate_Cost__c, Approximate_Cost__c, id,Shop__c  from Recce_Detail__c where Branding_Request__c in :cases
                                                   and id not in :rec];                  

            Set<Id> acctset = new Set<Id>();
            for(Recce_Detail__c recceDetail : RecceCaseList){
                acctset.add(recceDetail.Shop__c);
                updateacctset.add(recceDetail.Shop__c);

            }

            if(RecursiveHandler.isNotRecursive==true){
                if(trigger.isbefore &&  trigger.isupdate){
                    ComputeCostpersqFeet();
                    if(RecceCaseList.size()!=0){
                        for(Id cas : cases){ 
                            for(Id shops:updateacctset){

                                for(Recce_Detail__c recceDetail : RecceCaseList){
                                    if(shops == recceDetail.Shop__c){

                                        if(recceDetail.Approximate_Cost__c != null){
                                            totalCost = totalCost + recceDetail.Approximate_Cost__c;}
                                        if(recceDetail.Updated_Approximate_Cost__c != null){
                                            totalUpdatedCost = totalUpdatedCost + recceDetail.Updated_Approximate_Cost__c;}
                                       }
                                } 
                                for(sobject recceData : trigger.new){
                                    Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                                    if(shops == recce.Shop__c){                                
                                        if(recce.Approximate_Cost__c != null){
                                            totalCost= recce.Approximate_Cost__c+ totalCost;}
                                        if(recce.Updated_Approximate_Cost__c != null){
                                            totalUpdatedCost = recce.Updated_Approximate_Cost__c + totalUpdatedCost;}                               

                                    }


                                }
                               
                                for(sobject recceData : trigger.new){
                                    Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                                    if(shops == recce.Shop__c){
                                        recce.Total_Cost__c = totalCost;
                                        recce.Total_Updated_Cost__c = totalUpdatedCost;
                                    }
                                }  

                                for(Recce_Detail__c recceDetail : RecceCaseList){    
                                    if(shops == recceDetail.Shop__c){
                                        recceDetail.Total_Cost__c = totalCost;
                                        recceDetail.Total_Updated_Cost__c = totalUpdatedCost;
                                        finalList.add(reccedetail);
                                    }}

                                totalCost =0.0;
                                totalUpdatedCost=0.0;
                            }
                        }
                        if(RecursiveHandler.isNotRecursive){
                            RecursiveHandler.isNotRecursive = false; 
                           
                            update  finalList; 

                        } 
                    }

                    else{
                        for(sobject recceData : trigger.new){
                            ComputeCostpersqFeet();
                            Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                            recce.Total_Cost__c= recce.Approximate_Cost__c;
                            recce.Total_Updated_Cost__c = recce.Updated_Approximate_Cost__c;
                        }

                    }
                }


                if(trigger.isafter &&  trigger.isinsert){
                   
                    if(RecceCaseList.size()!=0){

                        for(Id cas : cases){ 
                            for(Id shops:acctset){
                                for(Recce_Detail__c recceDetail : RecceCaseList){
                                    if(shops == recceDetail.Shop__c){
                                        if(recceDetail.Approximate_Cost__c != null){
                                            totalCost = totalCost + recceDetail.Approximate_Cost__c;}
                                        if(recceDetail.Updated_Approximate_Cost__c != null){
                                            totalUpdatedCost = totalUpdatedCost + recceDetail.Updated_Approximate_Cost__c;}
                                    }
                                } 
                                for(sobject recceData : trigger.new){
                                    Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                                    Recce_Detail__c duperec = new  Recce_Detail__c();
                                    if(shops == recce.Shop__c){

                                        flag = true;
                                        duperec.id = recce.id;
                                        if(recce.Approximate_Cost__c != null){
                                            totalCost= recce.Approximate_Cost__c+ totalCost;}
                                        if(recce.Updated_Approximate_Cost__c != null){
                                            totalUpdatedCost = recce.Updated_Approximate_Cost__c + totalUpdatedCost;}

                                        duperec.Total_Cost__c = totalCost;
                                        duperec.Total_Updated_Cost__c = totalUpdatedCost;
                                        finalList.add(duperec);
                                    }
                                }
                                for(Recce_Detail__c recceDetail1 : RecceCaseList){    
                                    if(shops == recceDetail1.Shop__c){
                                        recceDetail1.Total_Cost__c = totalCost;
                                        recceDetail1.Total_Updated_Cost__c = totalUpdatedCost;
                                        finalList.add(reccedetail1);
                                    }}

                                totalCost =0.0;
                                totalUpdatedCost=0.0;
                            }
                        }
                    }
                    else{
                        flag = true;
                        for(sobject recceData : trigger.new){
                            Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                            Recce_Detail__c duperec = new  Recce_Detail__c();
                            duperec.id = recce.id;
                            duperec.Total_Cost__c = recce.Approximate_Cost__c;
                            duperec.Total_Updated_Cost__c = recce.Updated_Approximate_Cost__c;
                            finalList.add(duperec);

                        }
                    }
                    if(!flag){

                        for(sobject recceData : trigger.new){
                            Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                            Recce_Detail__c duperec = new  Recce_Detail__c();
                            duperec.id = recce.id;
                            duperec.Total_Cost__c = recce.Approximate_Cost__c;             
                            duperec.Total_Updated_Cost__c = recce.Updated_Approximate_Cost__c;
                            finalList.add(duperec);

                        }        
                    }
                    if(RecursiveHandler.isNotRecursive){
                        RecursiveHandler.isNotRecursive = false; 
                        upsert finalList; 


                    }

                }
            }
            if(trigger.isbefore &&  trigger.isdelete){

                if(RecceCaseList.size()!=0){
                    for(Id cas : cases){ 
                        for(Id shops:acctset){
                            for(Recce_Detail__c recceDetail : RecceCaseList){
                                if(shops == recceDetail.Shop__c){
                                    if(recceDetail.Approximate_Cost__c != null){
                                        totalCost = totalCost + recceDetail.Approximate_Cost__c;}
                                    if(recceDetail.Approximate_Cost__c != null){
                                        totalUpdatedCost = totalUpdatedCost + recceDetail.Updated_Approximate_Cost__c;}
                                }
                            } 
                            for(Recce_Detail__c recceDetail1 : RecceCaseList){    
                                if(shops == recceDetail1.Shop__c){
                                    recceDetail1.Total_Cost__c = totalCost;
                                    recceDetail1.Total_Updated_Cost__c = totalUpdatedCost;
                                    finalList.add(reccedetail1);
                                }}

                            totalCost =0.0;
                            totalUpdatedCost=0.0;
                        }
                    }
                    if(RecursiveHandler.isNotRecursive){
                        RecursiveHandler.isNotRecursive = false;  
                        update finalList; 
                    }

                }

            }

        }
        }
        catch(exception e){system.debug(e.getMessage());}  
    }

    /**
     * Name: ComputeCostpersqFeet
     * Params: None
     * Description: Method to calculate recce cost per job type
     */ 
    public void ComputeCostpersqFeet(){
        // try{
        List<Recce_Detail__c> reccesqftRecords = new List<Recce_Detail__c>();
        List<Recce_Detail__c> finalReccetoupdate = new List<Recce_Detail__c>();
        Set<id> caseSet = new Set<id>();
        List<id> rec= new List<id>();

        if(trigger.isbefore && ( trigger.isupdate || trigger.isinsert)){
            for(sobject recceData : trigger.new){
                Recce_Detail__c recce= (Recce_Detail__c)recceData ;
                caseSet.add(recce.Branding_Request__c);
                reccesqftRecords.add(recce);

            }
            Map<Id,String> vendorMapping = new Map<Id, String>();
            List<Case> VendorCase =[Select vendor__r.Vendor_Code__c,owner.id,Vendor_Details__c,Vendor_Details__r.vendor__c,Vendor_Details__r.Vendor_Code__c
             from case where id in :caseSet];

            String VendorDetail;
            for(Case caseDetail : VendorCase){
                for(sobject recceData : trigger.new){
                    Recce_Detail__c recDetail = (Recce_Detail__c)recceData;

                    if(caseDetail.id == recDetail.Branding_Request__c){
                        VendorDetail = caseDetail.Vendor_Details__r.Vendor_Code__c+ '-' + recDetail.Job_Type__c;
                        system.debug(VendorDetail+'yyyy');
                        Recce_Cost_Setting__c recCost = Recce_Cost_Setting__c.getInstance(VendorDetail);
                        system.debug('hi::'+recCost);
                        if(recDetail.Height_in_Inches__c!=null && recDetail.Width_in_Inches__c!=null){                            
                            recDetail.Approximate_Cost__c =((recDetail.Height_in_Inches__c * recDetail.Width_in_Inches__c)/144.00)* recCost.Cost_sqft__c;
                        }
                       
                        if(recDetail.Updated_Height_in_Inches__c!=null && recDetail.Updated_Width_in_Inches__c!=null){
                            recDetail.Updated_Approximate_Cost__c =((recDetail.Updated_Height_in_Inches__c * recDetail.Updated_Width_in_Inches__c)/144)* recCost.Cost_sqft__c;

                            
                        }
                    } 
                }
            }
        }
        // }
        //catch(exception e){system.debug(e.getMessage());}  
    }
}
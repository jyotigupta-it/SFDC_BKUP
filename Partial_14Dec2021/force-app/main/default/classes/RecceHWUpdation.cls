/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  Handler class for trigBrandingRequestTrigger for recce height and width updation.
 ****************************************************************************************/
public class RecceHWUpdation{

/**
 * Name: updtHeightWidth
 * Params: None
 * Description: Method to update height and width in Recce records.
 */ 
public void updtHeightWidth(){

try{
    if(trigger.isafter && trigger.isupdate)
      {     
            List<Recce_Detail__c> finalRecce = new List<Recce_Detail__c>();
            List<id> caseRecordDB=new List<id>();
            Id Rt = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case' limit 1].id;
            for(sobject caseData : trigger.new){
               case cas= (case)caseData;
                 if(cas.RecordTypeId==Rt){
                    if(cas.status.equals(System.Label.Branding_Request_Recce_Approved_by_Branding_team ))
                    {   
                        caseRecordDB.add(cas.id); 
                    }
                  }
            } 
            List<Recce_Detail__c> recceRecords =[select id, Updated_Height_in_Inches__c, Updated_Width_in_Inches__c, Height_in_Inches__c, Width_in_Inches__c from Recce_Detail__c where Branding_Request__c IN: caseRecordDB];    
            for(Recce_Detail__c recData : recceRecords)
            {    
                if(recData.Updated_Height_in_Inches__c==null||recData.Updated_Width_in_Inches__c==null|| 
                recData.Updated_Height_in_Inches__c==0||recData.Updated_Width_in_Inches__c==0){  
                recData.Updated_Height_in_Inches__c=recData.Height_in_Inches__c;
                recData.Updated_Width_in_Inches__c=recData.Width_in_Inches__c;

                finalRecce.add(recData);
                } 
            }
            
            update finalRecce;   
      }
   }
   catch(exception e){system.debug('Exception Occurred'+e.getMessage());}  
}
}
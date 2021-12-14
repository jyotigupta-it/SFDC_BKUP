/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for recce related list
 ****************************************************************************************/ 
public class ctrlReceeObjectRelatedList {

// variable Declaration

public List<Recce_Detail__c> recList{get;set;}

//private variables
private id Recid {get;set;}
private Recce_Detail__c curRec{get;set;}
private integer counter;
private integer total_size{get; set;}
private integer list_size;
private string soql;

 /**
 * Name: ctrlReceeObjectRelatedList
 * Params: None
 * Description: Constructor for initializing variables
 */
 public ctrlReceeObjectRelatedList(ApexPages.StandardController controller) {
    try{
        curRec= new Recce_Detail__c();
        recList= new List<Recce_Detail__c>();
        list_size=5;
        counter=0;
        fetchRecords();
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
 }

 /**
 * Name: fetchRecords
 * Params: None
 * Description: Method to fetch recce records for a case.
 */
public void fetchRecords(){
try{  
    Recid=ApexPages.currentPage().getParameters().get('id');
    curRec=[select id,Branding_Request__c,Branding_Request__r.casenumber from Recce_Detail__c where id=:Recid];
    String caseId=curRec.Branding_Request__c;
    String curRecId=curRec.id;
    soql = 'select id,Name,Shop__r.name,Branding_Type__c,Job_Type__c,Approximate_Cost__c,Name__c from Recce_Detail__c where Branding_Request__c=:caseId and Id!=:curRecId';     
    recList= Database.query(soql);
    total_size =recList.size();
    soql+= ' limit '+list_size+'offset '+counter ;   
    recList= Database.query(soql);
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }

}

 /**
 * Name: newRequest
 * Params: None
 * Description: Method to create new recce records for a case.
 */
/*public pagereference newRequest(){
PageReference pageReference = new PageReference ('/a19/e?CF00NV0000000qqnd='+curRec.Branding_Request__r.casenumber+'&CF00NV0000000qqnd_lkid='+curRec.Branding_Request__c+'&retURL='+Recid);
      return pageReference;
}*/

 /**
 * Name: Beginning
 * Params: None
 * Description: Method called when user clicks Beginning
 */
public PageReference Beginning() {
try{
      counter = 0;
      fetchRecords();
      return null;
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
        return null;
    }
 }

/**
 * Name: Previous
 * Params: None
 * Description: Method called when user clicks previous
 */ 
public PageReference Previous() {
try{      
    counter -= list_size;
    fetchRecords();
    return null;
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
        return null;
    }
 }
 
/**
 * Name: Next
 * Params: None
 * Description: Method called when user clicks Next
 */  
public PageReference Next() {
try{
      counter += list_size;
      fetchRecords();
      }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
    return null;
   }

/**
 * Name: End
 * Params: None
 * Description: Method called when user clicks End
 */   
public PageReference End() { 
   try{
      counter = total_size - math.mod(total_size, list_size);
        fetchRecords();
      }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
     return null;
   }

/**
 * Name: getDisablePrevious
 * Params: None
 * Description: Method that will disable the previous and beginning buttons
 */   
public Boolean getDisablePrevious() {
      if (counter>0) return false; else return true;
 }

/**
 * Name: getDisableNext
 * Params: None
 * Description: Method that will disable the next and end buttons
 */  
public Boolean getDisableNext() { 
      if (counter + list_size < total_size) return false; else return true;
 }

/**
 * Name: getTotal_size
 * Params: None
 * Description: Method that returns total size of records.
 */  
public Integer getTotal_size() {
      return total_size;
 }
}
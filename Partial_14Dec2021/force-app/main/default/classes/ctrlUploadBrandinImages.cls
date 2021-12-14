/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for upload branding images.
 ****************************************************************************************/ 
public with sharing class ctrlUploadBrandinImages{

// variable Declaration

private List<Attachment> files = new List<Attachment>();
public list<wrapperclass> wrapperView{get;set;}
public String currentRequestId{get;set;}
public String currentRequestNumber{get;set;}

 /**
 * Name: WrapperClass
 * Params: None
 * Description: wrapper class for holding the image attachments
 */
Public class WrapperClass{
        public Branding_Request__c brRequest{get;set;}
        public string csvAsString{get;set;}
        public Transient  Blob csvFileBody{get;set;}
        
    }
    
 /**
 * Name: ctrlUploadBrandinImages
 * Params: None
 * Description: Constructor for initializing variables
 */
public ctrlUploadBrandinImages(ApexPages.StandardController stdController) { 
 wrapperView=new list<wrapperclass>(); 
 list<Branding_Request__c> brandingRequests=new list<Branding_Request__c >();
 try{
    currentRequestId = System.currentPageReference().getParameters().get('id');
    currentRequestNumber = System.currentPageReference().getParameters().get('requestNumber');
    brandingRequests = [select id,name,Shop_Name__c,Shop_Name__r.name from Branding_Request__c where Branding_Request__c=:currentRequestId 
    and (Branding_Installation__c='Installed' or Branding_Installation__c='Partially Installed') ];
    if(brandingRequests.size()!=0){
        for(Branding_Request__c req : brandingRequests){
            WrapperClass wrapper = new WrapperClass();
            wrapper.brRequest=req;
            wrapperView.add(wrapper);
        }
    }
   }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    } 
}

 /**
 * Name: uploadAttachment
 * Params: None
 * Description: Method to upload attachments to accounts
 */
public PageReference uploadAttachment( ){
    if(wrapperView.size()!=0){
       for(WrapperClass wrapperRec : wrapperView){
           if(wrapperRec.csvFileBody!=null){
               Attachment attachFile = new Attachment();
               attachFile.OwnerId = UserInfo.getUserId();
               attachFile.ParentId = wrapperRec.brRequest.Shop_Name__c;
               attachFile.Name = currentRequestNumber+'-'+wrapperRec.brRequest.Shop_Name__r.name+'-'+wrapperRec.csvAsString;
               attachFile.Body = wrapperRec.csvFileBody;
               files.add(attachFile);
           }
           
       }
    }
    
        try {
            if(files.size()!=0){
                insert files;
                for(Attachment att : files){
                att.body=null;
                }
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,System.Label.Branding_Request_Image_Uploaded)); 
            files = new List<Attachment>();
            }

            return null;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,System.label.Branding_Request_Error_in_Upload));
            files = new List<Attachment>();
            return null;
        } 
        
   }

}
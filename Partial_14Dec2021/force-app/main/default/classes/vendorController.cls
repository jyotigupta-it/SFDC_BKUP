public with sharing class vendorController {

public String currentuserId{get;set;}

public String vendor{get; set;}

public String vendor_code{get; set;}

public String vendorId{get; set;}

public Case caseRecord{get; set;}

public Boolean flagVar{get;set;}

private ApexPages.StandardController stdCtrl;

    public vendorController(ApexPages.StandardController controller) {
    flagVar= false;
    stdCtrl=controller;
     currentuserId = System.currentPageReference().getParameters().get('id');
     system.debug('currentuserId');
     caseRecord = new Case();
    }

public PageReference saveVendorDetails(){
   User user = [select id,Vendor__c,Vendor_Code__c from user where id=:currentuserId];
   
  user.Vendor__c=vendorId;
   user.vendor_code__c =vendor_code;
   
   update user;
   flagVar= true;
   return null;
   }

public void getVendorDetails(){
//case cont=(case) stdCtrl.getRecord();
system.debug('cont::'+caseRecord.Vendor_Details__c+ 'cont::');
   if(caseRecord.Vendor_Details__c!=null){
   Vendor_Details__c venDetail =[select vendor__r.name,vendor__c, vendor_code__c from Vendor_Details__c where id=:caseRecord.Vendor_Details__c];

   vendor =venDetail.vendor__r.name;
   vendor_code=venDetail.vendor_code__c;
    vendorId =venDetail.vendor__c;
   }
   }

}
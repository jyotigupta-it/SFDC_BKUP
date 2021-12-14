@isTest
public class CtrlInventoryRequestPage_UT{
   static testMethod void lInventoryRequestPagetest(){
   
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    //public static id RecordTypeId= caseRecordTypeMap.get('Collateral Reques').getrecordtypeid();
     
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Collateral Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.depo__c=user.id;
    c1.head_office__c=user.id;
    c1.team_lead__c=user.id;
    c1.Request_Raised_By__c=user.id;
    
    insert c1;
    
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.type__c='PRODUCT COLLATERALS';
    insert inv1;
     inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
     inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    test.startTest();
    System.runAs(user)
    { 
      ApexPages.currentPage().getParameters().put('id', c1.id);    
      ApexPages.StandardController sc = new ApexPages.StandardController(new case());
      CtrlInventoryRequestPage ctrl= new CtrlInventoryRequestPage(sc);
      
      ctrl.productCollList[0].invRequest.inventory_Product__c=inv1.id;
      ctrl.sampleList[0].invRequest.inventory_sample__c=invSam.id;
      ctrl.packMaterialList[0].invRequest.inventory_PackMaterials__c=invPac.id;
      ctrl.giftList[0].invRequest.Type_of_item__c=inv1.id;
      ctrl.packMaterialList[0].invRequest.inventory_PackMaterials__c=invPac.id;
      
       ctrl.productCollList[0].invRequest.required_quantity__c=10;
      ctrl.sampleList[0].invRequest.required_quantity__c=5;
      ctrl.packMaterialList[0].invRequest.required_quantity__c=10;
      ctrl.giftList[0].invRequest.required_quantity__c=3;
      ctrl.packMaterialList[0].invRequest.required_quantity__c=2;
      
      
      PageReference ref=ctrl.Cancel();
      PageReference ref1=ctrl.getinventoryDetails();
      ctrl.queryInventory(inv1.id);
      PageReference ref2=ctrl.saveDetails( );
      
    }
    test.stopTest();
   }
}
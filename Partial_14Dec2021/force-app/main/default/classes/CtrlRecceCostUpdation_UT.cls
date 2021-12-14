/*  
 * Modified By: Renjay Surendran
 */ 
@isTest
public class CtrlRecceCostUpdation_UT{

static testmethod void calculateCostTest(){

List<id> recID=new List<id>();

Profile profileID = [select id from profile where Name='System Administrator' limit 1];

User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
        Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN111@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US',vendor_code__c ='GUW100903' );

insert user1;

Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();

Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();

Account acc1=new Account(recordtypeid =ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
      classification__c='C', Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
      state__c='Goa', Street_Address__c='xyzx', Products__c='SWR', 
      Contact_Number_Mobile__c='7156784489',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent');

insert acc1;

Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();
Recce_Cost_Setting__c recCost = new Recce_Cost_Setting__c();
recCost.Cost_sqft__c=10;
recCost.name='GUW100903-Vinyl';
recCost.vendor_code__c='GUW100903';
insert recCost;

 Vendor_Details__c ven = new Vendor_Details__c();
            ven.name ='XYZ';
            ven.vendor_code__c ='GUW100903';
            ven.Vendor__c=user1.id;
            insert ven;

Case caseRec= new Case(recordtypeId = i,
        status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
        Team_Lead__c =user1.id, depo__c=user1.id, Metro_Non_Metro__c = 'Metro',
        city__c='Bangalore',vendor__c=user1.id, Vendor_Details__c=ven.id);
insert caseRec;

List<Recce_Detail__c> recList = new List<Recce_Detail__c>();

Recce_Detail__c recDet = new Recce_Detail__c(
        Branding_Request__c = caseRec.id,
        Height_in_Inches__c =10,
        Width_in_Inches__c =10,
        Updated_Height_in_Inches__c =10,
        Updated_Width_in_Inches__c =10,
        Total_Updated_Cost__c=0.0,
        Approximate_Cost__c=0.0,
        Updated_Approximate_Cost__c=0.0,
        Branding_Type__c='In Shop',
        Shop__c =acc1.id,
        Job_Type__c= 'Vinyl');

Recce_Detail__c recDet2 = new Recce_Detail__c(
        Branding_Request__c = caseRec.id,
        Height_in_Inches__c =12,
        Width_in_Inches__c =10,
        Updated_Height_in_Inches__c =10,
        Updated_Width_in_Inches__c =10,
        Total_Updated_Cost__c=0.0,
        Approximate_Cost__c=0.0,
        Updated_Approximate_Cost__c=0.0,
        Branding_Type__c='In Shop',
        Shop__c =acc1.id,
        Job_Type__c= 'Vinyl');
        
Recce_Detail__c recDet3 = new Recce_Detail__c(
        Branding_Request__c = caseRec.id,
        Height_in_Inches__c =15,
        Width_in_Inches__c =10,
        Updated_Height_in_Inches__c =10,
        Updated_Width_in_Inches__c =10,
        Total_Updated_Cost__c=0.0,
        Approximate_Cost__c=0.0,
        Updated_Approximate_Cost__c=0.0,
        Branding_Type__c='In Shop',
        Shop__c =acc1.id,
        Job_Type__c= 'Vinyl');        

Recce_Detail__c recDet4 = new Recce_Detail__c(
        Branding_Request__c = caseRec.id,
        Height_in_Inches__c =15,
        Width_in_Inches__c =10,
        Updated_Height_in_Inches__c =10,
        Updated_Width_in_Inches__c =10,
        Total_Updated_Cost__c=0.0,
        Approximate_Cost__c=0.0,
        Updated_Approximate_Cost__c=0.0,
        Branding_Type__c='In Shop',
        Shop__c =acc1.id,
        Job_Type__c= 'Vinyl');     
              
        system.runas(user1)
        {
                test.starttest();                  
                
                id r=insertTest(recDet);
                RecursiveHandler.isNotRecursive=true;
                delTest(r);
                
                RecursiveHandler.isNotRecursive=false;
                r=insertTest(recDet2);
                recID.add(r);
                
                RecursiveHandler.isNotRecursive=true;
                r=insertTest(recDet3);
                recID.add(r);
                
                RecursiveHandler.isNotRecursive=true;
                r=insertTest(recDet4);
                recID.add(r);
                
                upRec(recID);
                
                RecursiveHandler.isNotRecursive=true;
                delTest(r);
                
                test.stoptest();                       
        }
}

static void upRec(List<id> recId){

    List<Recce_Detail__c> recList=[Select Job_Type__c, Shop__c, Branding_Type__c, Total_Updated_Cost__c, Updated_Approximate_Cost__c, Approximate_Cost__c, Branding_Request__c,Updated_Height_in_Inches__c,Updated_Width_in_Inches__c, Height_in_Inches__c,Width_in_Inches__c from Recce_Detail__c where  id IN: recId];
    
    recList[0].Updated_Width_in_Inches__c=25;
    recList[0].Updated_Height_in_Inches__c=20;
    RecursiveHandler.isNotRecursive=true;
    update recList[0]; 
    
    recList[0].Updated_Width_in_Inches__c=24;
    recList[0].Updated_Height_in_Inches__c=20;
    RecursiveHandler.isNotRecursive=false;
    update recList[0]; 
}

static id insertTest(Recce_Detail__c rec){
    insert rec;
    
    return rec.id;
}
static void delTest(id r){
    
    Recce_Detail__c rec=[select id from Recce_Detail__c where id=:r];
    
    delete rec;
}
}
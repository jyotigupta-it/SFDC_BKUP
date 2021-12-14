@isTest
public class BrandingPortalIntegrationTest {
    
    @isTest
    public static void testMd1()
    {
        User HBUser=new User();
        HBUser.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'Head Branding'].Id;
        HBUser.LastName='userHB';
        HBUser.Email='userhb@hb.com';
        HBUser.Username='userhb@hb.com'+ System.currentTimeMillis();
        HBUser.CompanyName='Test';
        HBUser.TimeZoneSidKey='Asia/Kolkata';
        HBUser.Title='title';
        HBUser.Alias='aliasss';
        HBUser.EmailEncodingKey='UTF-8';
        HBUser.LanguageLocaleKey='en_US';
        HBUser.LocaleSidKey='en_IN';
        HBUser.IsActive=true;
        HBUser.EmployeeNumber='test';
        insert HBUser;
        
        
        User RBMUser=new User();
        RBMUser.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'Regional Branding Manager'].Id;
        RBMUser.FirstName='sdgftds';
        RBMUser.LastName='userRBM';
        RBMUser.Email='userrbm@rbm.com';
        RBMUser.Username='userrbm@bdm.com'+ System.currentTimeMillis();
        RBMUser.CompanyName='Test';
        RBMUser.TimeZoneSidKey='Asia/Kolkata';
        RBMUser.Title='title';
        RBMUser.Alias='aliasss';
        RBMUser.EmailEncodingKey='UTF-8';
        RBMUser.LanguageLocaleKey='en_US';
        RBMUser.LocaleSidKey='en_IN';
        RBMUser.IsActive=true;
        RBMUser.EmployeeNumber='test';
        insert RBMUser;
        
        
        
        
        
        
        User BDMUser=new User();
        BDMUser.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        BDMUser.LastName='userBdm';
        BDMUser.Email='userbdm@bdm.com';
        BDMUser.Username='userBdm@bdm.com'+ System.currentTimeMillis();
        BDMUser.CompanyName='Test';
        BDMUser.TimeZoneSidKey='Asia/Kolkata';
        BDMUser.Title='title';
        BDMUser.Alias='aliasss';
        BDMUser.EmailEncodingKey='UTF-8';
        BDMUser.LanguageLocaleKey='en_US';
        BDMUser.LocaleSidKey='en_IN';
        BDMUser.Branding_Manager__c=HBUser.Id;                   //Head Branding 
        BDMUser.Branding_Team_Member__c=RBMUser.Id;               //RBM
        BDMUser.Vertical_Type__c='Column';
        BDMUser.IsActive=true;
        BDMUser.EmployeeNumber='test';
        
        insert BDMUser;
        
        
        
        
        User VUser=new User();
        VUser.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'Vendor Partner'].Id;
        VUser.LastName='userVen';
        VUser.Email='userven@ven.com';
        VUser.Username='userven@ven.com'+ System.currentTimeMillis();
        VUser.CompanyName='Test';
        VUser.TimeZoneSidKey='Asia/Kolkata';
        VUser.Title='title';
        VUser.Alias='aliasss';
        VUser.EmailEncodingKey='UTF-8';
        VUser.LanguageLocaleKey='en_US';
        VUser.LocaleSidKey='en_IN';
        VUser.Branding_Manager__c=HBUser.Id;                   //Head Branding 
        VUser.Branding_Team_Member__c=RBMUser.Id;
        VUser.IsActive=true; 
        VUser.EmployeeNumber='test';
        insert VUser;
        
        
        
        
        
        AP_Taluk_Master__c TalukMaster=new AP_Taluk_Master__c();
        TalukMaster.Name='TalukMaster';
        TalukMaster.Region__c='South';
        TalukMaster.State__c='Karnataka';
        TalukMaster.District__c='Karwar';
        TalukMaster.Cluster__c='Hubli';
        insert TalukMaster;
        
        
        
        User_Taluk_Master_Junction__c usrTalukJunction=new User_Taluk_Master_Junction__c();
        usrTalukJunction.Name='Junction1';
        usrTalukJunction.AP_Taluk_Master__c=TalukMaster.Id;
        usrTalukJunction.Unique_filed__c='abcsd';
        usrTalukJunction.User__c=BDMUser.Id;
        insert usrTalukJunction;
        
        Vendor_Details__c venDetail=new Vendor_Details__c();
        venDetail.Board_4X2__c=40;
        venDetail.Board_6X3__c=10;
        venDetail.Board_8X3__c=20;
        venDetail.Board_8X4__c=30;
        venDetail.Primary_Vendor__c=true;
        venDetail.Vendor__c=VUser.Id;
        venDetail.Vendor_Code__c='sssss';
        venDetail.Vendor_Cluster__c='HUBLI';
        insert venDetail;
        
        Account acc1=new Account();
        acc1.RecordTypeId=[select id from RecordType where name='Dealer' LIMIT 1].Id;
        acc1.Name='testAccount';
        acc1.Contact_Name__c='asdfghjkl';
        acc1.Contact_Number_Mobile__c='9876543210';
        acc1.Contact_Number_Phone__c='9876543210';
        acc1.Website='';
        acc1.ownerId=BDMUser.id;
        acc1.APPL_Taluk__c  =usrTalukJunction.Id;
        acc1.Year_Since_in_Business__c = '2020';
        acc1.Products__c='Column Pipes';
        acc1.Business_Line__c='Column';
        insert acc1;
        
        
        Account acc2=new Account();
        acc2.RecordTypeId=[select id from RecordType where name='Dealer' LIMIT 1].Id;
        acc2.Name='testAccount2';
        acc2.Contact_Name__c='asddfgfghjkl';
        acc2.Contact_Number_Mobile__c='9876533210';
        acc2.Contact_Number_Phone__c='9872543210';
        acc2.Website=''; 
        acc2.SAP_Vendor_Code__c='1234';
        acc2.APPL_Taluk__c  =usrTalukJunction.Id;
        acc2.ownerId=BDMUser.id;
        acc2.Year_Since_in_Business__c='2020';
        acc2.Products__c='Column Pipes';
        acc2.Business_Line__c='Column';
        insert acc2;
        
        
        
        /*   Branding_Request__c brand2= NEW Branding_Request__c(); 
brand2.Branding_Products__c='All Products';
brand2.Shop_Name__c=acc1.id;
brand2.Branding_Request__c=casek.Id;
brand2.Shop_Type__c='Repair/Rework Dealer';
brand2.comments__c='';
brand2.Branding_Sub_Products__c='SWR';
brand2.Branding_Type__c='In Shop';
brand2.Language__c='English';
brand2.Shop_Description__c='zzzz';
brand2.RecordType=rt;
brand2.Branding_Request__c=casek.id;
//insert brand2;
brdlst.add(brand2);
Branding_Request__c brand3= NEW Branding_Request__c(); 
brand3.Branding_Products__c='All Products';
brand3.Shop_Name__c=acc1.id;
brand3.comments__c='';
brand3.Branding_Request__c=casel.Id;
brand3.Shop_Type__c='Repair/Rework Dealer';
brand3.Branding_Sub_Products__c='SWR';
//brand3.Branding_Type__c='In Shop';
brand3.Language__c='English';
brand3.Shop_Description__c='zzzz';
brand3.RecordType=rt;
//insert brand3;
brdlst.add(brand3);
Branding_Request__c brand4= NEW Branding_Request__c(); 
brand4.Branding_Products__c='All Products';
brand4.Shop_Name__c=acc1.id;
brand4.comments__c='';
brand4.Branding_Request__c=casem.Id;
brand4.Shop_Type__c='Repair/Rework Dealer';
brand4.Branding_Sub_Products__c='SWR';
brand4.Language__c='English';
brand4.Shop_Description__c='zzzz';
brand4.RecordType=rt;
//insert brand4;
brdlst.add(brand4);*/
        
        //insert brdlst;
        Case cas=new case();
        System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
        cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
        cas.status='Open';
        cas.subject='';
        insert cas;
        Branding_Request__c br=new Branding_Request__c();
        br.Submitted_By__c=RBMUser.Id;
        br.Branding_Request__c=cas.id;
        br.Shop_Name__c=[select id  from Account limit 1].id;
        br.Branding_Products__c='All Products';
        br.Branding_Approved_Rejected__c='Vendor Assigned';
        br.Branding_Type__c='both';
        br.Vendor_Account__c=acc2.Id;
        br.RBM_Approval_Date__c=Date.today();
        
        insert br;
        /***********************/
        //System.debug([SELECT Id,Name,Shop_Name__c from Branding_Request__c where Branding_Approved_Rejected__c ='Vendor Assigned' and createddate<=:date.valueOf(system.label.BrandingCreatedDate)]);
        /************************************/
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = 'https://ashirwardpipeslighting--partial.my.salesforce.com/services/apexrest/BrandingPortal/'+String.valueOf(Date.today())+'TO'+String.valueOf(Date.today().addDays(10)); 
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response = res;
        List<String> dateString = (system.label.BrandingCreatedDate).split('/');
            DateTime brdDate = DateTime.newInstanceGMT(Integer.valueOf(dateString[2]),Integer.valueOf(dateString[1]),Integer.valueOf(dateString[0]));
        system.debug(brdDate);
        Date rbmDate = Date.today();
        system.debug('rbmDate:'+rbmDate);
        system.debug([SELECT Id,Name,RBM_Approval_Date__c,Shop_Name__r.Name,Address__c,Vertical_type__c,Branding_Approved_Rejected__c,createddate from Branding_Request__c where  Branding_Approved_Rejected__c ='Vendor Assigned' and RBM_Approval_Date__c <=:rbmDate]);
        //system.debug(date.valueOf(system.label.BrandingCreatedDate));
        BrandingPortalIntegration.fetchBrandingRecords();
    }
}
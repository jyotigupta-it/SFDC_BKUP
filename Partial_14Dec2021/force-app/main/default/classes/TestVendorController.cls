@isTest(seeAllData=false)
public class TestVendorController {
    public static void setup(){
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

        insert BDMUser;
        
        
        
        
        User VUser=new User();
        VUser.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'Ashirvad Partner Community User'].Id;
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
        acc1.RecordTypeId=[select id from RecordType where name='Dealer'].Id;
        acc1.Name='testAccount';
        acc1.Contact_Name__c='asdfghjkl';
        acc1.Contact_Number_Mobile__c='9876543210';
        acc1.Contact_Number_Phone__c='9876543210';
        acc1.Website='';
       
        acc1.APPL_Taluk__c  =usrTalukJunction.Id;
        insert acc1;
        
    }
    public static testMethod void test1(){
        Account acc1=new Account();
        acc1.RecordTypeId=[select id from RecordType where name='Dealer'].Id;
        acc1.Name='testAccount11';
        acc1.Contact_Name__c='asdfghjk11l';
        acc1.Contact_Number_Mobile__c='9875543210';
        acc1.Contact_Number_Phone__c='9876543210';
        acc1.Website='';
       
       
        insert acc1;
        Case cas=new case();
        System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
        cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
        cas.status='Open';
        cas.subject='';
        insert cas;
        Branding_Request__c br=new Branding_Request__c();
        br.Submitted_By__c=userInfo.getUserId();
        br.Branding_Request__c=cas.id;
        br.Shop_Name__c=acc1.id;
        insert br;
        
        Branding_Request__c br1=new Branding_Request__c();
        br1.Submitted_By__c=userInfo.getUserId();
        br1.Branding_Request__c=cas.id;
        br1.Shop_Name__c=acc1.id;
        insert br1;
        
        List<String> zzz=new List<String>();
        
        zzz.add(''+br.id);
        List<String> zaq=new List<String>();
        zaq.add(''+br1.id);
        
        
        String abc='fgdfsgds';
            Blob beforeblob = Blob.valueOf(abc); 
            string paramvalue = EncodingUtil.base64Encode(beforeblob);
        
        
        VendorPageController.VenBrandWrap vv=new VendorPageController.VenBrandWrap();
        vv.BrandId=br1.id;
        vv.afterDocId='';
        vv.beforeDocId='';
        vv.afterDoc=paramvalue;
        vv.beforeDoc=paramvalue;
        vv.Status='Request Completed and Submitted';
        
        List<VendorPageController.VenBrandWrap> vlist=new List<VendorPageController.VenBrandWrap>();
        vlist.add(vv);
            
            
            VendorPageController.collectVendorBrand();
            boolean df=VendorPageController.submitData(vlist);
            VendorPageController.collectApproveBrand();
            VendorPageController.approveRequest(zzz,'dsfd');
        
        
        vlist=new List<VendorPageController.VenBrandWrap>();
        vv.BrandId=br.id;
        vlist.add(vv);
        VendorPageController.collectVendorBrand();
        boolean dff=VendorPageController.submitData(vlist);
        VendorPageController.collectApproveBrand();
        
        
        VendorPageController.rejectRequest(zzz,'dsfd');
        String zz=VendorPageController.uploadImage(vlist[0],true);
        zz=VendorPageController.uploadImage(vlist[0],false);
    }
    
    public static testmethod void test2(){
        Account acc1=new Account();
        acc1.Name='testAccount';
        acc1.Contact_Name__c='asdfghjkl';
        acc1.Contact_Number_Mobile__c='9876543210';
        acc1.Contact_Number_Phone__c='9876543210';
        acc1.Website='';
        insert acc1;
        
        Case cas=new case();
        System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
        cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
        cas.status='Open';
        cas.subject='';
        insert cas;
        Branding_Request__c br1=new Branding_Request__c();
        br1.Submitted_By__c=userInfo.getUserId();
        br1.Branding_Request__c=cas.id;
        br1.Shop_Name__c=acc1.id;
        insert br1;
        
        
        Attachment at=new Attachment();
        at.parentId=br1.id;
        at.name='fsdfsdfsd';
        at.body=Blob.valueOf('abc');
        insert at;
         String abc='fgdfsgds';
            Blob beforeblob = Blob.valueOf(abc); 
            string paramvalue = EncodingUtil.base64Encode(beforeblob);
        
        VendorPageController.VenBrandWrap vv=new VendorPageController.VenBrandWrap();
        vv.BrandId=br1.id;
        vv.afterDocId=''+at.Id;
        vv.beforeDocId=''+at.Id;
        vv.afterDoc=paramvalue;
        vv.beforeDoc=paramvalue;
        vv.Status='Request Completed and Submitted';
        List<VendorPageController.VenBrandWrap> vlist=new List<VendorPageController.VenBrandWrap>();
        vlist.add(vv);
        String zz=VendorPageController.uploadImage(vv,true);
        zz=VendorPageController.uploadImage(vv,false);
    }
}
@isTest(seeAllData=false)
private class Test_BandhanController{
    @testSetup
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
        acc1.ownerId=BDMUser.id;
        acc1.APPL_Taluk__c  =usrTalukJunction.Id;
        acc1.Bandhan_Cutsomer__c=true;
        insert acc1;
        
        
        Account acc2=new Account();
        acc2.RecordTypeId=[select id from RecordType where name='Dealer'].Id;
        acc2.Name='testAccount2';
        acc2.Contact_Name__c='asddfgfghjkl';
        acc2.Contact_Number_Mobile__c='9876533210';
        acc2.Contact_Number_Phone__c='9872543210';
        acc2.Website='';  
        acc2.APPL_Taluk__c  =usrTalukJunction.Id;
        acc2.ownerId=BDMUser.id;
        acc2.Bandhan_Cutsomer__c=true;
        insert acc2;
    }
    
    testmethod static void test1(){
        PageReference ref = new PageReference('/apex/BhandhanPage');
        Test.setCurrentPage(ref); 
        List<Account> ac=[select id,APPL_Taluk__c,APPL_Taluk__r.Cluster__c   from account];
        
        ApexPages.currentPage().getParameters().put('id',ac[0].id);
        
        BandhanController brdObject=new BandhanController();
        List<Branding_Request__c> brdLst=BandhanController.collectStoredBranding();
        Account acclst=BandhanController.collectAccount(ac[0].id);
        boolean zu= BandhanController.changeAddress(ac[0].id,'gfgfg','fghgfhfg','fghfghfg','fghgfh','123456');
        
        
        BandhanController.BrandWrap bw=new BandhanController.BrandWrap();          
            bw.Id='';
            bw.Shop=ac[0].Id;
            bw.BrandType='Standard';
            bw.MediaType='4x2';
            bw.MediaChild='';
            bw.Language='Hindi';
            bw.Cluster='Hubli';
            //bw.OwnerId=
            bw.mediabol=true;
            bw.mchildbol=false;
            bw.updbol=false;
            System.debug(bw);
            
            
           
            
            List<BandhanController.BrandWrap> bwList=new List<BandhanController.BrandWrap>();
            bwList.add(bw);
           
            
            String answer=BandhanController.saveReloaded(bwList,false,'');
            System.debug(answer);
            answer=BandhanController.updateReloaded(bwList,false,'');
            System.debug(answer);
    }
    
    
    testmethod static void test2(){
        PageReference ref = new PageReference('/apex/BhandhanPage');
        Test.setCurrentPage(ref); 
        List<Account> ac=[select id,APPL_Taluk__c,APPL_Taluk__r.Cluster__c   from account];
        
        ApexPages.currentPage().getParameters().put('id',ac[0].id);
        
        BandhanController brdObject=new BandhanController();
        List<Branding_Request__c> brdLst=BandhanController.collectStoredBranding();
        Account acclst=BandhanController.collectAccount(ac[0].id);
        boolean zu= BandhanController.changeAddress(ac[0].id,'gfgfg','fghgfhfg','fghfghfg','fghgfh','123456');
        
        
        BandhanController.BrandWrap bw=new BandhanController.BrandWrap();          
            bw.Id='';
            bw.Shop=ac[0].Id;
            bw.BrandType='Standard';
            bw.MediaType='4x2';
            bw.MediaChild='';
            bw.Language='Hindi';
            bw.Cluster='Hubli';
            //bw.OwnerId=
            bw.mediabol=true;
            bw.mchildbol=false;
            bw.updbol=false;
            System.debug(bw);
            
            
           
            
            List<BandhanController.BrandWrap> bwList=new List<BandhanController.BrandWrap>();
            bwList.add(bw);
           
            
            String answer=BandhanController.updateReloaded(bwList,false,'');
            System.debug(answer);
    }
}
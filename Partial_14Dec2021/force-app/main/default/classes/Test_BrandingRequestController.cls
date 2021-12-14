@isTest(seeAllData=false)
private class Test_BrandingRequestController{
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
        
        
    
        
        BrandingRequestController br=new BrandingRequestController();
            
                
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
        
        insert acc1;
        
        
        Account acc2=new Account();
        acc2.RecordTypeId=[select id from RecordType where name='Dealer' LIMIT 1].Id;
        acc2.Name='testAccount2';
        acc2.Contact_Name__c='asddfgfghjkl';
        acc2.Contact_Number_Mobile__c='9876533210';
        acc2.Contact_Number_Phone__c='9872543210';
        acc2.Website='';  
        acc2.APPL_Taluk__c  =usrTalukJunction.Id;
        acc2.ownerId=BDMUser.id;
        acc2.Year_Since_in_Business__c='2020';
        insert acc2;
        
      
        /*
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
                //br.Branding_Approved_Rejected__c='Submitted to RBM';
                insert br;
                
                System.debug([select id,RBM__c,RBM_Name__c  from Branding_Request__c]);
      */
       
        
    }
      public testMethod static void test2(){
        test.startTest();
          
        PageReference ref = new PageReference('/apex/BrandingCreation');
        Test.setCurrentPage(ref); 
        List<Account> ac=[select id,APPL_Taluk__c,APPL_Taluk__r.Cluster__c   from account];
        
        ApexPages.currentPage().getParameters().put('id',ac[0].id);
        
        BrandingRequestController brdObject=new BrandingRequestController();
        List<String> k=BrandingRequestController.collectLanguage();
        List<String> cluster=new List<String>();
        cluster.add('Hubli');
        List<Account> venList=BrandingRequestController.collectVendors(cluster);
        String prof=BrandingRequestController.collectProfile();
        User usr=[select id from user where LastName=:'userBdm' limit 1];
        
        
        
        System.runAs(usr){
            BrandingRequestController.collectVertical();
            Case cas=new case();
            System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
            cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
            cas.status='Open';
            cas.subject='';
            insert cas;
            System.debug(cas);
            
          //  List<User_Taluk_Master_Junction__c> usrJunc=BrandingRequestController.collectCluster();
            Set<string> usrJunc=BrandingRequestController.collectCluster();
            List<Account> acclst=BrandingRequestController.collectAccount('tes','string:'+ac[0].APPL_Taluk__c);
            List<Account> acclst1=BrandingRequestController.collectAccount1(ac[0].id);
            boolean zu= BrandingRequestController.changeAddress(ac[0].id,'gfgfg','fghgfhfg','fghfghfg','fghgfh','123456');
            
            /*Branding_Request__c brd=new Branding_Request__c();
            brd.Branding_Approved_Rejected__c='Request Created';
            brd.Shop_Name__c=ac.Id;
            brd.Media_Type__c='';
            brd.Cluster__c=ac.APPL_Taluk__r.Cluster__c;
            brd.Branding_type__c='Recce';
            brd.Language__c='Hindi';
            brd.Type__c='';
            brd.Branding_Request__c=[select id from Case limit 1].id;
            insert brd;*/
           
            BrandingRequestController.BrandWrap bw=new BrandingRequestController.BrandWrap();          
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
            
            
           
            
            List<BrandingRequestController.BrandWrap> bwList=new List<BrandingRequestController.BrandWrap>();
            bwList.add(bw);
            List<Branding_Request__c> brdLst=BrandingRequestController.collectStoredBranding();
            
            /*String answer=BrandingRequestController.saveReloaded(bwList,new List<String>(),false,'');
            System.debug(answer);*/
            
            
            
            
            //bwList[0].Id=[select Id,Branding_Approved_Rejected__c from Branding_Request__c limit 1].id;
           //System.debug(bwList);
            bwList[0].updbol=false;
            String answer=BrandingRequestController.updateReloaded(bwList,new List<String>(),true,[select id from case limit 1].id);
            System.debug(answer);
            
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-12-2016','02-02-2017');
            
            
            
            
            
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
        }
       usr=[SELECT Id FROM User WHere profile.Name='System administrator' AND IsActive=True limit 1];
        
        
        System.debug(usr);
        System.debug([select Id from Branding_Request__c]);
        System.runAs(usr){  
            
            
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-11-2017','01-01-2018');
            
            List<String> ids=new List<String>();
            ids.add([select id from Branding_Request__c  limit 1].id);
            List<String> vend=new List<String>();
            vend.add([select id from Vendor_Details__c limit 1].id);
            Boolean zaq=BrandingRequestController.approveRequest(ids,'Reject',vend);
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
            Branding_Request__c br=[select id,Branding_Approved_Rejected__c,Escalated_To_Branding_Head__c from Branding_Request__c where id in:ids limit 1]; 
            br.Branding_Approved_Rejected__c='Vendor Assigned';
            update br;
            
            
            String abc='fgdfsgds';
            Blob beforeblob = Blob.valueOf(abc); 
            string paramvalue = EncodingUtil.base64Encode(beforeblob);
            
            
             VendorPageController.VenBrandWrap vv=new VendorPageController.VenBrandWrap();
            vv.BrandId=ids[0];
            vv.afterDocId='';
            vv.afterDoc=paramvalue;
            vv.beforeDoc=paramvalue;
            vv.Status='Request Completed and Submitted';
           
           List<VendorPageController.VenBrandWrap> vlist=new List<VendorPageController.VenBrandWrap>();
            vlist.add(vv);
            
            
            VendorPageController.collectVendorBrand();
            boolean df=VendorPageController.submitData(vlist);
            VendorPageController.collectApproveBrand();
            VendorPageController.rejectRequest(ids,'dsfd');
            String zz=VendorPageController.uploadImage(vlist[0],true);
            zz=VendorPageController.uploadImage(vlist[0],false);
            
        } 
        
         usr=[select id from user where LastName=:'userHB' limit 1];
        
        
        
        System.runAs(usr){
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-12-2016','02-02-2017');
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
        }
            
            BrandingRequestController br = new BrandingRequestController();
         // br.test();
           test.stopTest();
            
		
           
        
        
    } 
    public testMethod static void test1(){
        String zId;
        test.startTest();
        PageReference ref = new PageReference('/apex/BrandingCreation');
        Test.setCurrentPage(ref); 
        List<Account> ac=[select id,APPL_Taluk__c,APPL_Taluk__r.Cluster__c   from account];
        
        ApexPages.currentPage().getParameters().put('id',ac[0].id);
        
        BrandingRequestController brdObject=new BrandingRequestController();
        List<String> k=BrandingRequestController.collectLanguage();
        List<String> cluster=new List<String>();
        cluster.add('Hubli');
        List<Account> venList=BrandingRequestController.collectVendors(cluster);
        String prof=BrandingRequestController.collectProfile();
        User usr=[select id from user where LastName=:'userBdm' limit 1];
        
        
        
        System.runAs(usr){
            BrandingRequestController.collectVertical();
            Case cas=new case();
            System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
            cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
            cas.status='Open';
            cas.subject='';
            insert cas;
            System.debug(cas);
            
          //  List<User_Taluk_Master_Junction__c> usrJunc=BrandingRequestController.collectCluster();
            Set<string> usrJunc=BrandingRequestController.collectCluster();
            List<Account> acclst=BrandingRequestController.collectAccount('tes','string:'+ac[0].APPL_Taluk__c);
            List<Account> acclst1=BrandingRequestController.collectAccount1(ac[0].id);
            boolean zu= BrandingRequestController.changeAddress(ac[0].id,'gfgfg','fghgfhfg','fghfghfg','fghgfh','123456');
            
            Branding_Request__c brd=new Branding_Request__c();
            brd.Branding_Approved_Rejected__c='Request Created';
            brd.Shop_Name__c=ac[0].Id;
            brd.Media_Type__c='';
           // brd.Cluster__c=ac.APPL_Taluk__r.Cluster__c;
            brd.Branding_type__c='Recce';
            brd.Language__c='Hindi';
            brd.Type__c='';
            brd.Branding_Request__c=[select id from Case limit 1].id;
            insert brd;
           
            BrandingRequestController.BrandWrap bw=new BrandingRequestController.BrandWrap();          
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
            
            
           
            
            List<BrandingRequestController.BrandWrap> bwList=new List<BrandingRequestController.BrandWrap>();
            bwList.add(bw);
            List<Branding_Request__c> brdLst=BrandingRequestController.collectStoredBranding();
            
            String answer=BrandingRequestController.saveReloaded(bwList,new List<String>(),false,'');
            System.debug(answer);
            
            
            
            
            //bwList[0].Id=[select Id,Branding_Approved_Rejected__c from Branding_Request__c limit 1].id;
           //System.debug(bwList);
            bwList[0].updbol=true;
            answer=BrandingRequestController.updateReloaded(bwList,new List<String>(),true,[select id from case limit 1].id);
            System.debug(answer);
            
            zId=[select id from Branding_Request__c  limit 1].id;
            system.debug(zId);
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-12-2016','02-02-2017');
            
            
            
            
            
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
        }
        usr=[SELECT Id FROM User WHere profile.Name='System administrator' AND IsActive=True limit 1];
        
        
        
        System.runAs(usr){  
            system.debug(zId);
            
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-01-2016','14-06-2017');
            
            List<String> ids=new List<String>();
           // ids.add([select id from Branding_Request__c  limit 1].id);
           ids.add(zId);
            List<String> vend=new List<String>();
            vend.add([select id from Vendor_Details__c limit 1].id);
            Boolean zaq=BrandingRequestController.approveRequest(ids,'Reject',vend);
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
            Branding_Request__c br=[select id,Branding_Approved_Rejected__c,Escalated_To_Branding_Head__c from Branding_Request__c where id in:ids limit 1]; 
            br.Branding_Approved_Rejected__c='Vendor Assigned';
            update br;
            
            
            String abc='fgdfsgds';
            Blob beforeblob = Blob.valueOf(abc); 
            string paramvalue = EncodingUtil.base64Encode(beforeblob);
            
            
             VendorPageController.VenBrandWrap vv=new VendorPageController.VenBrandWrap();
            vv.BrandId=ids[0];
            vv.afterDocId='';
            vv.afterDoc=paramvalue;
            vv.beforeDoc=paramvalue;
            vv.Status='Request Completed and Submitted';
           
           List<VendorPageController.VenBrandWrap> vlist=new List<VendorPageController.VenBrandWrap>();
            vlist.add(vv);
            
            
            VendorPageController.collectVendorBrand();
            boolean df=VendorPageController.submitData(vlist);
            VendorPageController.collectApproveBrand();
            VendorPageController.rejectRequest(ids,'dsfd');
            String zz=VendorPageController.uploadImage(vlist[0],true);
            zz=VendorPageController.uploadImage(vlist[0],false);
            
        } 
        
         usr=[select id from user where LastName=:'userHB' limit 1];
        
        
        
        System.runAs(usr){
            BrandingRequestController.WrapBrand z1=BrandingRequestController.relatedBrandingRequests('01-12-2016','02-02-2017');
            BrandingRequestController.WrapBrand z=BrandingRequestController.getDetails();
        }
            
             BrandingRequestController br = new BrandingRequestController();
        //  br.test();
            
           test.stopTest();
            
        
           
        
        
    }
    @isTest
    public static void test6(){
        Case cas=new case();
                System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
                cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
                cas.status='Open';
                cas.subject='';
                insert cas;
                            
                Branding_Request__c br=new Branding_Request__c();
                //br.Submitted_By__c=RBMUser.Id;
                br.Branding_Request__c=cas.id;
                br.Shop_Name__c=[select id from Account limit 1].id;
                //br.Branding_Approved_Rejected__c='Submitted to RBM';
                insert br;
                
               BrandingRequestController.deleteBrandingRequest( br.id);
                
                System.debug([select id,RBM__c,RBM_Name__c  from Branding_Request__c]);
        
    } 
    
     
}
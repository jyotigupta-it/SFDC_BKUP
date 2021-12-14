@isTest
public class PlumberClaimPageControllerTest {
    @testSetup static void setup(){
        MessagingChannel msgChannel = new MessagingChannel();
        MessagingEndUser msgEndUser = new MessagingEndUser();
        MessagingSession msgSession = new MessagingSession();
        List<Account> accList = new List<Account>();
        List<Sales_scheme__c> schemeList = new List<Sales_scheme__c>();
        List<Warranty_Master__c> warrantyMasterList = new List<Warranty_Master__c>();
        List<Pincode__c> pinCodeList = new List<Pincode__c>();
        Id indRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
        Id schemeRecTypeId = Schema.SObjectType.Sales_scheme__c.getRecordTypeInfosByName().get('Product scheme').getRecordTypeId();
        Id clubRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plumber Club  Enrollment').getRecordTypeId();
        User currUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        Product_Category__c pCat = new Product_Category__c(Category_id__c='Cat-001',Name = 'Cat-001',Description__c='Desc');
        INSERT pCat;
        IEP_Product__c prod = new IEP_Product__c(Name = 'Test Prod',Product_Category__c =pCat.Id,Product_Id__c='PROD-0001');
        INSERT prod;
        Sales_scheme__c scheme = new Sales_scheme__c(Name = 'Plumber Special – Silver Dhamaka',RecordTypeId = schemeRecTypeId,Product__c = prod.Id,Is_active__c = true,Point_per_product__c=12,amount_per_point__c = 12,Start_date__c = System.today(),End_date__c = System.today(),Product_filter_type__c = 'PRODUCT',Point_accrual_type__c = 'PRODUCT_VALUE');
        schemeList.add(scheme);
        INSERT schemeList;
        Warranty_Master__c warranty = new Warranty_Master__c(Name = 'abc',Serial_Number__c='QRCode_1');
        warrantyMasterList.add(warranty);
        INSERT warrantyMasterList;
        
        system.runAs(currUser){
            msgChannel.MessageType='Whatsapp';
            msgChannel.MessagingPlatformKey='Whatsapp-+918061341880';
            msgChannel.DeveloperName='xyzz';
            msgChannel.MasterLabel='asdfg';
            INSERT msgChannel;
            
            msgEndUser.Name='whatsapp:+918055208289';
            msgEndUser.MessagingPlatformKey='whatsapp:+918055208289';
            msgEndUser.MessageType='WhatsApp';
            msgEndUser.MessagingChannelId=msgChannel.id;
            INSERT msgEndUser;
            
            Account accObj = new Account();
            accObj.Name = 'Plumber_1';
            accObj.RecordTypeId = indRecordTypeId;
            accObj.Party_Type__c = 'Plumber';
            accObj.Pin_Code1__c = '560068';
            accObj.Plumber_Club_Member_Category__c = 'Purple';
            accObj.Contact_Number_Mobile__c = '8055208289';
            accList.add(accObj);
            
            Account accObj_1 = new Account();
            accObj_1.Name = 'Plumber_2';
            accObj_1.RecordTypeId = clubRecordTypeId;
            accObj_1.Party_Type__c = 'Plumber';
            accObj_1.Pin_Code1__c = '560068';
            accObj_1.Plumber_Club_Member_Category__c = 'Purple';
            accObj_1.Contact_Number_Mobile__c = '8055208289';
            accList.add(accObj_1);
            
            INSERT accList;
            
            msgSession.MessagingEndUserId=msgEndUser.id;
            msgSession.MessagingChannelId=msgChannel.Id;
            msgSession.Messaging_User_Account__c=accObj.id;
            msgSession.Status='Active';
            INSERT msgSession;
        }
    }
    @isTest static void testMethod_1(){
        MessagingSession msgSessionObj =new MessagingSession();
        msgSessionObj = [SELECT Id FROM MessagingSession LIMIT 1];
        Account accObj = new Account();
        accObj = [SELECT id FROM Account LIMIT 1];
        
        Test.setCurrentPageReference(new PageReference('Page.PlumberClaimPage')); 
        System.currentPageReference().getParameters().put('sId', msgSessionObj.Id);
        System.currentPageReference().getParameters().put('pId', accObj.Id);
        
        PlumberClaimPageController pclImContObj = new PlumberClaimPageController();
        pclImContObj.quantity = 1;
        pclImContObj.qrCodeList = new List<String>{'QRCode_1'};  
            pclImContObj.qrCodeScanned = 'QRCode_1';
        pclImContObj.qrCodeScannedCount = 1;
        pclImContObj.selectedCapacity = '500L';
        pclImContObj.rowCountCapacity = 1;
            
        pclImContObj.next_1();
        pclImContObj.prev_2();       
        pclImContObj.getCapacitySum(new List<String>{'500L','1000L'});
        pclImContObj.next_2();
        pclImContObj.prev_3();
        pclImContObj.saveClaim();        
        pclImContObj.saveQRCode();
        pclImContObj.saveCapacty();
        pclImContObj.fetchCityName();
        pclImContObj.navigateToWhatsApp();
        pclImContObj.getSchemes();
        pclImContObj.getCapacity();
        
    }
    @isTest static void testMethod_2(){
    	MessagingSession msgSessionObj =new MessagingSession();
        msgSessionObj = [SELECT Id FROM MessagingSession LIMIT 1];
        Account accObj = new Account();
        Sales_scheme__c schemeObj = new Sales_scheme__c();
        accObj = [SELECT id FROM Account LIMIT 1];
        
        Test.setCurrentPageReference(new PageReference('Page.PlumberClaimPage')); 
        System.currentPageReference().getParameters().put('sId', msgSessionObj.Id);
        System.currentPageReference().getParameters().put('pId', accObj.Id);
        Plumber_Scheme_Relation__c pSchemeJuncObj = new Plumber_Scheme_Relation__c();
        PlumberClaimPageController pclImContObj = new PlumberClaimPageController();
        schemeObj = [SELECT Id FROM Sales_scheme__c LIMIT 1];
        
        pSchemeJuncObj.Plumber__c = accObj.Id;
        pSchemeJuncObj.Scheme__c = schemeObj.Id;
        pclImContObj.quantity = 1;
        pclImContObj.qrCodeList = new List<String>{'QRCode_1'};  
            pclImContObj.qrCodeScanned = 'QRCode_1';
        pclImContObj.qrCodeScannedCount = 1;
        pclImContObj.selectedCapacity = '500L';
        pclImContObj.rowCountCapacity = 1;
        pclImContObj.capListFetched = new List<String>{'500L'};
            pclImContObj.billBody = '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686t5r5I8UmpS5lPDUo9lLqYFpXWno5Lj08/wZPhpfL6MlQzVmcMZRpmFmaOrrJftWfVLN+f35QFZS3P6hZQRT9TA0I94RbhWLZTdk32m5zInOOrpVfzVg/kGuRuz51c47Xm67Wotay1vXnqeZvyxta5rqtfD61PWN+7QXNDwYaJjd4bD28ibErd9EO+WX5Z/qvNUZt7ClQKNhaMb/He0looUcgvvL3VYWvdNtQ27rbB7Zbbq7Z/LGIXXSk2K64ofl/CKrnylflXlV8t7kjcMVhqU7p/J2Ynb+fILuddh8uky9aUje8O3N1ZTi8vKn+1Z+WeyxVWFXV7CXuFe0crAyq7q7Sqdla9r06uHq5xq2mvVa7dXju/j73vxn6X/W11KnXFde8OcA/cqfeu72zQaag4iDmYffBJY2Rj/9eMr5ubFJuKmz4c4h0aPRx6uK/Ztrm5RbmltBVuFbZOH4k7cv0bj2+624zb6ttp7cVHwVHh0affxn87csz/WO9xxvG277S/q+2gdBR1Qp25nbNdyV2j3THdQyf8TvT2OPR0fG/y/aGT6idrTsmeKj1NOF1wevHMmjNzZzPPzpxLOjfeu7L3/vno87f6QvoGL/hfuHTR6+L5ftf+M5ccL528bH/5xBXGla6rNlc7B6wHOn6w/qFj0Gaw85rtte7rdtd7hpYMnb7hfOPcTY+bF2/53ro6vHR4aCRi5M7tuNujd9h3pu6m3X1xL/vewv2ND9APih5KPax4pPyo4Uf9H9tHbUZPjXmMDTwOe3x/nDX+7Kesn95PFDwhP6mYVJtsnrKYOjntNX396bKnE88yny3MFP4s/XPtc73n3/3i8svAbPTsxAv+i8VfS14qvDz0yupV71zw3KPX6a8X5oveKLw5/Jbxtv9d1LvJhZz32PeVH/Q/9Hz0//hgMX1x8V/3hPP7y2IJQQplbmRzdHJlYW0KZW5kb2JqCjMgMCBvYmoKPDwKPj4gZW5kb2JqCjkgMCBvYmoKPDwKL0Jhc2VGb250IC9IZWx2ZXRpY2EgCi9FbmNvZGluZyAvV2luQW5zaUVuY29kaW5nIAovU3VidHlwZSAvVHlwZTEgCi9UeXBlIC9Gb250IAovTmFtZSAvSGVsdiAKPj4gZW5kb2JqCjEwIDAgb2JqCjw8Ci9DcmVhdGlvbkRhdGUgKEQ6MjAwODA2MTExNjU2MDMpIAovTW9kRGF0ZSAoRDoyMDA4MDYxMTE2NTYwMykgCi9Qcm9kdWNlciAoSWJleCBQREYgQ3JlYXRvciA0LjMuNi40LzUwMjUgWy5ORVQgMi4wXSkgCj4+IGVuZG9iagp4cmVmCjAgMTEKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwNjE2IDAwMDAwIG4gCjAwMDAwMDA1NTYgMDAwMDAgbiAKMDAwMDAwMzQyNCAwMDAwMCBuIAowMDAwMDAwNzA2IDAwMDAwIG4gCjAwMDAwMDA3NDEgMDAwMDAgbiAKMDAwMDAwMDIxNSAwMDAwMCBuIAowMDAwMDAwNDgwIDAwMDAwIG4gCjAwMDAwMDAwMjAgMDAwMDAgbiAKMDAwMDAwMzQ0NSAwMDAwMCBuIAowMDAwMDAzNTU5IDAwMDAwIG4gCnRyYWlsZXIKPDwKL1NpemUgMTEgCi9JbmZvIDEwIDAgUiAgCi9Sb290IDEgMCBSIAo+PgpzdGFydHhyZWYKMzY5OAolJUVPRgo=';
        pclImContObj.billName = 'BaillName';
        pclImContObj.saveClaim(); 
    }
}
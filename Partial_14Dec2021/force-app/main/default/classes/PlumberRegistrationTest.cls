/* 
* Name      : PlumberRegistrationTest
* Purpose   : This class is used as Test Class for Plumber Registration module.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
@isTest
private class PlumberRegistrationTest {
    @testSetup static void setup(){
        MessagingChannel msgChannel = new MessagingChannel();
        MessagingEndUser msgEndUser = new MessagingEndUser();
        MessagingSession msgSession = new MessagingSession();
        List<Account> accList = new List<Account>();
        List<Sales_scheme__c> schemeList = new List<Sales_scheme__c>();
        List<Plumber_Scheme_Relation__c> pSchemeJuncList = new List<Plumber_Scheme_Relation__c>();
        Id indRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
        Id schemeRecTypeId = Schema.SObjectType.Sales_scheme__c.getRecordTypeInfosByName().get('Product scheme').getRecordTypeId();
        Id clubRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plumber Club  Enrollment').getRecordTypeId();
        Id dealerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        User currUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        Product_Category__c pCat = new Product_Category__c(Category_id__c='Cat-001',Name = 'Cat-001',Description__c='Desc');
        INSERT pCat;
        IEP_Product__c prod = new IEP_Product__c(Name = 'Test Prod',Product_Category__c =pCat.Id,Product_Id__c='PROD-0001');
        INSERT prod;
        Sales_scheme__c scheme = new Sales_scheme__c(Name = 'Plumber Special – Silver Dhamaka',RecordTypeId = schemeRecTypeId,Product__c = prod.Id,Is_active__c = true,Point_per_product__c=12,amount_per_point__c = 12,Start_date__c = System.today(),End_date__c = System.today(),Product_filter_type__c = 'PRODUCT',Point_accrual_type__c = 'PRODUCT_VALUE');
        schemeList.add(scheme);
        INSERT schemeList;
        Reward_Master__c rewardmasterObj = new Reward_Master__c(Active__c = true,Quantity_Capacity__c = 3500,Unit_of_Measurement__c = 'L',Reward_Unit_of_Measuremnt__c = 'gms',Reward_Quantity__c = 10);
        INSERT rewardmasterObj;
        System.runAs(currUser){
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
            
            Account accObj_2 = new Account();
            accObj_2.Name = 'Plumber_3';
            accObj_2.RecordTypeId = dealerRecordTypeId;
            accObj_2.Party_Type__c = 'Dealer';
            accObj_2.Pin_Code1__c = '560068';
            accObj_2.Plumber_Club_Member_Category__c = 'Purple';
            accObj_2.Contact_Number_Mobile__c = '8055208289';
            accObj_2.Year_Since_in_Business__c = '2019';
            accObj_2.Remaining_Purchased_Capacity__c = '20000';
            accList.add(accObj_2);
            
            Account accObj = new Account();
            accObj.Name = 'Plumber_1';
            accObj.RecordTypeId = indRecordTypeId;
            accObj.Party_Type__c = 'Plumber';
            accObj.Pin_Code1__c = '560068';
            accObj.Plumber_Club_Member_Category__c = 'Purple';
            accObj.Contact_Number_Mobile__c = '8055208289';
            accObj.Remaining_Purchased_Capacity__c = '20000';
            accList.add(accObj);
            
            Account accObj_1 = new Account();
            accObj_1.Name = 'Plumber_2';
            accObj_1.RecordTypeId = clubRecordTypeId;
            accObj_1.Party_Type__c = 'Plumber';
            accObj_1.Pin_Code1__c = '560068';
            accObj_1.Plumber_Club_Member_Category__c = 'Purple';
            accObj_1.Contact_Number_Mobile__c = '8055208289';
            accObj_1.Remaining_Purchased_Capacity__c = '20000';
            accList.add(accObj_1);
            
            INSERT accList;
            for(Account accLoopObj : accList){
                Plumber_Scheme_Relation__c pSchemeJuncObj = new Plumber_Scheme_Relation__c(Plumber__c = accLoopObj.Id,Scheme__c = scheme.Id);
                pSchemeJuncList.add(pSchemeJuncObj);
            }
            INSERT pSchemeJuncList;
            msgSession.MessagingEndUserId=msgEndUser.id;
            msgSession.MessagingChannelId=msgChannel.Id;
            msgSession.Messaging_User_Account__c=accObj.id;
            msgSession.Status='Active';
            msgSession.OTP__c  = '121212';
            INSERT msgSession;
            
            ContentVersion contentVersion_1 = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion_1;
            
            ContentVersion contentVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion_1.Id LIMIT 1];
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=msgSession.id;
            contentlink.ShareType= 'V';
            contentlink.ContentDocumentId=documents[0].Id;
            contentlink.Visibility = 'AllUsers'; 
            insert contentlink;
        }
    }
    //FetchPlumberDetails class
    @isTest static void testMethod1(){
        MessagingEndUser msgEndUser =new MessagingEndUser();
        List<FetchPlumberDetails.PlumberInput> plumberInputs = new List<FetchPlumberDetails.PlumberInput>();
        FetchPlumberDetails.PlumberInput pInput = new FetchPlumberDetails.PlumberInput();
        
        msgEndUser = [SELECT Id FROM MessagingEndUser LIMIT 1];
        pInput.endUserId = msgEndUser.Id;
        plumberInputs.add(pInput);
        
        FetchPlumberDetails.getPlumberDetails(plumberInputs);
    }
    //FetchPlumberDetails class
    @isTest static void testMethod12(){        
        FetchPlumberDetails.getPlumberDetails(new List<FetchPlumberDetails.PlumberInput>());
    }
    //RegisterPlumber class
    @isTest static void testMethod2(){
        MessagingEndUser msgEndUser =new MessagingEndUser();
        List<RegisterPlumber.PlumberInput> plumberInputs = new List<RegisterPlumber.PlumberInput>();
        RegisterPlumber.PlumberInput pInput = new RegisterPlumber.PlumberInput();
        
        msgEndUser = [SELECT Id FROM MessagingEndUser LIMIT 1];
        pInput.plumberName = 'Plumber_2';
        pInput.plumberPinCode = '560068';
        pInput.plumberAddress = '#Test';
        pInput.endUserId = msgEndUser.Id;
        plumberInputs.add(pInput);
        
        RegisterPlumber.registerNewPlumber(plumberInputs);
    }
    //UpdateKYCDocLinkGenTimeStamp class
    @isTest static void testMethod3(){
        MessagingSession messagingSession = new MessagingSession();
        List<UpdateKYCDocLinkGenTimeStamp.PlumberInput> plumberInputs = new List<UpdateKYCDocLinkGenTimeStamp.PlumberInput>();
        UpdateKYCDocLinkGenTimeStamp.PlumberInput pInput = new UpdateKYCDocLinkGenTimeStamp.PlumberInput();
        
        messagingSession = [SELECT Id,KYC_Doc_Upload_Link_Generation_Time__c FROM MessagingSession LIMIT 1];
        pInput.messagingSessionId = messagingSession.Id;
        plumberInputs.add(pInput);
        
        UpdateKYCDocLinkGenTimeStamp.getPlumberDetails(plumberInputs);
    }
    //UploadKYCController class
    @isTest static void testMethod4(){
        MessagingEndUser msgEndUser =new MessagingEndUser();
        MessagingSession messagingSession = new MessagingSession();
        Account acc = new Account();
        String base64Data = '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686t5r5I8UmpS5lPDUo9lLqYFpXWno5Lj08/wZPhpfL6MlQzVmcMZRpmFmaOrrJftWfVLN+f35QFZS3P6hZQRT9TA0I94RbhWLZTdk32m5zInOOrpVfzVg/kGuRuz51c47Xm67Wotay1vXnqeZvyxta5rqtfD61PWN+7QXNDwYaJjd4bD28ibErd9EO+WX5Z/qvNUZt7ClQKNhaMb/He0looUcgvvL3VYWvdNtQ27rbB7Zbbq7Z/LGIXXSk2K64ofl/CKrnylflXlV8t7kjcMVhqU7p/J2Ynb+fILuddh8uky9aUje8O3N1ZTi8vKn+1Z+WeyxVWFXV7CXuFe0crAyq7q7Sqdla9r06uHq5xq2mvVa7dXju/j73vxn6X/W11KnXFde8OcA/cqfeu72zQaag4iDmYffBJY2Rj/9eMr5ubFJuKmz4c4h0aPRx6uK/Ztrm5RbmltBVuFbZOH4k7cv0bj2+624zb6ttp7cVHwVHh0affxn87csz/WO9xxvG277S/q+2gdBR1Qp25nbNdyV2j3THdQyf8TvT2OPR0fG/y/aGT6idrTsmeKj1NOF1wevHMmjNzZzPPzpxLOjfeu7L3/vno87f6QvoGL/hfuHTR6+L5ftf+M5ccL528bH/5xBXGla6rNlc7B6wHOn6w/qFj0Gaw85rtte7rdtd7hpYMnb7hfOPcTY+bF2/53ro6vHR4aCRi5M7tuNujd9h3pu6m3X1xL/vewv2ND9APih5KPax4pPyo4Uf9H9tHbUZPjXmMDTwOe3x/nDX+7Kesn95PFDwhP6mYVJtsnrKYOjntNX396bKnE88yny3MFP4s/XPtc73n3/3i8svAbPTsxAv+i8VfS14qvDz0yupV71zw3KPX6a8X5oveKLw5/Jbxtv9d1LvJhZz32PeVH/Q/9Hz0//hgMX1x8V/3hPP7y2IJQQplbmRzdHJlYW0KZW5kb2JqCjMgMCBvYmoKPDwKPj4gZW5kb2JqCjkgMCBvYmoKPDwKL0Jhc2VGb250IC9IZWx2ZXRpY2EgCi9FbmNvZGluZyAvV2luQW5zaUVuY29kaW5nIAovU3VidHlwZSAvVHlwZTEgCi9UeXBlIC9Gb250IAovTmFtZSAvSGVsdiAKPj4gZW5kb2JqCjEwIDAgb2JqCjw8Ci9DcmVhdGlvbkRhdGUgKEQ6MjAwODA2MTExNjU2MDMpIAovTW9kRGF0ZSAoRDoyMDA4MDYxMTE2NTYwMykgCi9Qcm9kdWNlciAoSWJleCBQREYgQ3JlYXRvciA0LjMuNi40LzUwMjUgWy5ORVQgMi4wXSkgCj4+IGVuZG9iagp4cmVmCjAgMTEKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwNjE2IDAwMDAwIG4gCjAwMDAwMDA1NTYgMDAwMDAgbiAKMDAwMDAwMzQyNCAwMDAwMCBuIAowMDAwMDAwNzA2IDAwMDAwIG4gCjAwMDAwMDA3NDEgMDAwMDAgbiAKMDAwMDAwMDIxNSAwMDAwMCBuIAowMDAwMDAwNDgwIDAwMDAwIG4gCjAwMDAwMDAwMjAgMDAwMDAgbiAKMDAwMDAwMzQ0NSAwMDAwMCBuIAowMDAwMDAzNTU5IDAwMDAwIG4gCnRyYWlsZXIKPDwKL1NpemUgMTEgCi9JbmZvIDEwIDAgUiAgCi9Sb290IDEgMCBSIAo+PgpzdGFydHhyZWYKMzY5OAolJUVPRgo=';
        
        acc = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        messagingSession = [SELECT Id,KYC_Doc_Upload_Link_Generation_Time__c FROM MessagingSession LIMIT 1];
        messagingSession.KYC_Doc_Upload_Link_Generation_Time__c = DateTime.newInstance(2021, 7, 22, 12, 30, 0);
        msgEndUser = [SELECT Id FROM MessagingEndUser LIMIT 1];
        
        UPDATE messagingSession;
        UploadKYCController.checkActiveSession(messagingSession.Id,msgEndUser.Id);
        Id attId = UploadKYCController.saveTheFile(acc.Id,'Ashirvad Logo.png',base64Data,'image/png');
        UploadKYCController.updateFileUploadStatus(messagingSession.Id,msgEndUser.Id);
        UploadKYCController.saveChunk(acc.Id,'Ashirvad Logo.png',base64Data,'image/png',attId);
    }
    //UpdatePlumberDetails class
    @isTest static void testMethod5(){
        Account accObj = new Account();
        List<UpdatePlumberDetails.PlumberInput> plumberInputs = new List<UpdatePlumberDetails.PlumberInput>();
        List<UpdatePlumberDetails.PlumberInput> plumberInputs_1 = new List<UpdatePlumberDetails.PlumberInput>();
        List<UpdatePlumberDetails.PlumberInput> plumberInputs_2 = new List<UpdatePlumberDetails.PlumberInput>();
        UpdatePlumberDetails.PlumberInput pInput = new UpdatePlumberDetails.PlumberInput();
        UpdatePlumberDetails.PlumberInput pInput_1 = new UpdatePlumberDetails.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        
        pInput_1.plumberId = '';
        plumberInputs_1.add(pInput_1);
        UpdatePlumberDetails.UpdatePlumberDetails(plumberInputs);
        UpdatePlumberDetails.UpdatePlumberDetails(plumberInputs_1);
        //UpdatePlumberDetails.UpdatePlumberDetails(plumberInputs_2);
    }
    //CheckClaim class
    @isTest static void testMethod6(){
        Account accObj = new Account();
        List<CheckClaim.PlumberInput> plumberInputs = new List<CheckClaim.PlumberInput>();
        CheckClaim.PlumberInput pInput = new CheckClaim.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        
        CheckClaim.getClaimStatus(plumberInputs);
    }
    
    //ClaimGenUpdate
    @isTest static void testMethod7(){
        Account accObj = new Account();
        List<ClaimGenUpdate.PlumberInput> plumberInputs = new List<ClaimGenUpdate.PlumberInput>();  
        ClaimGenUpdate.PlumberInput pInput = new ClaimGenUpdate.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.sessionId = accObj.Id;
        plumberInputs.add(pInput);
        
        ClaimGenUpdate.updateClaimDetails(plumberInputs);
    }
    //FetchCapacity
    @isTest static void testMethod8(){
        Account accObj = new Account();
        List<FetchCapacity.PlumberInput> plumberInputs = new List<FetchCapacity.PlumberInput>();   
        List<FetchCapacity.PlumberInput> capValueList = new List<FetchCapacity.PlumberInput>(); 
        
        FetchCapacity.PlumberInput pInput = new FetchCapacity.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        capValueList.add(pInput);
        
        FetchCapacity.getCapacity(plumberInputs);
    }
    
    //FetchSchemeDetails
    @isTest static void testMethod9(){
        Account accObj = new Account();
        List<FetchSchemeDetails.PlumberInput> plumberInputs = new List<FetchSchemeDetails.PlumberInput>();  
        FetchSchemeDetails.PlumberInput pInput = new FetchSchemeDetails.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        
        FetchSchemeDetails.getClaimDetails(plumberInputs);
    }
    //WhatsAppCaseCreation
    @isTest static void testMethod10(){
        Account accObj = new Account();
        List<WhatsAppCaseCreation.PlumberInput> plumberInputs = new List<WhatsAppCaseCreation.PlumberInput>();  
        WhatsAppCaseCreation.PlumberInput pInput = new WhatsAppCaseCreation.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        
        WhatsAppCaseCreation.createCase(plumberInputs);
    }
    //WhatsAppCaseCreation
    @isTest static void testMethod11(){
        Account accObj = new Account();
        List<CheckSchemeRegistration.PlumberInput> plumberInputs = new List<CheckSchemeRegistration.PlumberInput>();  
        CheckSchemeRegistration.PlumberInput pInput = new CheckSchemeRegistration.PlumberInput();
        accObj = [SELECT Id FROM Account WHERE Name = 'Plumber_1'];
        pInput.plumberId = accObj.Id;
        plumberInputs.add(pInput);
        
        CheckSchemeRegistration.getSchemeRegistrationStatus(plumberInputs);
    }
    //ValidatePlumberPhone
    @isTest static void testMethod13(){
        List<ValidatePlumberPhone.PlumberInput> plumberInputs = new List<ValidatePlumberPhone.PlumberInput>();  
        ValidatePlumberPhone.PlumberInput pInput = new ValidatePlumberPhone.PlumberInput();
        pInput.phoneNumber = '8055208289';
        pInput.Redeem = 'True';
        plumberInputs.add(pInput);
        
        ValidatePlumberPhone.validatePhoneNumber(plumberInputs);
    }
    //GenerateValidatePlumberOtp
    @isTest static void testMethod14(){
        MessagingSession messagingSession = new MessagingSession();
        messagingSession = [SELECT Id,KYC_Doc_Upload_Link_Generation_Time__c FROM MessagingSession LIMIT 1];
        List<GenerateValidatePlumberOtp.PlumberInput> plumberInputs = new List<GenerateValidatePlumberOtp.PlumberInput>();  
        GenerateValidatePlumberOtp.PlumberInput pInput = new GenerateValidatePlumberOtp.PlumberInput();
        pInput.plumberPhone = '8055208289';
        pInput.otp = '121212';
        pInput.messagingSessionId = messagingSession.Id;
        pInput.generationFlag = 'True';
        plumberInputs.add(pInput);
        
        GenerateValidatePlumberOtp.generateValidateOtp(plumberInputs);
    }
    //GenerateValidatePlumberOtp
    @isTest static void testMethod15(){
        MessagingSession messagingSession = new MessagingSession();
        messagingSession = [SELECT Id,KYC_Doc_Upload_Link_Generation_Time__c FROM MessagingSession LIMIT 1];
        List<GenerateValidatePlumberOtp.PlumberInput> plumberInputs = new List<GenerateValidatePlumberOtp.PlumberInput>();  
        GenerateValidatePlumberOtp.PlumberInput pInput = new GenerateValidatePlumberOtp.PlumberInput();
        pInput.plumberPhone = '8055208289';
        pInput.otp = '121212';
        pInput.messagingSessionId = messagingSession.Id;
        pInput.generationFlag = 'False';
        plumberInputs.add(pInput);
        
        GenerateValidatePlumberOtp.generateValidateOtp(plumberInputs);
    }
}
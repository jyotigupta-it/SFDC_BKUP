@istest
public class CameraAccessTest {
    public Static TestMethod Void cameraAccessMethod()
    {
        Test.StartTest();
        PageReference pageRef = Page.PlumberClubEnrollmentCamera;
        
        Account testAccountDis1=new Account();
        testAccountDis1 = Initial_Test_Data.createAccount('test Account1','Distributor');
        testAccountDis1.name='test Account1';
        testAccountDis1.Contact_Number_Mobile__c ='7259582222'; 
        testAccountDis1.Party_Type__c='Distributor';
        testAccountDis1.District__c='Bangalore';
        testAccountDis1.State__c='Karnataka';
        testAccountDis1.Business_Line__c='Plumbing';
        testAccountDis1.Status__c='Existing';
        testAccountDis1.Ramco_ID__c='12345';
        testAccountDis1.SAP_id_DP__c='1222';
        testAccountDis1.VAT_CST_Number__c='101010000000000';
        testAccountDis1.Accountant__c='Yes';
        testAccountDis1.Total_Annual_Turnover__c=150;
        testAccountDis1.Accounting_software_installed__c='Yes';
        testAccountDis1.Avg_Credit_days_offered_in_market__c=10;
        testAccountDis1.Dedicated_office_space__c='Yes';
        testAccountDis1.Distribution_as_a_part_of_total_business__c=15;
        testAccountDis1.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccountDis1.Total_working_capital_investment__c=133;
        testAccountDis1.Borrowed_capital__c=133;
        testAccountDis1.Name_of_software__c='hbkj';
        testAccountDis1.Expected_AA_contribution_in_total_busi__c=10;
        insert testAccountDis1;
          list<ContentVersion> listcont=new list<ContentVersion>();
        ContentVersion cv=new Contentversion();
        cv.title='rollup.txt';
        cv.PathOnClient =cv.title;
        cv.Origin='H';
        cv.versiondata=EncodingUtil.base64Decode('This is version data');
        listcont.add(cv);
        ContentVersion cv2=new Contentversion();
        cv2.title='rollup.txt';
        cv2.PathOnClient =cv2.title;
        cv2.Origin='H';
        cv2.versiondata=EncodingUtil.base64Decode('This is version data');
        listcont.add(cv2);
        ContentVersion cv3=new Contentversion();
        cv3.title='rollup.txt';
        cv3.PathOnClient =cv3.title;
        cv3.Origin='H';
        cv3.versiondata=EncodingUtil.base64Decode('This is version data');
        listcont.add(cv3);
        ContentVersion cv4=new Contentversion();
        cv4.title='rollup.txt';
        cv4.PathOnClient =cv4.title;
        cv4.Origin='H';
        cv4.versiondata=EncodingUtil.base64Decode('This is version data');
        listcont.add(cv4);
        System.debug('PathOnClient'+ cv4.PathOnClient);
           if( String.isNotEmpty(cv.PathOnClient) && String.isNotEmpty(cv2.PathOnClient)  && String.isNotEmpty(cv3.PathOnClient) && String.isNotEmpty(cv4.PathOnClient) ){
        insert listcont;
        System.debug('listcont..'+cv4.id);
           }
        list<String> listString = new List<String>{listcont[0].Id,listcont[1].Id,listcont[2].Id,listcont[3].Id,testAccountDis1.Id};
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = testAccountDis1.id;//Add attachment parentId
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
        
       // insert cDocLink;
         List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            System.assertEquals(documents.size(), 4);
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',testAccountDis1.id);
        ApexPages.StandardController sc = new ApexPages.standardController(testAccountDis1);
        CameraAccess  controller = new CameraAccess(sc);
        CameraAccess.saveFile2(listString);
        listString[0] = '';
        CameraAccess.saveFile2(listString);
        test.stopTest();
        
    }
}
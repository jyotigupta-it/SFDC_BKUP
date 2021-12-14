@IsTest
public class QRCodeScannerControllerTest {

    private static testmethod void qrCodeScanner(){
        Account objParentAccount = TestDataFactory.createParentAccount();
        insert objParentAccount;
        
        Id dealerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Dealer').getRecordTypeId();
        Account objAccount = TestDataFactory.createDealerAccount(objParentAccount.Id, dealerRecordTypeId);
        insert objAccount;
        
        ApexPages.StandardController objStandardController = new ApexPages.StandardController(objAccount);
        QRCodeScannerController objQRCodeScannerController = new QRCodeScannerController(objStandardController);
        
        PageReference pageRef = Page.QRCodeScannerPage;
        pageRef.getParameters().put('id', String.valueOf(objAccount.Id));
        Test.setCurrentPage(pageRef);
        
        objQRCodeScannerController.currentLatitude = 12.95493;
        objQRCodeScannerController.currentLongitude = 77.74161;
        objQRCodeScannerController.calculateAccountRange();
        system.assertEquals(false, objQRCodeScannerController.isOutOfRange, 'Location matched');
        
        objQRCodeScannerController.currentLatitude = 12.99493;
        objQRCodeScannerController.currentLongitude = 77.73161;
        objQRCodeScannerController.calculateAccountRange();
        system.assertEquals(true, objQRCodeScannerController.isOutOfRange, 'Location mismatched');
        
        objQRCodeScannerController.saveQRCode();
    }

}
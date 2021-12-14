@isTest(SeeAllData=true)
global class  Test_SendSMSController {
     global List<Ap_Tour_Plan__c> newTourPlan=new List<Ap_Tour_Plan__c>();
    public static testMethod void testt(){
     Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD']; 
        User userData = new User(Alias = 'standt1', 
                                  Email= 'FName'+'LName'+'@TestUser99.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName',
                                  LastName = 'LName', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName+LName+@TestUs232.com'
                                  );
    insert userData;
      Account acc = new Account();
           
            acc.Name ='AccountMAND';
            acc.Primary_Contact_Person_Name__c='testek';
            acc.Classification__c='A';
            acc.Purchase_Cycle__c='Monthly';
            acc.Contact_Number_Mobile__c='7830862567';
            acc.Street_Address__c='Station road';
            acc.Display_of_our_product__c='Prominent';
            acc.Type_of_Dealer__c='Sanitary';
            acc.Media__c='Outshop';    
            acc.Market__c ='Existing';
            acc.Party_Type__c='Dealer';
            acc.Status__c = 'Prospective'; 
            acc.OwnerId=userData.id;
            acc.Discount__c=50.50;
            acc.District__c='Bangalore';
            acc.State__c='Karnataka';
            acc.Business_Line__c='Plumbing';
            
          
            
          
  
//user ur=[select id,Name from user where id=:'0059000000101C6'];
AP_Tour_Plan__c testRec=new AP_Tour_Plan__c();
    testRec.Account__c=acc.Id;
    testRec.Promotional_Type__c='EngineersMeets';
    //testRec.Account_Contact_Number__c= acc.Contact_Number_Mobile__c;
    testRec.Location__c='Hosur';
    testRec.District__c='Bangalore';
    testRec.Date__c=system.today();
  testRec.OwnerId=userData.id;
Test.startTest(); 
        
         Insert acc;
    insert testRec;
Test.stopTest();
    //newTourPlan.add(testRec);

    }
public static testMethod void testsms()
{
    AP_Tour_Plan__c testRec1=new AP_Tour_Plan__c();  
    testRec1=[select id,CreatedById,Account__c,Location__c,Promotional_Type__c,District__c,Date__c from AP_Tour_Plan__c  where Location__c!='' AND Promotional_Type__c!='' AND  District__c!='' AND Date__c!=null limit 1];
    List<AP_Tour_Plan__c> testRecList=new List<AP_Tour_Plan__c>();
    testRecList.add(testRec1);
    Test.startTest();
        SMSonTourPLANCreation.smsSend(testRecList);
        Test.setMock(HttpCalloutMock.class, new MockClassForSMSET());
        SendSMSController.sendMessage('9308622241','Test');    
       
   Test.stopTest();

}
    // second part to cover execption
    
     //


}
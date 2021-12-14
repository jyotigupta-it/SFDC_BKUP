@isTest
public class DealerAuthenticationControllerTest {
    
    public static testMethod void init(){
        AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
        insert utmj;
        account acc =  new account();
        acc.name = 'testtt';
        acc.State__c = 'Karnataka';
        acc.District__c = 'Mysore';
        acc.Year_Since_in_Business__c = '2016';
        acc.Contact_Number_Mobile__c = '9797979797';
        acc.Products__c='Air Admittance Valve';
        acc.APPL_Taluk__c=utmj.Id;
        
        acc.Business_Line__c='Plumbing';
        acc.PIN_Code__c='464001';
        
        insert acc;
        
        DealerAuthenticationController abc = new DealerAuthenticationController();
        abc.phone = '9797979797';
        abc.searchRetailerThroughPhone();
        abc.goToSignUpPage();
        abc.SelectedRetailer();
        
        DealerSignUpController xyz = new DealerSignUpController();
        xyz.accName = 'Testing';
        xyz.selectedState = 'Karnataka';
        xyz.selectedSTown = 'Mysore';
        xyz.yearSince = '2016';
        xyz.enterdPhone = '9876543210';
        xyz.createRetailer();
        xyz.enableTGM();
    }
}
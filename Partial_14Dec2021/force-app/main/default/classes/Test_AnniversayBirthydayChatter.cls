/***************************************************
* Name:SudhaMurthy
* Description: TEst class of AnniversayBirthydayChatter schedule class
* Controller:AnniversayBirthydayChatter 
* created date :21/06/2019***********************/
@isTest
public class Test_AnniversayBirthydayChatter  {
    @isTest static void Chattertestmethod(){
        Test.startTest();
        User newUser = new User();
        newUser.LastName ='Abc';
        newUser.Alias = 'Rana';
        newUser.LocaleSidKey = 'en_US';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.UserPermissionsOfflineUser = true;
        newUser.UserPermissionsMarketingUser = true;
        newUser.Email = 'abc@gmail.com';
        newUser.Username = 'xyzmm@gmail.com';
        newUser.TimeZoneSidKey='GMT';
        newUser.ProfileId = UserInfo.getProfileId();
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.DigestFrequency = 'D';
        newUser.DefaultGroupNotificationFrequency = 'D';
        newUser.EmployeeNumber='1234';
        newUser.Title='Admin';
        newUser.Division='Karnataka';
        newUser.Vertical_Type__c  ='plumbing';
        //newUser.IS_birthday_today__c = true;
        newUser.isactive = true;
        newUser.Date_of_Birth__c = System.today();
        newUser.Anniversary_Date__c = System.today();
        insert newUser;

        list<FeedItem> postlist1= new list<FeedItem>();
        //list<user> u1=new list<user>();
        
        
        //  user u1= [Select id,name from user where IS_birthday_today__c=true and isactive=true limit 1];
        FeedItem postnew = new FeedItem();
        //for(user ulist:u1){ // chatter instance creation
        postnew.ParentId = newUser.id;
        postnew.Body = 'Happy birthday ';
        
        // }
        try{
            if(  postnew!=null){
                insert postnew;
                system.debug('post...'+postnew);
            }
        }catch(exception e){
            system.debug('exception'+e
                        );
        }
        
        AnniversayBirthydayChatter abc=new AnniversayBirthydayChatter();
        // abc.execute;
        String sch = '0 00 8 * * ?'; //schedule interval time
        system.schedule('AnniversayBirthydayChatter',sch , abc); //system method to schedule apex class
        Test.stopTest();
    }
}
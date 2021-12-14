@isTest
public class Test_ReprtToChatter {
  public static User userdata;
  
  @isTest static void testmethodchatter(){
     Test.startTest();
      userdata= Initial_Test_Data.createUser('test111','test','BD');
       userdata.EmployeeNumber='123';
       insert userdata;
       FeedItem postnew = new FeedItem();
        
        postnew.ParentId = userdata.id;
        postnew.Body = 'Happy birthday ';
        postnew.LinkUrl=URL.getSalesforceBaseUrl().toExternalForm() + '/' + '00O30000008SigW'; // onclick goes to report
        postnew.Title = 'Please click on the link to see  Dealer and Distributor Anniversary';
        
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
         ReprtToChatter abc=new ReprtToChatter ();
        // abc.execute;
        String sch = '  0 0 10 1/1 * ? *'; //schedule interval time
        system.schedule('Report to chatter',sch , abc); //system method to schedule apex class
         Test.stopTest();
     }
}
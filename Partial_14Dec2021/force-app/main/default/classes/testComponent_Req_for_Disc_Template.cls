//written By Naveen Date:17/10/14
@istest
public class testComponent_Req_for_Disc_Template{
   static testmethod void testmethod1()
   {
   RecordType rt= [SELECT Id,Name FROM RecordType WHERE Name='Dealer' AND sObjectType='Account'];

       Account Acc = new Account(Name='test',recordtypeid=rt.id,Primary_Contact_Person_Name__c='testperson', Products__c='product1',
                 Market__c='test',Classification__c='D',Purchase_Cycle__c='test', Status__c='coldcall',Contact_Number_Mobile__c='9849544286',
                 State__c='assam',Display_of_our_product__c='promonent',Media__c='inshop',Type_of_Dealer__c='sanitary');
        insert Acc;
      
       Order__c ord=new Order__c(Projects__c=acc.id);
       insert ord;     
            
   Component_Req_for_Disc_Template obj= new Component_Req_for_Disc_Template();
         obj.ThisAccId=Acc.id;
         obj.getCurrentAcc();
         obj.getLineItems();
   }
}
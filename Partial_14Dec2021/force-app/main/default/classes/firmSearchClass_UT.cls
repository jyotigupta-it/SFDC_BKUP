@isTest
public class firmSearchClass_UT{
public static final string account_RTYPE = Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
static testMethod void testMethod1(){
test.StartTest();

/*Tour_Program__c program=new Tour_Program__c();

Date myDate1=date.newInstance(2015,12,16);
program.From_Date__c=myDate1;
Date myDate=date.newInstance(2015,12,31);
program.To_Date__c=myDate;
insert program;*/

AP_Tour_Plan__c plan = new AP_Tour_Plan__c();
//plan.Name ='planName';
plan.State__c='kerala';
plan.District__c='palakkad';
//plan.Tour_Program__c=program.id;
insert plan;

Target__c target=new Target__c();
target.State__c='kerala';
insert target;

Account acc=new Account();
acc.Name='accTest';
acc.Firm_Name__c ='test';
acc.Contact_Number_Mobile__c='9568742352';
acc.recordTypeId=account_RTYPE;
insert acc;

firmSearchClass firm=new firmSearchClass();
firm.accField=acc;
firm.searchFirm();


AP_Site_Visit__c site=new AP_Site_Visit__c();
site.AP_Tour_Plan__c=plan.id;
site.Target__c=target.id;
site.Party_Name__c=acc.id;
insert site;

acc.Firm_Name__c ='';
update acc;
firm.accField=acc;
firm.searchFirm();

test.StopTest();
 }
}
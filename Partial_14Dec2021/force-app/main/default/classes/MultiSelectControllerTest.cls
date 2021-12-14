/* test class for MultiSelectController */

@isTest
public class MultiSelectControllerTest {
    
    public static testmethod void fetchAccountsTest(){
        Plumber_club__c pc = new Plumber_club__c(Name='Test Plumber');
        insert pc;
        Attendee_Survey_Form__c asf = new Attendee_Survey_Form__c(name='Test Attendee');
        insert asf;
        DateTime dt = Date.valueOf('2030-08-29 00:00:00');
        Date registrationEndDate = Date.valueOf('2030-08-25');
        Meetings__C m = new Meetings__C(Meeting_Type__c='Mini Meet',Meeting_Start_Time__c=dt,title__c='Test',agenda__c='Test',Plumber_Club__c=pc.Id,SurveyForThisMeeting__c=asf.Id,Meeting_Location__c='Test',Registration_End_Date__c=registrationEndDate);
        insert m;
        String typeMonth = MultiSelectController.fetchMeetingTypeMonth(m.Id);
        List<Account> accList = MultiSelectController.fetchAccounts(m.Id);
        MultiSelectController.addAccountsToMeetingAttendee(m.Id,accList);
    }
}
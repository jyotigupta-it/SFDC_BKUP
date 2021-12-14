/* Controller called from components MultiSelectUsageDemo and  MultiSelect */
public with sharing class MultiSelectController {
    /* Fetch meeting type from given recordId and month from custom metda data for given meeting type*/
    
	@AuraEnabled
    public static String fetchMeetingTypeMonth(String recordId){
        Meetings__c m =  [select Id, Meeting_Type__c from Meetings__C where id=: recordId limit 1];
        String meetingType = m.Meeting_Type__c;
        Integer month = MultiSelectController.fetchMeetingAttendeeFilter(meetingType);
        String typeMonth = meetingType+':'+month;
        return typeMonth;
    }    
    
    /* Method called from  MultiSelectUsageDemoController.js
     * It fetches final  account list to be shown in dropdown list
	*/
	@AuraEnabled
    public static List<Account> fetchAccounts(String recordId){
        Meetings__c m =  [select Id, Name, Plumber_club__c,Meeting_Type__c,Meeting_Start_Time__c from Meetings__C where id=: recordId limit 1];
        String plumberClubId = m.Plumber_club__c;
        String meetingType = m.Meeting_Type__c;
        Date meetingStartDate = Date.valueOf(m.Meeting_Start_Time__c);
        System.debug('Plumber CLub: '+ plumberClubId +' Meeting Type: '+meetingType +' Meeting Start Date: '+meetingStartDate);
        List<Account> acc = new List<Account>();
        if(plumberClubId != null){
            acc = [select Id, Name from Account where Plumber_club__c=:plumberClubId];
        }
        
        
        Integer month = MultiSelectController.fetchMeetingAttendeeFilter(meetingType);
        System.debug('Month from Custom Metadata type: '+ month);
        
        List<Account> finalAccList = MultiSelectController.fetchAccoountsFromMeetingAttendee(meetingType,month,meetingStartDate,acc);
        
       	return finalAccList;
        
         // return acc;
        
    }
    
    /*fetch month value from custome metadata type */
    @AuraEnabled
    public static Integer fetchMeetingAttendeeFilter(String meetingType){
        Integer month;
        MeetingAttendeeFilter__mdt mAF = [SELECT MasterLabel, QualifiedApiName, Meeting_Type__c,Months__c FROM 	MeetingAttendeeFilter__mdt where Meeting_Type__c=: meetingType];
		System.debug(mAF.Meeting_Type__c + '=> '+ mAF.Months__c);
        month = Integer.valueOf(mAF.Months__c);
        return month;
    }
    
    /* fetch list of attended accounts from meeting attendee object for specified months */
    @AuraEnabled
    public static List<Account> fetchAccoountsFromMeetingAttendee(String meetingType, Integer month, Date meetingStartDate, List<Account> allAccounts){
        Date earlierDate = meetingStartDate.addMonths(-month);
        System.debug('Start Date: '+meetingStartDate +' Earlier: '+earlierDate);
        List<Meeting_Atendee__c> maAccList = [SELECT Account__c, Meeting_Attended_Date__c,Meeting_Attendee_Status__c,Meeting_Type__c FROM Meeting_Atendee__c where 
                                Meeting_Attendee_Status__c='Attended' and Meeting_Type__c =:meetingType and Meeting_Attended_Date__c >=: earlierDate and Meeting_Attended_Date__c <=: meetingStartDate];
        System.debug('Accounts from MeetingAttendee: '+ maAccList);
        Map<Id,Meeting_Atendee__c> mapAcc = new Map<Id,Meeting_Atendee__c>();
        for(Meeting_Atendee__c ma : maAccList){
            mapAcc.put(ma.Account__c,ma);
        }
        System.debug('Records in Map: '+mapAcc);
        List<Account> finalAccList = new List<Account>();
        for(Account ac:allAccounts){
            if(mapAcc.containsKey(ac.Id)){
                System.debug('#### Duplicate account found '+ ac.Id +' Name: '+ac.Name);
            }else{
                finalAccList.add(ac);
            }
        }
        return finalAccList;
    }
    
    
    /* Method called from  MultiSelectController.js */
    @AuraEnabled
    public static void addAccountsToMeetingAttendee(String recordId, List<Account> accountList){
        System.debug('Meeting record ID: ' + recordId);
        for(Account ac : accountList){
            System.debug('New Account Id: '+ac.Id +' => Name: '+ac.Name);
        }

        Map<Id,Meeting_Atendee__c> mapAcc = new Map<Id,Meeting_Atendee__c>();
        List<Meeting_Atendee__c> accList = [select Account__c from Meeting_Atendee__c where Meetings__c=: recordId];
        for(Meeting_Atendee__c ma : accList){
            mapAcc.put(ma.Account__c,ma);
        }
        System.debug('Records in Map: '+mapAcc);

        List<Meeting_Atendee__c> maList = new List<Meeting_Atendee__c>();
        for(Account ac:accountList){
            if(mapAcc.containsKey(ac.Id)){
                System.debug('Duplicate account found '+ ac.Id +' Name: '+ac.Name);
            }else{
            	Meeting_Atendee__c ma = new Meeting_Atendee__c(Meetings__c=recordId, Account__c=ac.Id);
            	maList.add(ma);
            }
        }
        if(maList.size() > 0){
          insert maList;
        }
        System.debug('Number of records added: '+ maList.size());

    }
}
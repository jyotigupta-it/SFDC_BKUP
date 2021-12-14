@RestResource(urlMapping='/rejection-reason-picklist/*')
global class RejectionReasonPickList {
    // View Class to obtain Rejection Reason Picklist values from MeetingAttendee Table.

    @HttpGet
    global static Map<String, List<String>> getAddress(){
        Map<String, List<String>> result = new Map<String, List<String>>();

        try{
                String objectName = 'meeting_atendee__c';
                String rejectionReason ='Rejection_Reason__c';
                Schema.SObjectType s = Schema.getGlobalDescribe().get(objectName) ;
                Schema.DescribeSObjectResult r = s.getDescribe() ;
                Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
                 //Obtain Rejection Reason Picklist Values
                Schema.DescribeFieldResult fieldResult = fields.get(rejectionReason).getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                List<String> rejectionReasonResult = new List<String>();
                for( Schema.PicklistEntry pickListVal : ple){
                    rejectionReasonResult.add(pickListVal.getLabel());
                }
                
                result.put('rejectionReason',rejectionReasonResult);
                return result;
            }
            catch(Exception  e){
                System.debug('error occured while fetching address picklist'+e.getMessage());
                return null;
            }
    }
}
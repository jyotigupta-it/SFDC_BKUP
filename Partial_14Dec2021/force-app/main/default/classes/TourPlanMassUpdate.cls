/******************************************
 * Created By  :Sudha M
 * Created On  : 05 Sep 2018
 * Modified By : 
 * Modified On : 05 Sep 2018
 * Description :   
				
******************************************/ 

public class TourPlanMassUpdate {
	@AuraEnabled
    public static List<String> fetchMassupdateTP(Id accountId) {
        try {
           
            String programList, profileIdofBD;
            boolean Appcheckbox;
            List<String> addData = new List<String>();
            profileIdofBD = [Select Id, Name from Profile where Name =:'System Administrator'].Id; //query profilename where name is SA
            String profileIdofBD2 = String.valueOf(profileIdofBD).substring(0, 15);
            // programList = [select ProfileId__c from Tour_Program__c ].profileID__C;
               // System.debug('qqqqqqqqq ' + programList);
            programList = [select ProfileId__c from Tour_Program__c where Id =: accountId].ProfileId__c; //query profileid of login user
            System.debug('sssssssss ' + programList);
            Appcheckbox=[select Tour_Program_Approved__c from  Tour_Program__c where Id =: accountId].Tour_Program_Approved__c; //ouery on checkbox field
            addData.add(profileIdofBD2);//add to a list
            addData.add(programList);
            String stringcheckbox = String.valueOf(Appcheckbox);
            adddata.add(stringcheckbox);
            System.debug('addData ' + addData);
            return addData;   //return  the list
        }catch (Exception ex){
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
         }        
    }

}
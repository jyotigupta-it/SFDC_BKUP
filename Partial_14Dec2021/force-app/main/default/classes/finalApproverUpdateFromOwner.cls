public class finalApproverUpdateFromOwner {
    
    public static void  finalapproverisnert(list<opportunity> opplist) {
        try {
            System.debug('opplist....... '+opplist);
            set<id> oppOwnerid = new set<id>();
            if(opplist != null) {
                for(opportunity oppnewlist: opplist){
                    oppOwnerid.add(oppnewlist.OwnerId);  
                }
            }
            
            System.debug('oppOwnerid....... ' + oppOwnerid);
            
            list<opportunity> prolistoupdate = new list<opportunity>();
            Map<String, String> managerIdMap = new Map<String, String>();
            list<User> userList = new list<User>([SELECT Id, Project_Approver__c FROM User WHERE Id IN: oppOwnerid]);
            for(User usr : userList) {
                managerIdMap.put(usr.Id, usr.Project_Approver__c);
            }
            System.debug('managerIdMap....... ' + managerIdMap);
            for(Opportunity opp : opplist) {
                opp.User_Manager__c = managerIdMap.get(opp.OwnerId);
            }
        } catch(Exception ex) {
            System.debug('Exception Occured ' + ex);
        }
    }
}
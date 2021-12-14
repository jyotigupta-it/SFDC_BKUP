public class BdExpense {
@AuraEnabled
    public static list<String> fetchprofilename(Id accountId) {
        try {
              list<String> Stringlist= new List<String>();
              String profileID,AdminProfileId;
              profileId  = userinfo.getProfileId();//fetching profile id of login user
            system.debug('aaaaaaaaaa'+profileId);
            AdminProfileId=[select Id,Name from Profile where Name =:'System Administrator'].Id;//fetching profile id of system admin
            Stringlist.add(profileId);
            Stringlist.add(AdminProfileId);
             system.debug('vvvvvvvvvvv'+Stringlist);
             return Stringlist;
           } catch (Exception ex){
             throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
         }        
    }
}
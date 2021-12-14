/******************************************
 * Created By  : Ajeet Singh Shekhawat
 * Created On  : 04 Sep 2018
 * Modified By : 
 * Modified On : 04 Sep 2018
 * Description :  return type is wrapper class type which contains current user id along with Tour_Program__c object record
				
******************************************/ 


public class MassUpdateTourPlan {
    
    public class WrapMassUpdateTourPlan {
        @AuraEnabled public List<Tour_Program__c> tourDataWrapper {get; set;}
        @AuraEnabled public Id userIdWrapper {get; set;}
    }
    
	@AuraEnabled
    public static WrapMassUpdateTourPlan fetchTourProgramRecords (Id accountId) {
        try {
            
            Id userId;
            List<Tour_Program__c> tourData;
            userId = UserInfo.getUserId();
            tourData = [select ProfileId__c, Manager_ID__c, Tour_Program_Approved__c from Tour_Program__c 
                        	where Id =: accountId];
            
            WrapMassUpdateTourPlan wrapObject = new WrapMassUpdateTourPlan();
            wrapObject.tourDataWrapper = tourData;
            wrapObject.userIdWrapper = userId;
            System.debug('wrapObject ' + wrapObject);
            return wrapObject;
        } catch (Exception ex){
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }        
    }
}
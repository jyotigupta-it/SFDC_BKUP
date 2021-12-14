public class MessagingSessionTriggerHandler {
   public static void onAfterInsert(Map<Id,MessagingSession> mapOfMessages){
       MessagingSessionTriggerHelper.assignAccountToMessagingSession(mapOfMessages);
   }
    
}
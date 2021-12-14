public class SMSonTourPLANCreation {
    public static void smsSend(List<Ap_Tour_Plan__c> newTourPlanList){
        set<Id> uID=new set<Id>();
        for(Ap_Tour_Plan__c temp:newTourPlanList){
          uID.add(temp.CreatedById); 
        }
        List<User> usr=new List<User>();
        usr=[select id,name from user where id IN:uID];
        system.debug('user'+usr);
         Map<id,String> mUser=new Map<id,String>();
        for(User u:usr){
          mUser.put(u.id,u.name);  
        }
       system.debug('map'+mUser);
          string msgTemp= 'Dear Sir,\nWe are conducting @TourPlanName at @Place, @District on @PrmotionDate\n-@Owner\nFor More Information Contact:@number.';
        try{
        for(AP_Tour_Plan__c tourPlan:newTourPlanList){
             system.debug('entered ');
           // if(tourPlan.Promotional_Type__c!='')
            {
                  String msg= msgTemp.replace('@TourPlanName', tourPlan.Promotional_Type__c);
                          String OwnerName=string.valueOf(mUser.get(tourPlan.CreatedById)); 
                 system.debug('OwnerName '+OwnerName);
                           msg= msg.replace('@Owner',OwnerName);
                            
                            msg= msg.replace('@number',string.valueOf(tourPlan.Owner_Phone__c));
                            msg= msg.replace('@Place',string.valueOf(tourPlan.Location__c));   //tourPlan.)
                            msg= msg.replace('@District',string.valueOf(tourPlan.District__c));
                            msg= msg.replace('@PrmotionDate',string.valueOf(tourPlan.Date__c)); //format('dd/MMM/yyyy ')HH:mm:ss
                        
                            String msgEncoded= EncodingUtil.urlEncode(msg, 'UTF-8');

                            SendSMSController.sendMessage(tourPlan.Account_Contact_Number__c,msgEncoded);
                  
                            system.debug('entered the method');
                 system.debug('entered number'+tourPlan.Account_Contact_Number__c);
                  
                            //b.SMS_Sent__c = true; 
                
            } 
        }
        }
        catch(exception e){
            System.debug('The Error is '+e.getMessage()+'at Line Number'+e.getLineNumber());
        }
    }
}
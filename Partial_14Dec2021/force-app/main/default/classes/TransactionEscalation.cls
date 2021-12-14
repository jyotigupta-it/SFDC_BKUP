public class TransactionEscalation{
    public static void toSendEmail(String transId){
        if(transId != null && transId != ''){
            list<Messaging.SingleEmailMessage> mailList= new list<Messaging.SingleEmailMessage>();
            List<Transaction__c> transList = new List<Transaction__c>();
            List<User> ownerUserList = new List<User>();
            List<String> toAddressses = new List<String>();
            List<String> ccAddressses = new List<String>();            
            
            transList = [SELECT Id,Name,OwnerId,Owner.Name,Owner.Email,CreatedDate,(SELECT Id,Name,Bill_amount__c,Account__r.Name,Dealer__r.Name,Enterprise_points__c,Bonus_point__c,scheme_point__c,Bill_Image__c FROM Sales_Accrual_Transaction__r) FROM Transaction__c WHERE Id =:transId];
            ownerUserList = [SELECT Id,Name,Manager.Name,Manager.Email FROM User WHERE Id =:transList[0].OwnerId];
            toAddressses.add(ownerUserList[0].Manager.Email);
            ccAddressses.add(transList[0].Owner.Email);
            toAddressses.add('shantanu.vaidya@ashirvad.com');
            toAddressses.add('deepika@caritorsolutions.in');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Experts\' Club: Bill verification is pending for more than 2 days.');
            mail.setHtmlBody('<html><body>Hi '+ownerUserList[0].Manager.Name+',<br><br>'+
                             'Bills uploaded through the Experts\' Club App are pending for Mr. '+transList[0].Owner.Name+'\'s approval for more than 2 days in SFDC.<br>'+
                             'Kindly request Mr. '+transList[0].Owner.Name+' to verify approve/reject the pending bills at the earliest. Please find below the transaction details:<br><br>'+
                             'TGM Name: '+transList[0].Owner.Name+'<br>'+
                             +'Sales Accrual Name: '+transList[0].Sales_Accrual_Transaction__r[0].Name+'<br>'+
                             +'Transaction ID: '+transList[0].Name+'<br>'+
                             +'Transaction Amount: '+transList[0].Sales_Accrual_Transaction__r[0].Bill_amount__c+'<br>'+
                             +'Plumber Name: '+transList[0].Sales_Accrual_Transaction__r[0].Account__r.Name+'<br>'+
                             +'Dealer Name: '+transList[0].Sales_Accrual_Transaction__r[0].Dealer__r.Name+'<br>'+
                             +'Enterprise points: '+transList[0].Sales_Accrual_Transaction__r[0].Enterprise_points__c+'<br>'+
                             +'Bonus point: '+transList[0].Sales_Accrual_Transaction__r[0].Bonus_point__c+'<br>'+
                             +'Created Date: '+transList[0].CreatedDate+'<br><br>'+
                             +'Regards,<br>SFDC Support<br></html></body>');
            mail.setToAddresses(toAddressses);
            mail.setCcAddresses(ccAddressses);
            mail.setSenderDisplayName(transList[0].Owner.Name);
            mailList.add(mail);
            
            if(!mailList.isEmpty()){
                Messaging.SendEmail(mailList);
            }
        }
    }
}
public class AccountBatch {
   public static void toSendEmail(String accId){
        if(accId != null && accId != ''){
            list<Messaging.SingleEmailMessage> mailList= new list<Messaging.SingleEmailMessage>();
            List<Account> accList= new List<Account>();
            List<String> toAddressses = new List<String>{'manish.chaflesfdc@gmail.com'}; 
                
                accList=[select Id,Name,AccountNumber,Account.OwnerId,NumberOfEmployees,Phone,CreatedDate,(Select Id,Name,FirstName,LastName,Birthdate FROM Contacts) FROM Account where Id=: accId];
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('Account Details Verification');
            mail.setHtmlBody('<html><body>Hi '+accList[0].Name+',<br><br>'+
                             +'Contact Owner: '+accList[0].OwnerId+'The Details Of the transactions are <a href="'+accList[0].AccountNumber+'">Click For Details</a><br><br>'+
                             +'NumberOfEmployees: '+accList[0].NumberOfEmployees+'<br>'+ 
                             +'AccountNumber: ' +accList[0].AccountNumber+'<br>'+
                             +'FirstName'+accList[0].Contacts[0].FirstName+'<br>'+
                              +'LastName'+accList[0].Contacts[0].LastName+'<br>'+
                             +'CreatedDate: ' +accList[0].CreatedDate+'<br><br>'+
                              +'Regards,<br> Salesforce support</html></body>');
            
            mail.setToAddresses(toAddressses);
            mail.setSenderDisplayName(accList[0].Name);
            mailList.add(mail);
            
            if(!mailList.isEmpty()){
                Messaging.SendEmail(mailList);
            }
        }
    }
}
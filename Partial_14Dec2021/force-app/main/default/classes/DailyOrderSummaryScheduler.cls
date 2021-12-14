Public class DailyOrderSummaryScheduler implements Schedulable {
    public void execute(SchedulableContext SC) {
        list<order> todaysOrders = new list<order>();
        list<Account> dealerList = new list<Account>();
        list<Account> distributorList = new list<Account>();
        set<id> dealerIds = new set<id>();
        map<id,string> idAndEmail = new map<id,string>();
        set<id> distributorIds = new set<id>();
        todaysOrders = [select id,OrderNumber,AccountId from order where CreatedDate = TODAY and Account.Parent_Record_Type__c = 'Distributor' and RecordType.name = 'Portal'  ORDER BY CreatedDate];
        if(todaysOrders.size()>0){
            for(order o1 :todaysOrders){
                system.debug('OrderNumber=='+o1.OrderNumber);
                dealerIds.add(o1.AccountId);
            }
            dealerList = [select id,name, ParentId,Parent.Contact_Email__c from account where id in :dealerIds];
            if(dealerList.size()>0){
                for(account acc : dealerList){
                    system.debug('dealer name=='+acc.Name);
                    system.debug('dis email=='+acc.Parent.Contact_Email__c);
                    distributorIds.add(acc.ParentId);
                    idAndEmail.put(acc.ParentId, acc.Parent.Contact_Email__c);
                }
                Messaging.Email[] messages = new Messaging.Email[0];
                if(distributorIds.size()>0){
                    //   distributorList = [select id,]
                    for(id ids :idAndEmail.keySet()){
                        if(idAndEmail.get(ids) != null){
                            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                            
                            PageReference pdf = Page.DistributorPDF;
                            
                            pdf.getParameters().put('id',ids);
                            
                            pdf.setRedirect(true);
                            Blob b;
                            
                            if(!Test.isRunningTest()){
                                b = pdf.getContent();
                            }
                            else{
                                b = blob.valueOf('Unit test');
                            }
                            
                            
                            // Create the email attachment
                            
                            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                            
                            efa.setFileName('attachment.pdf');
                            
                            efa.setBody(b);
                            
                            String addresses;
                            
                            email.setSubject( 'Daily order report' );
                            system.debug('idAndEmail.get(ids)'+idAndEmail.get(ids));
                            string[] test = new String[] {idAndEmail.get(ids)};
                                
                                email.setToAddresses( test  );
                            string datev = string.valueOf(system.today()) ;
                            datev = datev.substring(0,10);
                            string tb = 'Hi';
                            tb += '\r\n';
                            tb += '\r\n';
							tb += 'Please find attached the order summary for '+datev;
                            tb += '\r\n';
                            tb +=  '\r\n';
                            tb += 'Thanks,';
                             tb +=  '\r\n';
                            tb += 'Ashirvad Pipes Pvt Ltd';
                            email.setPlainTextBody(tb );
                            
                            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                            
                            // Send it
                            messages.add(email);
                            
                       //     Messaging.SendEmailResult [] r =
                                
                        //        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                        }
                    }
                    Messaging.sendEmail(messages);
                }
            }
        }
        
    }
}
@isTest
public class OpportunityStageCheckTest {

    static testMethod void testMethod1() 
    {
        List<Opportunities__c> lstOpp= new List<Opportunities__c>();
        for(Integer i=0 ;i <200;i++)
        {
            Opportunities__c acc = new Opportunities__c();
            acc.Name ='Name'+i;
            acc.Stage__c='Technical Pre-Bid';
            //acc.LastModified_Difference__c=62;
            lstOpp.add(acc);
        }
        
        insert lstOpp;
        
        Opportunities__c oppc = new Opportunities__c();
            oppc.Name ='Namess';
            oppc.Stage__c='Technical Pre-Bid';
        insert oppc;
        for(Opportunities__c op:lstOpp){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        list<string> toAddressees1 = new list<string>();
                toAddressees1.add('suryapriya.s@kvpcorp.com');
     
            mail.setToAddresses(toAddressees1);
        mail.setSubject('Remainder on Opportunity Stage Changes ');
        
        mail.setPlainTextBody('Please go to the Opportunity  ' + op.Name + '  Where the Stage '+op.Stage__c+ ' is not changed for the last 2 months, So Kinldy check the Opportunity and '+
                              'Please find the link    ' +'https://appl-ashirvadpipes.lightning.force.com/'+op.id);

             //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
        
        
        Test.startTest();

            OpportunityStageCheckSchedular obj = new OpportunityStageCheckSchedular();
            obj.execute(null); 
            OpportunityStageCheckSchedular.testingcovering();
        Test.stopTest();
    }


}
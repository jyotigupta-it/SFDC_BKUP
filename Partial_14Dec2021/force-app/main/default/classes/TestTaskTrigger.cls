/** Company - Epeople Bespoke Consulting Private Limited.
Description -Test Class for Task Trigger
Created By  -Prabha.k 21/02/2014
Modified By -Sudha Murthy 5/3/2019
**/
@isTest
private class TestTaskTrigger {
    
    static testMethod void myUnitTest() {
        Test.StartTest();
        try{
            Account acc1=new Account();
            acc1.Name='tstacc';
            acc1.Contact_Email__c='tst@loa.com';
            acc1.Primary_Contact_Person_Name__c  ='Salesforce';
            acc1.PIN_Code__c='560045';
            acc1.Street_Address__c='Trinity Road';
            acc1.Party_Type__c='Architect';
            acc1.Contact_Number_Mobile__c = '9859000000';
            acc1.State__c = 'Rajasthan';
            acc1.District__c = 'Jaipur';
            acc1.City__c = 'Jaipur';
            acc1.Status__c = 'Prospective';
            acc1.Street_Address__c = 'HSR';
            acc1.Ramco_ID__c = '54';
            acc1.Year_Since_in_Business__c='2019';
            acc1.If_Yes_Products__c='test';
            acc1.If_others__c='test';
            acc1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            acc1.VAT_CST_Number__c='101010000000000';
            acc1.Conversion_Probability__c='High';
           // acc1.Parent.id=acc.id;
            acc1.PIN_Code__c='562106';
            acc1.UPVC_Discount__c=0;
            acc1.Column_Discount_Amount__c=0;
            acc1.Discount__c=0;
            acc1.SWR_Discount__c=0;
            acc1.System_Flag__c = true;
            
            insert acc1;
             acc1.City__c ='bangalore';
            update acc1;
            
            Enquiry__c testenq = new Enquiry__c(name='Test Company Name',Salutation__c='Mrs',City__c ='test',Last_Name__c='sample',Enquiry_Status__c='Open',Company__c='testcomp',District__c='tirunelveli',State__c='Tamilnadu',Mobile__c='9002432324',Email__c='test@gmail.com');
            insert testenq ;
            
            Enquiry__c testenq2 = new Enquiry__c(name='Test Company2 Name',Salutation__c='Mr',Last_Name__c='sample2',
                                                 Enquiry_Status__c='Open',Company__c='testcomp',City__c ='test',District__c='tirunelveli',
                                                 State__c='Tamilnadu',Mobile__c='9002432324',Email__c='test@gmail.com', Id = testenq.Id );
            update testenq2 ;
            
            Task t = new Task(subject=' Activity', BD_Comments__c='Good',Verification_Remarks__c='testRemarks',Status = 'Completed',whatId = testenq.id,Mobile__c=testenq.Mobile__c,Email_Address__c=testenq.Email__c);
            insert t;
            
            t.Verification_Remarks__c='testing remarks';
            update t;
            
            Task t1 = new Task(subject=' Activity1', BD_Comments__c='Bad',Verification_Remarks__c='documents are not submitted',Status = 'Not Completed',whatId = acc1.id,Mobile__c=testenq.Mobile__c,Email_Address__c=testenq.Email__c,Related_To_Type__c=acc1.id);
            insert t1;
            
            t1.Verification_Remarks__c='testing remarks';
            update t1;
            
            Task t2 = new Task(subject=' Activity2', BD_Comments__c='Average',Verification_Remarks__c='documents are not Valid',Status = 'Not Completed',whatId = testenq.id,Mobile__c=testenq.Mobile__c,Email_Address__c=testenq.Email__c);
            insert t2;
            
            t2.Verification_Remarks__c='testing remarks';
            update t2;
            
            /*************Promotions__c pm1=new Promotions__c(Type__c='Builders Meet',City__c='Bangalore',Date__c=System.Today(),Total_no_of_attendees__c=6.0,Total_Expenses__c=2000.0, Verification_Status__c='Suggestion',Call_Center_Remarks__c='Quotation is not sent');
            insert pm1;
            
            pm1.City__c='Mysore';
            update pm1;*****************/
            
            task t3=new task(subject=' Activity', BD_Comments__c='Good',Verification_Remarks__c='testRemarks',Status = 'Completed');
            insert t3;
            
            t3.subject='Activity4';
            update t3;
        }
        
        catch(Exception e){
            Test.StopTest();
            System.debug('EventTest......................' +e);
        }
    }
}
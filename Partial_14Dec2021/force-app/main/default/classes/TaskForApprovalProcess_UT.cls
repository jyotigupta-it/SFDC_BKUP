/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class TaskForApprovalProcess_UT{

    static testmethod void checkTaskForApproval(){
        
        List<case> caselist=new list<case>();
        Profile profileID = [select id from profile where Name='System Administrator' limit 1];

        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN113@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi113@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
           insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            Case case1= new Case(recordtypeId = i, Metro_Non_Metro__c=System.Label.Branding_Request_Non_Metro, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user2.id,Head_Office__c=user1.id);
            insert case1;   
            
            Case case2= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='Dispatched', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user2.id,Head_Office__c=user1.id);                

            insert case2;
            
            Case case3= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Recce Submitted by Vendor', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Branding_Team_Member__c= user2.id, vendor__c=user2.id, Approve_Check__c='True', Request_User__c=user2.id);                

            insert case3;
            
            Case case4= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status =System.Label.Branding_Request_Approved_by_Branding_Manager, origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    depo__c=user2.id,Branding_Team_Member__c= user1.id, Approve_Check__c='True',vendor__c=user2.id);                

            insert case4;
            
            Case case5= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status =System.Label.Branding_Request_Completed_By_BDM, origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Branding_Team_Member__c= user1.id, Approve_Check__c='True',vendor__c=user2.id);                

            insert case5;
            
            List<task> t=new List<Task>();
            
            task t1= new task(status='Not Started', whatid=case1.id);
            t.add(t1);
            task t2= new task(status='Not Completed', whatid=case2.id);
            t.add(t2);
            task t3= new task(status='Not Started', whatid=case3.id);
            t.add(t3);
            task t4= new task(status='In Progress', whatid=case4.id);
            t.add(t4);
            task t5= new task(status='In Progress', whatid=case5.id);
            t.add(t5);
            
            insert t;

            test.starttest();  
            
            case2.Is_In_Approval_Process__c=True;
            caselist.add(case2);
            
            case1.Is_In_Approval_Process__c=True;
            caselist.add(case1);
            
            case3.Is_In_Approval_Process__c=True;
            caselist.add(case3);
            
            case4.Is_In_Approval_Process__c=True;
            caselist.add(case4);
            
            case5.Is_In_Approval_Process__c=True;
            caselist.add(case5);
            
            update caselist;
            delete t;
            case2.Is_In_Approval_Process__c=false;
            update case2;
            case2.Is_In_Approval_Process__c=true;
            update case2;
            
            test.stoptest();
        }

    }
}
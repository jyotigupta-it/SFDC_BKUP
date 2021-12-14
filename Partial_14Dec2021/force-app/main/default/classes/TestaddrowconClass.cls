@isTest(seeAllData=false)
    Public Class TestaddrowconClass
    {
        
        static Account testacc;
        static Tour_Program__c t;
        static Tour_Plan1__c tp;
        static list<Site_Visit__c> siteList;
        static void init() {
            testacc=new Account();
            testacc.Name='tstacc';
            testacc.Contact_Email__c='tst@aol.com';
            testacc.Primary_Contact_Person_Name__c  ='SFDC';
            //testacc.Location__c='Bangalore';
            testacc.PIN_Code__c='560037';
            testacc.Street_Address__c='MG Road';
            testacc.Party_Type__c='Architect';
            testacc.Products__c ='COLUMN';
            testacc.Contact_Number_Mobile__c = '9000011111';
            insert testacc;
            
            t=new Tour_Program__c();            
            t.From_Date__c=date.newinstance(2017, 09, 16);
            t.To_Date__c=date.newinstance(2017, 09, 30);
            t.Tour_Program_Approved__c=True;
            insert t; 
               
            tp=new  Tour_Plan1__c();
            tp.Name='tour plan123'; 
            tp.Tour_Program__c=t.id;
            tp.Date__c=date.newinstance(2017, 09, 16);
            tp.State__c='Assam';     
            tp.Remarks_for_Not_meeting_the_Visit_Target__c ='TESTETSTESTETST';
            insert tp;
            
            siteList = new list<Site_Visit__c>();
            
            Site_Visit__c site1=new Site_Visit__c(
                                Date__c=date.newinstance(2017, 09, 16),
                                Tour_Plan1__c=tp.id,
                                Type__c='Visit',
                                Party_Name__c=testacc.id,
                                Party_Type__c='Architect',
                                Purpose_of_Visit__c='Enquiry',
                                Products__c='CPVC',
                                Architects_Meet_Actuals__c=1,
                                Boarers_Meet_Actuals__c=2,
                                Builders_Meet_Actuals__c=3);
           
            siteList.add(site1);
            
            Site_Visit__c site2=new Site_Visit__c(
                                Date__c=date.newinstance(2017, 09, 16),
                                Tour_Plan1__c=tp.id,
                                Type__c='Visit',
                                Party_Name__c=null,
                                Party_Type__c=null,
                                Purpose_of_Visit__c='Enquiry',
                                Products__c='CPVC',
                                Architects_Meet_Actuals__c=1,
                                Boarers_Meet_Actuals__c=2,
                                Builders_Meet_Actuals__c=3);
           
            siteList.add(site2);
            
        }
        Static TestMethod Void addrowcon()
        {
            
            Test.StartTest();               
            init();
            Site_Visit__c v=new Site_Visit__c();
            v.Date__c=date.newinstance(2017, 09, 16);
            v.Tour_Plan1__c=tp.id;
            v.Type__c='Visit';
            v.Party_Name__c=testacc.id;
            v.Party_Type__c='Architect';
            v.Purpose_of_Visit__c='Enquiry';
            v.Products__c='CPVC';
            v.Architects_Meet_Actuals__c=1;
            v.Boarers_Meet_Actuals__c=2;
            v.Builders_Meet_Actuals__c=3;            
           insert v;             
            PageReference pageRef = Page.VisitNewpage;
            Test.setCurrentPage(pageRef);
            pageRef.setredirect(true);
            pageRef .getParameters().put('id',v.id);
            Promotion__c  p=new  Promotion__c  (Site_Visit__c=v.id);                 
            insert p;
      
            addrowCon controller=new addrowCon();
            //controller.GotoParty();
            controller.vis=v;
            controller.num=1;
            controller.add_rows();
            controller.nameChanged();
            controller.donothing();
            controller.findstate();
            controller.save_closeadd();
            controller.getCount();
            controller.delRow();
            
            //controller.save_close();
            //controller.save_close1();
            //controller.createVisitEntry1();
            //controller.createVisitEntry3();
            //controller.createVisitEntry2();
            
            /*
        controller.delRow();
        controller.save_close();
        controller.save_close1();
        controller.createVisitEntry1();
        controller.createVisitEntry3();
        controller.createVisitEntry2();
         
      */
           Test.StopTest();
        }
        
        Static TestMethod Void test2() {
            init();
            Test.StartTest(); 
            Site_Visit__c v=new Site_Visit__c();
            v.Date__c=date.newinstance(2017, 09, 16);
            v.Tour_Plan1__c=tp.id;
            v.Type__c='Visit';
            v.Party_Name__c=testacc.id;
            v.Party_Type__c='Architect';
            v.Purpose_of_Visit__c='Enquiry';
            v.Products__c='CPVC';
            v.Architects_Meet_Actuals__c=1;
            v.Boarers_Meet_Actuals__c=2;
            v.Builders_Meet_Actuals__c=3;            
            //insert v;             
            PageReference pageRef = Page.VisitNewpage;
            Test.setCurrentPage(pageRef);
            pageRef.setredirect(true);
           // pageRef .getParameters().put('id',v.id);
           // Promotion__c  p=new  Promotion__c  (Site_Visit__c=v.id);                 
            //insert p;
      
            addrowCon controller=new addrowCon();
      //      controller.GotoParty();
            controller.vis=v;
            controller.num=1;
            controller.accts=siteList;
            controller.add_rows();
            //controller.nameChanged();
            controller.donothing();
            controller.findstate(); 
            controller.save_close();
     Site_Visit__c v5=new Site_Visit__c();
            v5.Date__c=date.newinstance(2017, 09, 16);
            v5.Tour_Plan1__c=tp.id;
            v5.Type__c='Visit';
            v5.Party_Name__c=testacc.id;
            v5.Party_Type__c='Architect';
            v5.Purpose_of_Visit__c='Enquiry';
            v5.Products__c='CPVC';
            v5.Architects_Meet_Actuals__c=1;
            v5.Boarers_Meet_Actuals__c=2;
            v5.Builders_Meet_Actuals__c=3;  
            addrowCon controller5=new addrowCon();  
        controller5.vis=v5;
         controller5.save_close();
        //  v5.Party_Type__c='';
        //   v5.Party_Name__c=null;
         //      controller5.save_close();
           
            controller.save_close1();
            
        //    controller.save_close1();
        Site_Visit__c v1=new Site_Visit__c();
            v1.Date__c=date.newinstance(2017, 09, 16);
            v1.Tour_Plan1__c=tp.id;
            v1.Type__c='Visit';
            v1.Party_Name__c=testacc.id;
            v1.Party_Type__c='Architect';
            v1.Purpose_of_Visit__c='Enquiry';
            v1.Products__c='CPVC';
            v1.Architects_Meet_Actuals__c=1;
            v1.Boarers_Meet_Actuals__c=2;
            v1.Builders_Meet_Actuals__c=3;   
addrowCon controller1=new addrowCon();  
controller1.vis=v1;     
            controller1.createVisitEntry3();
            controller.createVisitEntry2();
            controller.incrementCounter();
            controller.createVisitEntry();
       Site_Visit__c v4=new Site_Visit__c();
            v4.Date__c=date.newinstance(2017, 09, 16);
            v4.Tour_Plan1__c=tp.id;
            v4.Type__c='Visit';
            v4.Party_Name__c=testacc.id;
            v4.Party_Type__c='Architect';
            v4.Purpose_of_Visit__c='Enquiry';
            v4.Products__c='CPVC';
            v4.Architects_Meet_Actuals__c=1;
            v4.Boarers_Meet_Actuals__c=2;
            v4.Builders_Meet_Actuals__c=3;          
        addrowCon controller4=new addrowCon();  
        controller4.vis=v4; 
            controller4.createVisitEntry();
            Site_Visit__c v2=new Site_Visit__c();
            v2.Date__c=date.newinstance(2017, 09, 16);
            v2.Tour_Plan1__c=tp.id;
            v2.Type__c='Visit';
            v2.Party_Name__c=testacc.id;
            v2.Party_Type__c='Architect';
            v2.Purpose_of_Visit__c='Enquiry';
            v2.Products__c='CPVC';
            v2.Architects_Meet_Actuals__c=1;
            v2.Boarers_Meet_Actuals__c=2;
            v2.Builders_Meet_Actuals__c=3;   
addrowCon controller2=new addrowCon();  
controller2.vis=v2;     
            controller2.createPromotion();
            
    Site_Visit__c v3=new Site_Visit__c();
            v3.Date__c=date.newinstance(2017, 09, 16);
            v3.Tour_Plan1__c=tp.id;
            v3.Type__c='Visit';
            v3.Party_Name__c=testacc.id;
            v3.Party_Type__c='Architect';
            v3.Purpose_of_Visit__c='Enquiry';
            v3.Products__c='CPVC';
            v3.Architects_Meet_Actuals__c=1;
            v3.Boarers_Meet_Actuals__c=2;
            v3.Builders_Meet_Actuals__c=3;   
          //   Integer rowNum=1;
         //  String ShowAccountID='1212';
          //Boolean ShowReason=true;
  
addrowCon controller3=new addrowCon();  
controller3.vis=v3;             
         controller3.createVisitEntry1();  
            
            test.stopTest();
        } 
    }
@isTest
public class BrandingRequestTrigger_UT{

    static testmethod void updatestockAndDateTest(){

test.starttest();
List<user> usrlst=new List<User>();

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];
        List<case> caseList= new List<case>();
        
        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN001@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c='GUW100903');
        usrlst.add(user1);
        //insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi001@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c='GUW100903');

      usrlst.add(user2);
       
       //insert user2;   
      
          
        insert usrlst;
        
            Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
            Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();
            
            Account acc1=new Account(recordtypeId=ii,name ='testAccounttestyyy', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
                classification__c='C',district__c='Mysore',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
                state__c='Goa',ownerid = user1.id,Street_Address__c='xyzx',
                Contact_Number_Mobile__c='7156784489', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
                 );
                                           
            insert acc1;
           
           
            Recce_Cost_Setting__c recCost = new Recce_Cost_Setting__c();
            recCost.Cost_sqft__c=10;
            recCost.name='GUW100903-Vinyl';
            recCost.vendor_code__c='GUW100903';
            insert recCost;

             Vendor_Details__c ven = new Vendor_Details__c();
            ven.name ='XYZ';
            ven.vendor_code__c ='GUW100903';
            ven.Vendor__c=user1.id;
            insert ven;

            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;      
            
            Case casek= new Case(recordtypeId = nReq, Request_Raised_By__c = user1.id,
                    status =System.Label.Branding_Request_Completed, origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                
            casek.Vendor_Details__c=ven.id;
           // casek.Vendor_Details__r.Vendor_Code__c=ven.vendor_code__c;                  
            caseList.add(casek);
            
            Case casel= new Case(recordtypeId = nReq, Request_Raised_By__c = user1.id,
                    status =System.label.Branding_Request_Completed_by_Vendor, origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                
            casel.Vendor_Details__c=ven.id;
           // casel.Vendor_Details__r.Vendor_Code__c=ven.vendor_code__c;
            caseList.add(casel);
            
            Case casem= new Case(recordtypeId = nReq, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                
            casem.Vendor_Details__c=ven.id;
           // casem.Vendor_Details__r.Vendor_Code__c=ven.vendor_code__c;
            caseList.add(casem);
            
            insert caseList;
  List<Recce_Detail__c> rclst=new List<Recce_Detail__c>();
            
            Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
            recceRec.Height_in_Inches__c=1200;
            recceRec.Width_in_Inches__c=1000;
            recceRec.Job_Type__c='Vinyl';
            recceRec.Branding_Request__c=casek.id;
            //insert recceRec;
            rclst.add(recceRec);
            Recce_Detail__c recceRec2= new Recce_Detail__c();
            recceRec2.Updated_Height_in_Inches__c=0.00;
            recceRec2.Height_in_Inches__c=1200;
            recceRec2.Job_Type__c='Vinyl';
            recceRec2.Width_in_Inches__c=1000;
            recceRec2.Branding_Request__c=casel.id;
            //insert recceRec2;
            rclst.add(recceRec2);
            Recce_Detail__c recceRec3= new Recce_Detail__c();
            recceRec3.Updated_Height_in_Inches__c=0.00;
            recceRec3.Job_Type__c='Vinyl';
            recceRec3.Height_in_Inches__c=1200;
            recceRec3.Width_in_Inches__c=1000;
            recceRec3.Branding_Request__c=casem.id;
            //insert recceRec3;
            rclst.add(recceRec3);
            insert rclst;

 List<Branding_Request__c> brdlst=new List<Branding_Request__c>();
            
            RecordType rt=[SELECT Id FROM RecordType WHERE SObjectType='Branding_Request__c' AND Name='Branding Request' LIMIT 1];
            
            Branding_Request__c brand2= NEW Branding_Request__c(); 
            brand2.Branding_Products__c='All Products';
            brand2.Shop_Name__c=acc1.id;
            brand2.Branding_Request__c=casek.Id;
            brand2.Shop_Type__c='Repair/Rework Dealer';
            brand2.comments__c='';
            brand2.Branding_Sub_Products__c='SWR';
            brand2.Branding_Type__c='In Shop';
            brand2.Language__c='English';
            brand2.Shop_Description__c='zzzz';
            brand2.RecordType=rt;
            brand2.Branding_Request__c=casek.id;
            //insert brand2;
            brdlst.add(brand2);
            Branding_Request__c brand3= NEW Branding_Request__c(); 
            brand3.Branding_Products__c='All Products';
            brand3.Shop_Name__c=acc1.id;
            brand3.comments__c='';
            brand3.Branding_Request__c=casel.Id;
            brand3.Shop_Type__c='Repair/Rework Dealer';
            brand3.Branding_Sub_Products__c='SWR';
            //brand3.Branding_Type__c='In Shop';
            brand3.Language__c='English';
            brand3.Shop_Description__c='zzzz';
            brand3.RecordType=rt;
            //insert brand3;
            brdlst.add(brand3);
            Branding_Request__c brand4= NEW Branding_Request__c(); 
            brand4.Branding_Products__c='All Products';
            brand4.Shop_Name__c=acc1.id;
            brand4.comments__c='';
            brand4.Branding_Request__c=casem.Id;
            brand4.Shop_Type__c='Repair/Rework Dealer';
            brand4.Branding_Sub_Products__c='SWR';
            brand4.Language__c='English';
            brand4.Shop_Description__c='zzzz';
            brand4.RecordType=rt;
            //insert brand4;
            brdlst.add(brand4);

           insert brdlst;
            List<case> upCase = new List<case>();
       
        System.runas(usrlst[1]){
        //system.runas(user2){    
       caseList.clear();     
      
           // BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
                      
            casek.Team_Lead__c = user2.id;
            update casek;
        
        upCase.add(casek);
            casel.Vendor_Details__c=ven.id;
            casel.Branding_Team_Member__c = user1.id;
            casel.Branding_Manager__c=user2.id;
            upCase.add(casel);
            
            casem.Vendor_Details__c=ven.id;
            casem.Team_Lead__c = user2.id;
            casem.Vendor__c = user1.id;
            upCase.add(casem);
            update upCase;   
            test.stoptest();  
            }

    }

    
    
    
    
    
    
    static testmethod void updatestockAndDateTest0(){
test.starttest(); 
        Profile profileID = [select id from profile where Name='System Administrator' limit 1];
        List<case> caseList= new List<case>();
        
        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN002@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c='GUW100903');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi002@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
       insert user2;  
       
        Recce_Cost_Setting__c recCost = new Recce_Cost_Setting__c();
            recCost.Cost_sqft__c=10;
            recCost.name='GUW100903-Vinyl';
            recCost.vendor_code__c='GUW100903';
            insert recCost;
         
         

             Vendor_Details__c ven = new Vendor_Details__c();
            ven.name ='XYZ11';
            ven.vendor_code__c ='GUW100903';
            ven.Vendor__c=user1.id;
            insert ven;
             
              Vendor_Details__c ven1 = new Vendor_Details__c();
            ven1.name ='XYZ22';
            ven1.vendor_code__c ='GUW100904';
            ven1.Vendor__c=user2.id;
            insert ven1;
      
        system.runas(user1){
        
            Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
            Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();
            
            Account acc1=new Account(recordtypeId=ii,name ='testAccounttestyyy', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
                classification__c='C',district__c='Mysore',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
                state__c='Goa', ownerid = user1.id,Street_Address__c='xyzx',
                Contact_Number_Mobile__c='7156784489',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
                 );
                                          
            insert acc1;

            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            Case caset= new Case(recordtypeId = nReq, Request_Raised_By__c = user1.id,Approve_Check__c='True',
                    status =System.label.Branding_Request_Recce_Submitted_by_Vendor, origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            caset.Vendor_Details__c=ven.id;
                  
            
            
            insert caset;
            
            
        
           // BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            caset.Vendor_Details__c=ven1.id;
            update caset;       
            
       test.stoptest();
        }

    }
static testmethod void updatestockAndDateTest1(){

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];
        List<case> caseList= new List<case>();
        
        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN003@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi003@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
       insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            caseList.add(caset);      
            
            Case casel= new Case(recordtypeId =i, Request_Raised_By__c = user1.id,
                    status ='Auto Approved', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                
            caseList.add(casel);
            
            insert caseList;
                       
            inventory__c testinv = new Inventory__c();
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c=System.label.GIFT_ITEMS;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();
            inv.Inventory_Request_Number__c = caset.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';
            Insert inv;
           
            
            Inventory_request__c inv1 = new Inventory_request__c();
            inv1.Inventory_Request_Number__c = caset.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';
            Insert inv1;
            
            Inventory_request__c inv2 = new Inventory_request__c();
            inv2.Inventory_Request_Number__c = casel.id;
            inv2.Request_Rasied_by__c = user1.id;
            inv2.Type_of_Item__c = testinv.id;
            inv2.Required_Quantity__c=50;
            inv2.Quantity_Dispatched__c=50;
            inv2.Comments_Remarks__c='Testing';
            Insert inv2;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            caset.status='Corrected Dispatch';
            update caset;
            
            caset.status='Completed';
            update caset;

            casel.status='Completed';
            update casel;       
                      
       test.stoptest();
        }

    }
/*static testmethod void updatestockAndDateTest2(){

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];
        List<case> caseList= new List<case>();
        
        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN004@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi004@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
       insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
            //List<id> recordtypeid = new List<id>();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            //insert caset;
            caseList.add(caset);  
        
            Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id, Head_Office__c=user1.id,depo__c=user1.id, Request_User__c=user2.id); 
                    
            //insert casej;
            caseList.add(casej);       
            Case casek= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Recce Approved by Branding team', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

           // insert casek;
            caseList.add(casek);

            insert caseList;
            
            Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
           // recceRec.Updated_Width_in_Inches__c
            recceRec.Height_in_Inches__c=1200;
            recceRec.Width_in_Inches__c=1000;
            recceRec.Branding_Request__c=casek.id;
           
            insert recceRec;
            
            inventory__c testinv = new Inventory__c();
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c=System.label.GIFT_ITEMS;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';

            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();

            inv.Inventory_Request_Number__c = caset.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';

            Insert inv;
           
            
            Inventory_request__c inv1 = new Inventory_request__c();

            inv1.Inventory_Request_Number__c = casej.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';

            Insert inv1;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            caset.status='Corrected Dispatch';
            update caset;
            
            caset.status='Dispatched';
            update caset;
            
            caset.status='Completed';
            update caset;
            
           
            casek.origin='Recce Approved by Branding team';
            update casek;   
            
       test.stoptest();
        }

    }*/
    
static testmethod void updatestockAndDateTest3(){

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];

        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN005@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi005@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
           insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
            //List<id> recordtypeid = new List<id>();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            /*Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            insert caset; */   
        
            Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id, Head_Office__c=user1.id,depo__c=user1.id, Request_User__c=user2.id); 
                    
             insert casej;        
            Case casek= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Completed', origin='Self', Priority='Medium', Is_In_Approval_Process__c =False,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert casek;
            
            Case case4= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Recce Submitted by Vendor', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case4;
            
            Case case5= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Completed by Vendor', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case5;
          
            
            /*Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
           // recceRec.Updated_Width_in_Inches__c
            recceRec.Height_in_Inches__c=12;
            recceRec.Width_in_Inches__c=10;
            recceRec.Branding_Request__c=casej.id;
            
            insert recceRec;*/
            
            inventory__c testinv = new Inventory__c();
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c=System.label.GIFT_ITEMS;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';

            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();

            inv.Inventory_Request_Number__c = casek.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';

            Insert inv;
           
            
            Inventory_request__c inv1 = new Inventory_request__c();

            inv1.Inventory_Request_Number__c = casej.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';

            Insert inv1;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            casek.origin='Self';
            update casek;
            
            case4.origin='Auto Creation';
            update case4;
            
            case5.origin='User';
            update case5;
            

       test.stoptest();
        }

    }    
    
    
    static testmethod void updatestockAndDateTest4(){

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];

        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN006@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi006@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
           insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
            //List<id> recordtypeid = new List<id>();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            /*Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            insert caset; */   
        
            Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id, Head_Office__c=user1.id,depo__c=user1.id, Request_User__c=user2.id); 
                    
             insert casej;        
            Case casek= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Completed By BDM', origin='Self', Priority='Medium', Is_In_Approval_Process__c =False,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert casek;
            
            Case case4= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Approved by TL', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case4;
            
            Case case5= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Approved by Branding Team', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case5;
            
            Case case6= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Recce Submitted by Vendor', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case6;
            
            Case case7= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Completed By BDM', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case7;
    
            /*Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
           // recceRec.Updated_Width_in_Inches__c
            recceRec.Height_in_Inches__c=12;
            recceRec.Width_in_Inches__c=10;
            recceRec.Branding_Request__c=casej.id;
            
            insert recceRec;*/
            
            inventory__c testinv = new Inventory__c();
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c=System.label.GIFT_ITEMS;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';

            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();

            inv.Inventory_Request_Number__c = casek.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';

            Insert inv;
           
            
            Inventory_request__c inv1 = new Inventory_request__c();

            inv1.Inventory_Request_Number__c = casej.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';

            Insert inv1;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            casek.Is_In_Approval_Process__c=True;
            update casek;
            
            case4.Is_In_Approval_Process__c=True;
            update case4;

       test.stoptest();
        }

    } 
    
    
    
    static testmethod void updatestockAndDateTest5(){

        Profile profileID = [select id from profile where Name='System Administrator' limit 1];

        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN007@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi007@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
           insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
            //List<id> recordtypeid = new List<id>();
            Id nReq=[Select id from RecordType where Name ='Branding Request'and SobjectType = 'case'].id;
            
            /*Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id);
            insert caset; */   
            
            Case case5= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Approved by Branding Team', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case5;
            
            Case case6= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Recce Submitted by Vendor', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case6;
            
            Case case7= new Case(recordtypeId =nReq, Request_Raised_By__c = user1.id,
                    status ='Completed By BDM', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Approve_Check__c='True',depo__c=user2.id, Request_User__c=user2.id);                

            insert case7;
    
            /*Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
           // recceRec.Updated_Width_in_Inches__c
            recceRec.Height_in_Inches__c=12;
            recceRec.Width_in_Inches__c=10;
            recceRec.Branding_Request__c=casej.id;
            
            insert recceRec;*/
            
            inventory__c testinv = new Inventory__c();
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c=System.label.GIFT_ITEMS;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';

            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();

            inv.Inventory_Request_Number__c = case5.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';

            Insert inv;
           
            
            Inventory_request__c inv1 = new Inventory_request__c();

            inv1.Inventory_Request_Number__c = case6.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';

            Insert inv1;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            case5.Is_In_Approval_Process__c=True;
            update case5;
            
            case6.Is_In_Approval_Process__c=True;
            update case6;

       test.stoptest();
        }

    }       
 
    static testmethod void updatestockAndDateTest6(){
       
        Profile profileID = [select id from profile where Name='System Administrator' limit 1];

        User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN008@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');

        insert user1;
        
        User user2 = new User(LastName='XYZ123',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi008@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
           insert user2;
      
        system.runas(user1){
            Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
            Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();

            Id i= AccountRecordTypeInfo.get('Collateral Request').getRecordTypeId();
            Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
            //Id nReq=[Select id from RecordType where Name ='Distributor'].id;
            
            Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id,Head_Office__c=user1.id,depo__c=user1.id);
            insert caset;    
        
            Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user1.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id, Head_Office__c=user1.id,depo__c=user1.id, Request_User__c=user2.id); 
                    
             insert casej;        
            Case casek= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
                    status ='Auto Approved', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =user1.id, depo__c=user2.id, Request_User__c=user2.id);                

            insert casek;
            
            /*Recce_Detail__c recceRec= new Recce_Detail__c();
            recceRec.Updated_Height_in_Inches__c=0.00;
           // recceRec.Updated_Width_in_Inches__c
            recceRec.Height_in_Inches__c=12;
            recceRec.Width_in_Inches__c=10;
            recceRec.Branding_Request__c=caset.id;
            
            insert recceRec;*/
            
            inventory__c testinv = new Inventory__c();
            //testinv.name ='captest';
            testinv.opening_stock__c =100;
            testinv.Closing_Stocks__c=100;
            testinv.Dispatch_Size__c=50;
            testinv.Owner_Account__c = user1.id;
            testinv.Received_Stock__c = 0;
            testinv.Threshold__c=50;
            testinv.Used_Stock__c=0;
            testinv.type__c='Product Collateral';
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';
            insert testinv;
            
            inventory__c testinv2 = new Inventory__c();
            testinv2.opening_stock__c =100;
            testinv2.Closing_Stocks__c=1000;
            testinv2.Dispatch_Size__c=50;
            testinv2.Owner_Account__c = user2.id;
            testinv2.Received_Stock__c = 0;
            testinv2.Threshold__c=50;
            testinv2.Used_Stock__c=0;
            testinv.product_description__c='Flexible';
            testinv.Color_Language_Size__c='RED';

            insert testinv2;

            Inventory_request__c inv = new Inventory_request__c();

            inv.Inventory_Request_Number__c = caset.id;
            inv.Request_Rasied_by__c = user1.id;
            inv.Type_of_Item__c = testinv.id;
            inv.Required_Quantity__c=50;
            inv.Quantity_Dispatched__c=50;
            inv.Comments_Remarks__c='Testing';

            Insert inv;
            
            Inventory_request__c inv1 = new Inventory_request__c();

            inv1.Inventory_Request_Number__c = casej.id;
            inv1.Request_Rasied_by__c = user1.id;
            inv1.Type_of_Item__c = testinv2.id;
            inv1.Required_Quantity__c=50;
            inv1.Quantity_Dispatched__c=50;
            inv1.Comments_Remarks__c='Testing';

            Insert inv1;

       test.starttest();  
            BrandingRequestTrigger BrandReq= new BrandingRequestTrigger();
            
            caset.status='Corrected Dispatch';
            update caset;
            
            caset.status='Dispatched';
            update caset;
            
            caset.status='Completed';
            update caset;
            
            casej.status='Completed';
            update casej;
 
       test.stoptest();
        }

    }
    
    

}
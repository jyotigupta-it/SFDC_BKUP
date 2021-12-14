global with sharing class CustomLookupForProject
{
    
    public CustomLookupForProject(APPL_NEW_PROMOTION_CTRL_Modified controller) {
        
    }
    public CustomLookupForProject(APPL_SITEVISIT_CALENDAR_CTRL controller) {
        
    }
    
    
    
    
    //--------from lookuppopup page controller------------------------------------------------
    // the query string entered by the user
    public String Talukquery {get; set;}
    public String TalukNewquery {get; set;}
    public static String partyTypeFilter{get; set;}
    public String Userquery {get; set;}
    public String Pincodequery {get; set;}
    //  AP_Site_Visit__c visitList;
    public String searchUser {get; set;}  
    public String ProjectQuery {get; set;}  
    public String ContactQuery {get; set;}  
    public String orderFilterQuery {get; set;}
    public String orderFilterQuery2 {get; set;}
    public String orderFilterPostQuery {get; set;}
    public String influencerDetailSearch {get; set;}
    public String applOfferDistributor {get; set;}
    public String applSupplyDistributor {get; set;}
    public String applSupplyProductName {get; set;}
    public String DistributorQuery{set;get;}
    public List<Contact> contactAccounts {get; set;}
    //  public String smartKRAQuery {get; set;}      
    // the matchin>g TalukList
    public List<AP_Taluk_Master__c> TalukList {get; set;}
    public List<AP_Taluk_Master__c> TalukListNew {get; set;}
    // the matchin>g TalukList
    public List<Pincode__c> PincodeList {get; set;}
    public List<User> UserList{get;set;}
    // public List<User> smartKRAUserList{get;set;}
    // has a search been executed?
    public Boolean doneLookup {get; set;}    
    // the query string entered by the user
    public String orderQuery {get; set;}
    public String orderQuerydist {get; set;}
    // the matchin>g accounts
    public List<Account> orderAccounts {get; set;}
    public List<Account> orderFilterAccounts {get; set;}
    public List<Account> orderFilterAccounts2 {get; set;}
    public List<Account> orderFilterPostAccounts {get; set;}
    public List<Account> ProjectAccounts {get; set;}
    public List<User> userMeetingList {get; set;}
    public List<Account> ApplOfferDistributorList {get; set;}
    public string dealerqry{get;set;}
    public list<Account> dealeracc{get;set;}
    public string distrqry{get;set;}
    public string distrqrypromo{get;set;}
    public list<Account> distracc{get;set;}
    public string talukJuncQry{get;set;}
    public list<User_Taluk_Master_Junction__c> talukJuncList{get;set;}
    public string projQry{get;set;}
    public list<Opportunity> oppqryList{get;set;} 
    public string dealerPromqry{get;set;}
    public list<Account> dealerPromacc{get;set;}
    public List<Account> influDetailByFilterAccounts {get; set;}
    public List<Account> ApplSupplyDistributorList {get; set;}
    public List<Product2> ApplSupplyProductNameList {get; set;}
    public List<Account> DistributorAccounts {get; set;}
    // fro Project By Section Lookup
    public String projectByFilterQuery {get; set;}
    public List<Account> projectByFilterAccounts {get; set;}
    
    public CustomLookupForProject(Apexpages.Standardcontroller controller) {
        //  partyTypeFilter = 'Borer';
        System.debug('coming inside constructor');
        //  visitList = (AP_Site_Visit__c)controller.getRecord();
        //  System.debug('coming inside constructor ' + visitList);
    }
    
    // executes the search for "Project By Section Lookup"
    public void runProjectByFilterQuery()
    {   
        System.debug('coming inside project by ' + projectByFilterQuery);
        
        if(projectByFilterQuery != null) {
            projectByFilterQuery = projectByFilterQuery.trim();
        }
        
        String nameCond = '%'+projectByFilterQuery+'%';
        String cond = projectByFilterQuery+'%';
        
        projectByFilterAccounts  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                                  Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c,
                                                                  Status__c, Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') 
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        projectByFilterAccounts.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +projectByFilterAccounts);
    }
    
    // executes the search for "Project By Section Lookup"
    public void runInfluencerDetailQuery()
    {   
        //   System.debug('coming inside project by ' + projectByFilterQuery);
        if(influencerDetailSearch != null) {
            influencerDetailSearch = influencerDetailSearch.trim();
        }   
        
        String nameCond = '%'+influencerDetailSearch+'%';
        String cond = influencerDetailSearch+'%';
        
        influDetailByFilterAccounts  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                                  Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c,
                                                                  Status__c, Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') 
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        influDetailByFilterAccounts.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +influDetailByFilterAccounts);
    }
    
    // executes the search for "APPL Offer Section's Distributor Lookup"
    public void runApplOfferDistributor()
    {   
        System.debug('coming inside applOfferDistributor ' + applOfferDistributor);
        if(applOfferDistributor != null) {
            applOfferDistributor = applOfferDistributor.trim();
        }
        
        String nameCond = '%'+applOfferDistributor+'%';
        String cond = applOfferDistributor+'%';
        ApplOfferDistributorList  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                                  Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                                  Status__c, Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') 
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ApplOfferDistributorList.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +ApplOfferDistributorList);
    }
    public void runApplOfferDistributorproject()
    {   
        System.debug('coming inside applOfferDistributor ' + applOfferDistributor);
        if(applOfferDistributor != null) {
            applOfferDistributor = applOfferDistributor.trim();
        }
        
        String nameCond = '%'+applOfferDistributor+'%';
        String cond = applOfferDistributor+'%';
        
        ApplOfferDistributorList  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                                  Party_type__c,
                                                                  Contact_Number_Mobile__c, State__c, District__c, City__c, Status__c,
                                                                  Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') 
                                                                  AND Party_type__c='Distributor'
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ApplOfferDistributorList.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +ApplOfferDistributorList);
    }
    
    // executes the search for "APPL Supply Section's Distributor Lookup"
    public void runApplSupplyDistributor()
    {   
        System.debug('coming inside applOfferDistributor ' + applSupplyDistributor);
        if(applSupplyDistributor != null) {
            applSupplyDistributor = applSupplyDistributor.trim();
        }
        
        String nameCond = '%'+applSupplyDistributor+'%';
        String cond = applSupplyDistributor+'%';
        
        ApplSupplyDistributorList  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                                  Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c,
                                                                  Status__c, Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') 
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ApplSupplyDistributorList.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +ApplOfferDistributorList);
    }
    
    public void runApplSupplyDistributorproject()
    {   
        System.debug('coming inside applOfferDistributor ' + applSupplyDistributor);
        if(applSupplyDistributor != null) {
            applSupplyDistributor = applSupplyDistributor.trim();
        }
        
        String nameCond = '%'+applSupplyDistributor+'%';
        String cond = applSupplyDistributor+'%';
        
        ApplSupplyDistributorList  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                                  Party_type__c,
                                                                  Contact_Number_Mobile__c, State__c, District__c, City__c, Status__c,
                                                                  Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE (Recordtype.Name='Distributor' OR 
                                                                                      Recordtype.Name='Projects' OR 
                                                                                      Recordtype.Name='Individual Contacts' 
                                                                                      OR Recordtype.Name='Key Accounts') AND 
                                                                  Party_type__c='Distributor'
                                                                  AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                       Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ApplSupplyDistributorList.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +ApplOfferDistributorList);
    }
    
    // executes the search for "APPL Supply Section's Product Name Lookup"
    public void runApplSupplyProductName()
    {   
        System.debug('coming inside applOfferDistributor ' + applSupplyProductName);
        ApplSupplyProductNameList  = new List<Product2>();
        List<Product2> searchFilterPostResults= New List<Product2>([SELECT Id, Name, ProductCode, Description, Family  
                                                                    FROM Product2 WHERE name LIKE: applSupplyProductName+'%' limit 200]);
        
        ApplSupplyProductNameList.addAll(searchFilterPostResults);
        System.debug('coming inside project by ******* ' +ApplSupplyProductNameList);
    }
    
    // executes the search
    public void runOrderQuery()
    {   
        System.debug('coming inside');
        if(orderQuery != null) {
            orderQuery = orderQuery.trim();
        }
        
        String nameCond = '%'+orderQuery+'%';
        String cond = orderQuery+'%';
        orderAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                        Party_type__c, Contact_Number_Mobile__c, State__c,
                                                        District__c, City__c, Status__c, Street_Address__c, Ramco_ID__c 
                                                        FROM Account WHERE Party_type__c='Distributor' 
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        orderAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +orderAccounts);
        
    }
    public void runOrderQueryinfluencer()
    {   
        System.debug('coming inside');
        if(orderQuery != null) {
            orderQuery = orderQuery.trim();
        }
        
        String nameCond = '%'+orderQuery+'%';
        String cond = orderQuery+'%';
        
        orderAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                        Party_type__c, Contact_Number_Mobile__c, State__c,
                                                        District__c, City__c, Status__c, Street_Address__c, 
                                                        Ramco_ID__c  FROM Account WHERE 
                                                        (Party_type__c='Distributor' OR Party_type__c='Architect' OR 
                                                         Party_type__c='Contractor' OR Party_type__c='Plumbing Contractor' 
                                                         OR Party_type__c='Project Manager' OR 
                                                         Party_type__c='Purchase Manager'OR Party_type__c=' Site Engineer' OR
                                                         Party_type__c='Project Owner/Developer' OR  
                                                         Party_type__c='Plumbing Consultant' or Party_type__c='Consultant' ) 
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        orderAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +orderAccounts);
        
    }
    public void runOrderQueryfordist()
    {   
        System.debug('coming inside');
        if(orderQuerydist != null) {
            orderQuerydist = orderQuerydist.trim();
        }
        
        String nameCond = '%'+orderQuerydist+'%';
        String cond = orderQuerydist+'%';
        
        orderAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                        Party_type__c, Contact_Number_Mobile__c, State__c,
                                                        District__c, City__c, Status__c, Street_Address__c,
                                                        Ramco_ID__c  FROM Account WHERE  Party_type__c ='Distributor'
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        orderAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +orderAccounts);
        
    }
    
    // executes the search for "Project By"
    public void runProjectQuery()
    {   
        System.debug('coming inside');
        if(ProjectQuery != null) {
            ProjectQuery = ProjectQuery.trim();
        }
        
        String nameCond = '%'+ProjectQuery+'%';
        String cond = ProjectQuery+'%';
        
        ProjectAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                        Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                        Status__c, Street_Address__c, Ramco_ID__c FROM Account 
                                                        WHERE (Recordtype.Name='Distributor' OR Recordtype.Name='Projects' 
                                                               OR Recordtype.Name='Individual Contacts' OR Recordtype.Name='Key Accounts')
                                                        AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ProjectAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +ProjectAccounts);
        
    }
    public void runProjectQuery1()
    {   
        System.debug('coming inside');
        if(ProjectQuery != null) {
            ProjectQuery = ProjectQuery.trim();
        }
        
        String nameCond = '%'+ProjectQuery+'%';
        String cond = ProjectQuery+'%';
        
        ProjectAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                        Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                        Status__c, Street_Address__c, Ramco_ID__c FROM Account 
                                                        WHERE (Recordtype.Name='Distributor' OR Recordtype.Name='Dealer' 
                                                               OR Recordtype.Name='Individual Contacts' OR Recordtype.Name='Key Accounts' 
                                                               OR Recordtype.Name='Branding - Vendor Account' OR Recordtype.Name='Plumber Club Enrollment'
                                                               OR Recordtype.Name ='Industrial Account')
                                                        AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        ProjectAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +ProjectAccounts);
        
    }
      public void runContactQuery1()
    {   
        System.debug('coming inside');
        if(ContactQuery != null) {
            ContactQuery = ContactQuery.trim();
        }
        
        String nameCond = '%'+ContactQuery+'%';
        String cond = ContactQuery+'%';
        
        contactAccounts  = new List<Contact>();
        List<Contact> searchResults= New List<Contact>([SELECT Id,Name,Account.Name,Email,Phone FROM Contact WHERE (Name LIKE :nameCond OR Account.Name LIKE :cond OR Email LIKE :cond OR Phone LIKE :cond ) Limit 200]);
        
        contactAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +contactAccounts);
        
    }
    //added by Subhajit Ghosh --  KVP
    public void runDistributorQuery()
    {   
        System.debug('coming inside');
        if(DistributorQuery != null) {
            DistributorQuery = DistributorQuery.trim();
        }
        
        String nameCond = '%'+DistributorQuery+'%';
        String cond = DistributorQuery+'%';
        
        DistributorAccounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                        Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                        Status__c, Street_Address__c, Ramco_ID__c FROM Account 
                                                        WHERE (Recordtype.Name='Distributor' OR Recordtype.Name='Projects' 
                                                               OR Recordtype.Name='Individual Contacts' OR Recordtype.Name='Key Accounts')
                                                        AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        DistributorAccounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +DistributorAccounts);
        
    }
    
    // executes the search for "Smart KRA"
    /*
public void runSmartKRAQuery()
{    System.debug('coming inside');
smartKRAUserList = new List<User>();
list<User> KRAUsers= [select id, Name,title,phone,Email from User where name lIKE:smartKRAQuery +'%' limit 500]; 

smartKRAUserList.addAll(KRAUsers);
System.debug('coming inside runQuery ' +smartKRAUserList);

}  */
    
    // executes the search for Visit Section
    public void runOrderFilterQuery()
    {  // partyTypeFilter = 'Borer';
        System.debug('coming inside partyTypeFilter +*+++++++++++ ' + partyTypeFilter);
        System.debug('coming inside runOrderFilterQuery 2 +*+++++++++++ ' + orderFilterQuery);
        
        if(orderFilterQuery != null) {
            orderFilterQuery = orderFilterQuery.trim();
        }
        
        String nameCond = '%'+orderFilterQuery+'%';
        String cond = orderFilterQuery+'%';
        
        orderFilterAccounts  = new List<Account>();
        String str = 'Borer';
       
        List<Account> searchFilterResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                              Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                              Status__c, Street_Address__c, Ramco_ID__c  FROM Account WHERE 
                                                              Party_type__c = :partyTypeFilter AND
                                                              (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                               Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        orderFilterAccounts.addAll(searchFilterResults);
        System.debug('coming inside orderFilterAccounts ' +orderFilterAccounts);
        
    }
    
    // executes the search for Visit Section 2
    public void runOrderFilterQuery2()
    {   
        System.debug('coming inside partyTypeFilter2 +*+++++++++++ ' + partyTypeFilter);
        System.debug('coming inside runOrderFilterQuery2 2 +*+++++++++++ ' + orderFilterQuery2);
        
        if(orderFilterQuery2 != null) {
            orderFilterQuery2 = orderFilterQuery2.trim();
        }
        
        String nameCond = '%'+orderFilterQuery2+'%';
        String cond = orderFilterQuery2+'%';
        
        orderFilterAccounts2  = new List<Account>();
        //  String str = 'Borer';
        List<Account> searchFilterResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c,
                                                              Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, 
                                                              Status__c,
                                                              Street_Address__c, Ramco_ID__c  
                                                              FROM Account WHERE Party_type__c =: partyTypeFilter 
                                                              AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                   Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        System.debug('coming inside searchFilterResults ' +searchFilterResults);
        orderFilterAccounts2.addAll(searchFilterResults);
        System.debug('coming inside orderFilterAccounts ' +orderFilterAccounts2);
        
    }
    
    // executes the search for "Post Visit Order"
    public void runOrderFilterPostQuery()
    {   
        System.debug('coming inside');
        
        if(orderFilterPostQuery != null) {
            orderFilterPostQuery = orderFilterPostQuery.trim();
        }
        
        String nameCond = '%'+orderFilterPostQuery+'%';
        String cond = orderFilterPostQuery+'%';
        
        orderFilterPostAccounts  = new List<Account>();
        List<Account> searchFilterPostResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c, Primary_Contact_Person_Name__c, 
                                                                  Party_type__c, Contact_Number_Mobile__c, State__c, District__c, 
                                                                  City__c, Status__c, Street_Address__c, Ramco_ID__c  
                                                                  FROM Account WHERE Party_type__c =: partyTypeFilter AND (Name LIKE :nameCond OR City__c LIKE :cond OR 
                                                                                                                           District__c LIKE :cond OR 
                                                                                                                           Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        
        orderFilterPostAccounts.addAll(searchFilterPostResults);
        System.debug('coming inside runQuery ' +orderFilterPostAccounts);
        
    }
    
    // executes the search
    public void Searchqueryfortaluk()
    {  
        System.debug('coming inside');
        TalukList = new List<AP_Taluk_Master__c>();
        list<AP_Taluk_Master__c> Taluks = [select id, Name, Cluster__c, District__c,
                                           State__c from AP_Taluk_Master__c where name lIKE:Talukquery+'%' limit 200]; 
        
        TalukList.addAll(Taluks);
        System.debug('coming inside runQuery ' +TalukList);
        // return TalukList;
        
    }
    
    // executes the search for "Please Select the Taluk" on click of New button
    public void SearchqueryforNewtaluk()
    {  
        System.debug('coming inside');
        TalukListNew = new List<AP_Taluk_Master__c>();
        list<AP_Taluk_Master__c> Taluks = [select id, Name, Cluster__c, District__c,
                                           State__c from AP_Taluk_Master__c where name lIKE:TalukNewquery+'%' limit 200]; 
        
        TalukListNew.addAll(Taluks);
        System.debug('coming inside runQuery ' +TalukListNew);
        // return TalukList;
        
    }
    
    // executes the search
    public void Searchqueryforpincode()
    {  
        System.debug('coming inside');
        PincodeList = new List<Pincode__c>();
        list<Pincode__c> Pincodes = [select id, Name, City__c, District__c,
                                           State__c from Pincode__c where name lIKE:Pincodequery+'%' limit 200]; 
        
        PincodeList.addAll(Pincodes);
        System.debug('coming inside runQuery ' +PincodeList);
        // return PincodeList;
        
    }
    // executes the search
    public void Searchqueryforuser()
    {  
        System.debug('coming inside');
        UserList= new List<User>();
        list<User> Users= [select id, Name, Profile.Name, Vertical_type__C, UserName, title,
                           phone, Email from User where name lIKE:Userquery+'%' and isactive=true  limit 200]; 
        
        UserList.addAll(Users);
        System.debug('coming inside runQuery ' +UserList);
        // return UserList;
        
    }
    
    //**************Method to get accountlist 
    public string accountquery{get;set;}
    public list<Account> Accountlist{get;set;}
    
    public void SearchqueryforAccount() {
        
        if(Accountquery != null) {
            Accountquery = Accountquery.trim();
        }
        
        String nameCond = '%'+Accountquery+'%';
        String cond = Accountquery+'%';
        
        Accountlist= new list<Account>();
        List<Account> acc =[select id, name,status__C,Custom_Distributor_LookUp__c,party_type__C,Contact_Number_Mobile__c, 
                            State__c,District__C ,City__c from Account where (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                                              Contact_Number_Mobile__c LIKE :cond ) LIMIT 200];
        Accountlist.ADDALL(acc);
        
    }
    //**************Method to get promotions
    public string promoquery{get;set;}
    public list<Promotion__c> Promolist{get;set;}
    
    public void SearchqueryforPromo(){
        Promolist= new list<Promotion__c>();
        List<Promotion__c> promo =[select id, name, District__c,Date__c,type__C,state__C from 
                                   Promotion__c where name LIKE:Promoquery+'%' ORDER BY CreatedDate Desc LIMIT 200];
        Promolist.ADDALL(promo);
        
    }
    
    // executes the search
    public void runUserQuery()
    {   System.debug('coming inside');
     userMeetingList  = new List<User>();
     List<User> searchMeetingResults= New List<User>([SELECT id, Name, title,phone,Email  FROM User 
                                                      WHERE name LIKE: searchUser+'%' AND isActive=true limit 200]);
     
     userMeetingList.addAll(searchMeetingResults);
     System.debug('coming inside runQuery ' +userMeetingList);
     
    }
    // Get selected value of "Party Type" from VF
    
    @RemoteAction
    global static String selectedPartyType(String PartyTypeName)
    {   
        System.debug('coming inside RemoteAction ' +PartyTypeName);
        partyTypeFilter = PartyTypeName;
        System.debug('coming inside RemoteAction2 ' +partyTypeFilter);
        return PartyTypeName;
    }
    
    
    public void searchQueryforDistributor()
    {
        distracc = new List<Account>();
        
        if(distrqry != null) {
            distrqry = distrqry.trim();
        }
        
        String nameCond = '%'+distrqry+'%';
        String cond = distrqry+'%';
        
        List<Account> searchResults= New List<Account>([SELECT Id,Custom_Distributor_LookUp__c,Name,District__c, State__c, Status__c, City__c ,
                                                        Party_type__c,Contact_Number_Mobile__c  FROM Account WHERE status__c ='Existing' AND 
                                                        RecordType.Name= 'Distributor' and 
                                                        (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                         Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        distracc.addAll(searchResults);        
    }
    
    
    public void searchQueryforDealer()
    {
        dealeracc = new List<Account>();
        if(dealerqry != null) {
            dealerqry = dealerqry.trim();
        }
        
        String nameCond = '%'+dealerqry+'%';
        String cond = dealerqry+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c,District__c, State__c, Status__c, City__c ,
                                                        Party_type__c,Column_club_ID__c,Contact_Number_Mobile__c  FROM Account WHERE RecordType.Name = 'Dealer' 
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        dealeracc.addAll(searchResults);        
    }
    
    public void searchQueryforDistri()
    {
        distracc = new List<Account>(); system.debug('--distr srch--*'+distrqrypromo);
        if(distrqrypromo != null) {
            distrqrypromo = distrqrypromo.trim();
        }
        
        String nameCond = '%'+distrqrypromo+'%';
        String cond = distrqrypromo+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Custom_Distributor_LookUp__c,Name,District__c, State__c, Status__c,City__c ,
                                                        Party_type__c,Contact_Number_Mobile__c  FROM Account WHERE status__c ='Existing' AND
                                                        Party_type__c = 'Distributor' 
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        distracc.addAll(searchResults);        
    }
    
    public void searchQueryforProject(){
        oppqryList = new List<Opportunity>(); 
        List<Opportunity> searchOppResults= New List<Opportunity>([SELECT Id,Name,owner.name,Project_Number__c,Average_Discount__c 
                                                                   FROM Opportunity WHERE name LIKE: projQry+'%' limit 200]);
        oppqryList.addAll(searchOppResults);
    }
    
    public void searchQueryforDealerProm() {
        dealerPromacc = new List<Account>();
        if(dealerPromqry != null) {
            dealerPromqry = dealerPromqry.trim();
        }
        
        String nameCond = '%'+dealerPromqry+'%';
        String cond = dealerPromqry+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c,District__c, State__c, Status__c,City__c ,
                                                        Party_type__c,Column_club_ID__c, Plumbing_club_ID__c,Contact_Number_Mobile__c  FROM Account WHERE Party_type__c = 'Dealer' 
                                                        and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                             Contact_Number_Mobile__c LIKE :cond ) limit 200]);
        dealerPromacc.addAll(searchResults);        
    }
    
    public void searchQueryforTalukJunc()
    {          
        talukJuncList = new List<User_Taluk_Master_Junction__c>();
        list<User_Taluk_Master_Junction__c> talukJns = [select id, Name, User_Id__c, User__c, AP_Taluk_Master__c,State__c,Cluster__c,
                                                        District__c from User_Taluk_Master_Junction__c where name lIKE:talukJuncQry+'%' AND User__c=:UserInfo.getUserId() limit 100]; 
        
        talukJuncList.addAll(talukJns);
        System.debug('inside runQuery ' +talukJuncList);
        
        
    }
    /*
public void sendPartyTypeName()
{
partyTypeFilter =System.currentPageReference().getParameters().get('value1');  
System.debug('inside partyTypeFilter ' +partyTypeFilter);
}*/
}
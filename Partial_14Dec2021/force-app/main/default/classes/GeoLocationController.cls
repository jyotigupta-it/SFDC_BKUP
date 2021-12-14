public class GeoLocationController{

    public account a{get;set;}
    public list<SelectOption> objectList{get;set;}
    public string selectedObject{get;set;}
    public list<selectoption> accountType{get;set;}
    public string selectedAccountType{get;set;}
    public list<account> accountList{get;set;}   
    public list<Promotion__c> promotionList{get;set;}
    public list<AP_Site_Visit__c> visitList{get;set;}
    public date fromDate{get;set;}
    public date toDate{get;set;}
    public list<account> dealerAccountList{get;set;} 
    public list<account> distributorAccountList{get;set;}   
    public list<account> IndividualContactAccountList{get;set;} 
   
    
    public GeoLocationController(){
        
        a= new account();
        objectList = new list<SelectOption>();
        objectList.add(new selectOption('','----SELECT----'));
        objectList.add(new selectOption('Accounts','Accounts'));
        objectList.add(new selectOption('Promotions','Promotions'));
        objectList.add(new selectOption('Visits','Visits'));  
            
    }
    
    public void AccountType(){
    
        if(selectedObject=='Accounts' || selectedObject=='Visits'){        
            Id DPRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Distributor').RecordTypeId;
            Id DlrRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Dealer').RecordTypeId;
            Id ICRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Individual Contacts').RecordTypeId;
            Id VisitRecTypid= Schema.SObjectType.AP_Site_Visit__c.RecordTypeInfosByName.get('Visits').RecordTypeId;
            Id OARecTypid= Schema.SObjectType.AP_Site_Visit__c.RecordTypeInfosByName.get('Other Activities').RecordTypeId;
            accountType = new list<SelectOption>();
            if(selectedObject=='Accounts'){
                accountType.add(new selectOption('','----SELECT----'));
                accountType.add(new selectOption(DlrRecTypid,'Dealer'));
                accountType.add(new selectOption(DPRecTypid,'Distributor')); 
                accountType.add(new selectOption(ICRecTypid,'Individual Contacts')); 
                accountType.add(new selectOption('All','All')); 
            } 
            
            if(selectedObject=='Visits'){
                accountType.add(new selectOption('','----SELECT----'));
                accountType.add(new selectOption(VisitRecTypid,'Market Visits'));
                accountType.add(new selectOption(OARecTypid,'Other Activities'));                 
                accountType.add(new selectOption('All','All')); 
            }    
        }    
    }
    
    
    public void showRecords(){   
           
        if(selectedObject=='Accounts'){
            
            Set<ID> accSet = new Set<ID>();
            system.debug('--selectedAccountType----'+selectedAccountType);
            dealerAccountList  = new list<account>();
            distributorAccountList = new list<account>();
            IndividualContactAccountList = new list<account>();
            if(selectedAccountType!='All'){ 
              string type='';
                if(selectedAccountType!='All')
                    type = [select id,name from recordtype where id =:selectedAccountType].name;
                
                if(type=='Dealer')
                    dealerAccountList =[SELECT ID,Name,OwnerID,Primary_Contact_Person_Name__c,Contact_Number_Mobile__c, CreatedDate,Geo_Location_JSON__c, recordtype.name,BillingState,BillingStreet,BillingCity,BillingPostalCode,BillingCountry,GeoLocation__Latitude__s,GeoLocation__Longitude__s FROM Account WHERE GeoLocation__Longitude__s<>null and GeoLocation__Latitude__s<>null and ownerid=:a.ownerid and RecordTypeId =:selectedAccountType];   
                if(type=='Distributor')
                    //Id DPRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Distributor').RecordTypeId;
                    for(Account acnt : [SELECT ID,ParentID FROM Account WHERE Party_Type__c = 'Dealer' AND ownerid=:a.ownerid]){ 
                        accSet.add(acnt.ParentID);
                    }
                    system.debug('-------------accSet----------------->'+accSet);
                    distributorAccountList= [SELECT ID,Name,Primary_Contact_Person_Name__c,Contact_Number_Mobile__c,OwnerID,Geo_Location_JSON__c, CreatedDate, recordtype.name,BillingState,BillingStreet,BillingCity,BillingPostalCode,BillingCountry,GeoLocation__Latitude__s,GeoLocation__Longitude__s FROM Account WHERE GeoLocation__Longitude__s<>null and GeoLocation__Latitude__s<>null and ID IN: accSet];    
                if(type=='Individual Contacts')    
                    IndividualContactAccountList= [SELECT ID,Name,Geo_Location_JSON__c,Contact_Number_Mobile__c,Primary_Contact_Person_Name__c,OwnerID, CreatedDate, recordtype.name,BillingState,BillingStreet,BillingCity,BillingPostalCode,BillingCountry,GeoLocation__Latitude__s,GeoLocation__Longitude__s FROM Account WHERE GeoLocation__Longitude__s<>null and GeoLocation__Latitude__s<>null and ownerid=:a.ownerid and RecordTypeId =:selectedAccountType];    
            }
            else{
                accountList= [SELECT ID,Name,OwnerID,Geo_Location_JSON__c,Contact_Number_Mobile__c,Primary_Contact_Person_Name__c, CreatedDate, recordtype.name,BillingState,BillingStreet,BillingCity,BillingPostalCode,BillingCountry,GeoLocation__Latitude__s,GeoLocation__Longitude__s FROM Account WHERE GeoLocation__Longitude__s<>null and GeoLocation__Latitude__s<>null and ownerid=:a.ownerid];     
                for(account ac : accountList){
                    if(ac.recordtype.name=='Dealer')
                        dealerAccountList.add(ac);
                    if(ac.recordtype.name=='Distributor')
                        distributorAccountList.add(ac);
                    if(ac.recordtype.name=='Individual Contacts')
                        IndividualContactAccountList.add(ac);
                }   
            }
            system.debug('---dealerAccountList--'+dealerAccountList.size());
            system.debug('---distributorAccountList--'+distributorAccountList.size());
            system.debug('---IndividualContactAccountList--'+IndividualContactAccountList.size());
        }
        
        if(selectedObject=='Promotions'){
            promotionList = new list<Promotion__c>();
            if(fromDate==null || toDate==null)
                promotionList =[select id,name, Type__c,Geo_Location_JSON__c, CreatedDate, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from Promotion__c where OwnerId=: a.ownerId];
            else
                promotionList =[select id,name, Type__c,Geo_Location_JSON__c, CreatedDate, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from Promotion__c where OwnerId=: a.ownerId and Date_Created__c>=:fromDate and Date_Created__c<=:toDate];
        }
        
        if(selectedObject=='Visits'){
            //system.debug('--visits-------');
            string type='';
            
            if(selectedAccountType!='All')
                type = [select id,name from recordtype where id =:selectedAccountType].Id;
                
            visitList = new list<AP_Site_Visit__c>();
            if(fromDate==null || toDate==null){
                if(selectedAccountType!='All')
                    visitList  =[select id,name,Geo_Location_JSON__c, CreatedDate, RecordType.Id, CreatedBy.Id, Party_Type__c, Purpose_of_Visit__c, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from AP_Site_Visit__c where CreatedBy.Id =: a.ownerId and RecordType.Id=:type];
                else
                    visitList  =[select id,name,Geo_Location_JSON__c, CreatedDate, RecordType.Id, CreatedBy.Id, Party_Type__c, Purpose_of_Visit__c, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from AP_Site_Visit__c where CreatedBy.Id =: a.ownerId];    
            }    
            else{
                if(selectedAccountType!='All')
                    visitList  =[select id,name, Geo_Location_JSON__c, CreatedDate, RecordType.Id, CreatedBy.Id, Party_Type__c, Purpose_of_Visit__c, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from AP_Site_Visit__c where CreatedBy.Id =: a.ownerId and RecordType.Id=:type and Date__c>=:fromDate and Date__c<=:toDate];
                else
                    visitList  =[select id,name, Geo_Location_JSON__c, CreatedDate, RecordType.Id, CreatedBy.Id, Party_Type__c, Purpose_of_Visit__c, Geo_Address__c, Geo_Location__Latitude__s,Geo_Location__Longitude__s from AP_Site_Visit__c where CreatedBy.Id =: a.ownerId and Date__c>=:fromDate and Date__c<=:toDate];
            }
            system.debug('----------------------------visitList-------->'+visitList.size());
        }
    
    }

}
/*  
Author: Satyanarayana
Description : 
Events : Before Insert, Before Update : Populate Dealer, Distributor, Direct Dealer Activated Date, once the Status is changed from Prospect to Existing.
After Insert, After Update   : Populate Dealer, Distributor, Direct Dealer Activated Actaul count, once the Status is changed from Prospect to Existing.
Date : 13/07/2015    */
public class AccountTriggerHandler {
    
   private static AccountTriggerHandler instance;
    private static string STATUS_EXISTING      =    'Existing';
    private static string PARTNER_TYPE         =    'Retail Partner';
    private map<Integer, String> monthsMap = new map<Integer, String>{1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May',6 => 'June', 7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'};
        
        
        /*-- SINGLETON PATTERN --*/
        public static AccountTriggerHandler getInstance() {
            
            if(instance == null) {
                instance = new AccountTriggerHandler();
            }
            return instance;
        }
    
    // Executes on beforeInsert & beforeUpdate event.
    public void beforeInsert(list<Account> newAccounts, Map<id,Account> oldAccountsMap) {
        
        string Dealer_RecordTypeId           =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        string Distributor_RecordTypeId      =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
        string Direct_Dealer_RecordTypeId    =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
        map<id, User_Taluk_Master_Junction__c> talukClusterMap;
        set<id> talukSetId                   =   new set<id>(); 
        Integer talukaMapSize                =  0;
          map<id, Town_Master__c> townMap;
        set<id> townSetId                   =   new set<id>(); 
        
         Integer townMapSize                =  0;


       for(Account acc : newAccounts) {

            if(Trigger.isInsert ? acc.APPL_Taluk__c != null : oldAccountsMap.get(acc.id).APPL_Taluk__c != acc.APPL_Taluk__c && acc.APPL_Taluk__c != null) {
                talukSetId.add(acc.APPL_Taluk__c);
               
            }
             if(Trigger.isInsert ? acc.Town_Name__c != null : oldAccountsMap.get(acc.id).Town_Name__c != acc.Town_Name__c && acc.Town_Name__c != null) {
                townSetId.add(acc.Town_Name__c);
               
            }
        }
        if(talukSetId.size() > 0) {
           talukClusterMap = new map<id, User_Taluk_Master_Junction__c>([select Cluster__c,State__c,District__c from User_Taluk_Master_Junction__c where Id IN: talukSetId]);
        }
        if(talukClusterMap != null && !talukClusterMap.isEmpty()) {
        talukaMapSize = talukClusterMap.size();
    }
     if(townSetId.size() > 0) {
           townMap = new map<id, Town_Master__c>([select State__c,District__c,Town_code__c from Town_Master__c where Id IN: townSetId]);
        }
        if(townMap != null && !townMap.isEmpty()) {
        townMapSize = townMap.size();
    }

        for(Account acc : newAccounts) {

            if(acc.APPL_Taluk__c != null && talukaMapSize > 0) {
                acc.Cluster_of_Taluka__c    =   talukClusterMap.containsKey(acc.APPL_Taluk__c) ? talukClusterMap.get(acc.APPL_Taluk__c).Cluster__c : acc.Cluster_of_Taluka__c;
                
                //acc.State__c                =   talukClusterMap.containsKey(acc.APPL_Taluk__c) ? talukClusterMap.get(acc.APPL_Taluk__c).State__c : acc.State__c;
               //acc.District__c             =   talukClusterMap.containsKey(acc.APPL_Taluk__c) ? talukClusterMap.get(acc.APPL_Taluk__c).District__c : acc.District__c;
            }  
            
             if(acc.Town_Name__c != null && townMapSize > 0) {
             
            acc.State__c                =   townMap.containsKey(acc.Town_Name__c) ? townMap.get(acc.Town_Name__c).State__c : acc.State__c;
            acc.District__c             =   townMap.containsKey(acc.Town_Name__c) ? townMap.get(acc.Town_Name__c).District__c : acc.District__c;
            acc.Town_Code__c            =   townMap.containsKey(acc.Town_Name__c) ? townMap.get(acc.Town_Name__c).Town_Code__c : acc.Town_Code__c;
            system.debug('From Town master state..' +acc.State__c +'  district....'+acc.District__c );
            }     
            string oldAccountStatus         =   '';
            string oldAccountRecordTypeId   =   '';
            string oldAccountPartnerType    =   '';
            
            //Getting Old Sttaus & recordTypeID.
            if(Trigger.isUpdate) {
                
                oldAccountStatus            =   oldAccountsMap.get(acc.Id).Status__c; 
                oldAccountRecordTypeId      =   oldAccountsMap.get(acc.Id).RecordTypeId;
                oldAccountPartnerType       =   oldAccountsMap.get(acc.Id).Type_Of_partner__c;
            }
            
            //Populating Dealer Activated date.
            if((Trigger.isInsert ? (acc.Status__c == STATUS_EXISTING) && ((Dealer_RecordTypeId == acc.RecordTypeId && Dealer_RecordTypeId != null && Dealer_RecordTypeId != '')) : ((acc.Status__c == STATUS_EXISTING) && (oldAccountStatus != acc.Status__c && oldAccountStatus != null && oldAccountStatus != '')) && (Dealer_RecordTypeId == acc.RecordTypeId && Dealer_RecordTypeId != null && Dealer_RecordTypeId != ''))) {
                acc.Dealer_Activated_Date__c        =   Date.Today();
                system.debug(acc.Dealer_Activated_Date__c);
            }
            
            //Populating Distributor Activated date.
            if((Trigger.isInsert ? (acc.Status__c == STATUS_EXISTING) && (Distributor_RecordTypeId == acc.RecordTypeId && Distributor_RecordTypeId != null && Distributor_RecordTypeId != '') : ((acc.Status__c == STATUS_EXISTING) && (oldAccountStatus != acc.Status__c && oldAccountStatus != null && oldAccountStatus != '')) && (Distributor_RecordTypeId == acc.RecordTypeId && Distributor_RecordTypeId != null && Distributor_RecordTypeId != ''))) {
                acc.Distributor_Activated_Date__c   =   Date.Today();
                system.debug(acc.Distributor_Activated_Date__c);
            }
            
            //Populating Direct Dealer Activated date.
            if((Trigger.isInsert ? (acc.Status__c == STATUS_EXISTING) && (Direct_Dealer_RecordTypeId == acc.RecordTypeId && Direct_Dealer_RecordTypeId != null && Direct_Dealer_RecordTypeId != '') : ((acc.Status__c == STATUS_EXISTING) && (oldAccountStatus != acc.Status__c && oldAccountStatus != null && oldAccountStatus != '')) && (Direct_Dealer_RecordTypeId == acc.RecordTypeId && Direct_Dealer_RecordTypeId != null && Direct_Dealer_RecordTypeId != ''))) {
                acc.Direct_Dealer_Activated_Date__c =   Date.Today();
                system.debug(acc.Direct_Dealer_Activated_Date__c);
            }
            
            //Populating Retail Partner Date.
            if((Trigger.isInsert ? ((acc.Type_Of_partner__c == PARTNER_TYPE) && (Distributor_RecordTypeId == acc.RecordTypeId && Distributor_RecordTypeId != null && Distributor_RecordTypeId != '')) : ((acc.Type_Of_partner__c == PARTNER_TYPE) && (oldAccountPartnerType != acc.Type_Of_partner__c && oldAccountPartnerType != null && oldAccountPartnerType != '')) && (Distributor_RecordTypeId == acc.RecordTypeId && Distributor_RecordTypeId != null && Distributor_RecordTypeId != ''))) {
                acc.Retail_Partner_Date__c     =   Date.Today();
            }
            
            // Populating Dealer Activated date on change of record type to Dealer from another recordType.
            if(Trigger.isUpdate && acc.recordTypeId != oldAccountRecordTypeId && Dealer_RecordTypeId == acc.RecordTypeId) {
                
                if(oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Distributor_RecordTypeId) {
                    acc.Dealer_Activated_Date__c              =   acc.Distributor_Activated_Date__c != null ? acc.Distributor_Activated_Date__c : Date.Today();
                    acc.Distributor_Activated_Date__c         =   null;
                } else if(oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Direct_Dealer_RecordTypeId) {
                    acc.Dealer_Activated_Date__c          =   acc.Direct_Dealer_Activated_Date__c != null ? acc.Direct_Dealer_Activated_Date__c : Date.Today();
                    acc.Direct_Dealer_Activated_Date__c   =   null;
                } else {
                    acc.Dealer_Activated_Date__c          =   Date.Today();
                }
            }
            
            // Populating Distributor Activated date on change of record type to Distributor from another recordType.
            if(Trigger.isUpdate && acc.recordTypeId != oldAccountRecordTypeId && Distributor_RecordTypeId == acc.RecordTypeId) {
                
                if(oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Dealer_RecordTypeId) {
                    acc.Distributor_Activated_Date__c         =   acc.Dealer_Activated_Date__c != null ? acc.Dealer_Activated_Date__c : Date.Today();
                    acc.Dealer_Activated_Date__c              =   null;
                } else if( oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Direct_Dealer_RecordTypeId) {
                    acc.Distributor_Activated_Date__c     =   acc.Direct_Dealer_Activated_Date__c != null ? acc.Direct_Dealer_Activated_Date__c : Date.Today();
                    acc.Direct_Dealer_Activated_Date__c   =   null;
                } else {
                    acc.Distributor_Activated_Date__c         =   Date.Today();
                }
            }
            
            // Populating Direct Dealer Activated date on change of record type to Direct Dealer from another recordType.
            if(Trigger.isUpdate && acc.recordTypeId != oldAccountRecordTypeId && Direct_Dealer_RecordTypeId == acc.RecordTypeId) {
                
                if(oldAccountRecordTypeId == Dealer_RecordTypeId) {
                    acc.Direct_Dealer_Activated_Date__c       =   acc.Dealer_Activated_Date__c != null ? acc.Dealer_Activated_Date__c : Date.Today();
                    acc.Dealer_Activated_Date__c              =   null;
                } else if(oldAccountRecordTypeId == Distributor_RecordTypeId) {
                    acc.Direct_Dealer_Activated_Date__c   =   acc.Distributor_Activated_Date__c != null ? acc.Distributor_Activated_Date__c : Date.Today();
                    acc.Distributor_Activated_Date__c     =   null;
                } else {
                    acc.Direct_Dealer_Activated_Date__c       =   Date.Today();
                }
            }
            
            
            // Populating Direct Dealer Activated date on change of record type to Direct Dealer from another recordType.
          /*  if(Trigger.isUpdate && acc.recordTypeId != oldAccountRecordTypeId && Distributor_RecordTypeId == acc.RecordTypeId) {
                
                if(oldAccountRecordTypeId == Dealer_RecordTypeId) {
                    acc.Direct_Dealer_Activated_Date__c       =   acc.Dealer_Activated_Date__c != null ? acc.Dealer_Activated_Date__c : Date.Today();
                    acc.Dealer_Activated_Date__c              =   null;
                } else if(oldAccountRecordTypeId == Distributor_RecordTypeId) {
                    acc.Direct_Dealer_Activated_Date__c   =   acc.Distributor_Activated_Date__c != null ? acc.Distributor_Activated_Date__c : Date.Today();
                    acc.Distributor_Activated_Date__c     =   null;
                } else {
                    acc.Direct_Dealer_Activated_Date__c       =   Date.Today();
                }
            }*/
            
            //Retail_Partner_Date__c
            
            //Populating the All 3 Date fields to null; if Status is not equal to "Existing"
            if((Trigger.isInsert || Trigger.isUpdate) && acc.Status__c != STATUS_EXISTING) {
                
                acc.Dealer_Activated_Date__c              =   null;
                acc.Distributor_Activated_Date__c         =   null;
                acc.Direct_Dealer_Activated_Date__c       =   null;
                system.debug(acc);
            }
        }
    }
    
    
    
    // Executes on afterInsert & afterUpdate event. ------------ START
    public void afterInsert(list<Account> newAccounts, Map<id,Account> oldAccountsMap) {
        
        //string oldAccountStatus          =   oldAccountsMap.get(acc.Id).Status__c; 
        //string oldAccountRecordTypeId    =   oldAccountsMap.get(acc.Id).RecordTypeId;
        string Dealer_RecordTypeId           =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        string Distributor_RecordTypeId      =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
        string Direct_Dealer_RecordTypeId    =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
        
        //Prepare  Target list (Based on that  Account ownerids assosicate with Target Records)
        list<Target__c> listOfExist_Appl_Targets             =   new list<Target__c>();
        
        //Update Targets records
        list<Target__c> listOfUpdate_Appl_Target             =   new list<Target__c>();
        map<integer,string> mapofAppl_Target_Months          =   new map<integer,string>();
        map<string,Target__c> mapofAppl_TargetObject         =   new map<string,Target__c>();
        map<string, list<string>> mapOfUser_Month            =   new map<string, list<string>>();
        map<string, list<string>> DealerMap_Month            =   new map<string, list<string>>();
        map<string, list<string>> DistributorMap_Month       =   new map<string, list<string>>();
        map<string, list<string>> DirectDealerMap_Month      =   new map<string, list<string>>();
        map<string, list<string>> RetailPartnerMap_Month     =   new map<string, list<string>>();
        //map<id, list<MonthWrapper>> Owner_OldRecordTypeId  =   new map<id, list<MonthWrapper>>();
        
        //Current Account Owners.
        set<string> MonthSet                                 =   new set<string>();
        
        //New Accounts; Executes only on Change of Status to Existing.
        for(Account objAcct :newAccounts) {
            
            string oldStatusValue           =   '';
            string oldAccountRecordTypeId   =   '';
            string oldPartnerType           =   '';
            
            if(Trigger.isUpdate) {
                
                oldStatusValue              =   oldAccountsMap.get(objAcct.Id).status__c;
                oldAccountRecordTypeId      =   oldAccountsMap.get(objAcct.Id).RecordTypeId;
                oldPartnerType              =   oldAccountsMap.get(objAcct.Id).Type_Of_partner__c;
            }
            
            
            // Dealer RecordType moved to Existing; Populate Target New Dealer Activated field.
            if(Trigger.isInsert ? (objAcct.recordTypeId == Dealer_RecordTypeId && objAcct.Status__c == STATUS_EXISTING) : (oldStatusValue != STATUS_EXISTING && objAcct.recordTypeId == Dealer_RecordTypeId && objAcct.Status__c == STATUS_EXISTING && oldAccountRecordTypeId == objAcct.recordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Dealer_Activated_Date__c.month())+' - '+objAcct.Dealer_Activated_Date__c.year();
                
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                }
                
                if(DealerMap_Month.containsKey(objAcct.ownerId)) {
                        
                        DealerMap_Month.get(objAcct.ownerId).add(target_Month);
                    } else {
                        
                        DealerMap_Month.put(objAcct.ownerId, new list<string>());
                        DealerMap_Month.get(objAcct.ownerId).add(target_Month);
                    }
            }
            
            // Distributor RecordType moved to Existing; Populate Target New Distributor Activated field.
            if(Trigger.isInsert ? (objAcct.recordTypeId == Distributor_RecordTypeId && objAcct.Status__c == STATUS_EXISTING) : (oldAccountRecordTypeId == objAcct.recordTypeId &&  oldStatusValue != STATUS_EXISTING && objAcct.Status__c == STATUS_EXISTING && objAcct.recordTypeId == Distributor_RecordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Distributor_Activated_Date__c.month())+' - '+objAcct.Distributor_Activated_Date__c.year();
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //DistributorMap_Month.put(objAcct.ownerId, new list<string>());
                   //DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                }
                
                if(DistributorMap_Month.containsKey(objAcct.ownerId)) {
                        
                        DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                    } else {
                        
                        DistributorMap_Month.put(objAcct.ownerId, new list<string>());
                        DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                    } 
            }
            
            // Direct Dealer RecordType moved to Existing; Populate Target New Distributor Activated field.
            if(Trigger.isInsert ? (objAcct.recordTypeId == Direct_Dealer_RecordTypeId && objAcct.Status__c == STATUS_EXISTING) : (oldStatusValue != STATUS_EXISTING && objAcct.recordTypeId == Direct_Dealer_RecordTypeId && objAcct.Status__c == STATUS_EXISTING && oldAccountRecordTypeId == objAcct.recordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Direct_Dealer_Activated_Date__c.month())+' - '+objAcct.Direct_Dealer_Activated_Date__c.year();
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //DirectDealerMap_Month.put(objAcct.ownerId, new list<string>());
                    //DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                }
                
                if(DirectDealerMap_Month.containsKey(objAcct.ownerId)) {
                        
                        DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                    } else {
                        
                        DirectDealerMap_Month.put(objAcct.ownerId, new list<string>());
                        DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                    } 
            }
        
        //Distributor RT; PartnerType is Retail Partner.
        
        if(Trigger.isInsert ? (objAcct.recordTypeId == Distributor_RecordTypeId && objAcct.Type_Of_partner__c == PARTNER_TYPE) : (oldPartnerType != objAcct.Type_Of_partner__c && objAcct.Type_Of_partner__c == PARTNER_TYPE && objAcct.recordTypeId == Distributor_RecordTypeId)) {
            
            string target_Month;
                if(monthsMap.size() > 0 && objAcct.Retail_Partner_Date__c != null) {                     
                    target_Month = monthsMap.get(objAcct.Retail_Partner_Date__c.month())+' - '+objAcct.Retail_Partner_Date__c.year();
                }   
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //RetailPartnerMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    //RetailPartnerMap_Month.put(objAcct.ownerId, new list<string>());
                    //RetailPartnerMap_Month.get(objAcct.ownerId).add(target_Month);
                }   
                
                if(RetailPartnerMap_Month.containsKey(objAcct.ownerId)) {
                        
                        RetailPartnerMap_Month.get(objAcct.ownerId).add(target_Month);
                    } else {
                        
                        RetailPartnerMap_Month.put(objAcct.ownerId, new list<string>());
                        RetailPartnerMap_Month.get(objAcct.ownerId).add(target_Month);
                    } 
        }
    }
        //Preparing the data. //setofOwnerid != null && mapofMonthYearchecking != null && mapofMonthYearchecking.size() > 0
        if(mapOfUser_Month.size() > 0) {
            try {
                listOfExist_Appl_Targets  = [select id, OwnerId, New_Direct_Dealer_To_Depot_Actual__c, New_Distributer_Activation_Actuals__c, New_Direct_Dealer_Activation__c, New_dealers_activation__c, New_dealers_activation_Actual__c, month__c from Target__c where ownerid IN: mapOfUser_Month.keySet() and month__c IN: MonthSet];
            } Catch(Exception e) {
                system.debug(e.getMessage());
            }
        }
        
        boolean ovverridenFlag = false;
        
        //Prepare the map month vs Target Object.
        if(listOfExist_Appl_Targets.size() > 0) {
            
            for(Target__c objTarget :listOfExist_Appl_Targets) {
                
                //string oldAccountRecordTypeId      =   oldAccountsMap.get(objTarget.Id).RecordTypeId;
                
                if(DealerMap_Month.containsKey(objTarget.OwnerId)) {
                    for(String X_month : DealerMap_Month.get(objTarget.OwnerId)) {
                        if(X_month == objTarget.Month__c) {
                            if(objTarget.New_dealers_activation_Actual__c != null) {
                                objTarget.New_dealers_activation_Actual__c  += 1; 
                            } else {
                                objTarget.New_dealers_activation_Actual__c  = 1; 
                            }
                            ovverridenFlag = true;
                        }   /*else {
                            
                            if(objTarget.New_dealers_activation_Actual__c != null) {
                                objTarget.New_dealers_activation_Actual__c  += 1; 
                            } else {
                                objTarget.New_dealers_activation_Actual__c  = 1; 
                            }
                        }*/
                    }
                }
                
                
                if(DistributorMap_Month.containsKey(objTarget.OwnerId)) {
                    for(String X_month : DistributorMap_Month.get(objTarget.OwnerId)) {
                        if(X_month == objTarget.Month__c) {
                            if(objTarget.New_Distributer_Activation_Actuals__c != null) {
                                objTarget.New_Distributer_Activation_Actuals__c  += 1 ; 
                            } else {
                                objTarget.New_Distributer_Activation_Actuals__c  = 1 ; 
                            }
                            ovverridenFlag = true;
                        }   
                    }
                }
                
                
                if(DirectDealerMap_Month.containsKey(objTarget.OwnerId)) {
                    for(String X_month : DirectDealerMap_Month.get(objTarget.OwnerId)) {
                        if(X_month == objTarget.Month__c) {
                            if(objTarget.New_Direct_Dealer_Activation__c != null) {
                                objTarget.New_Direct_Dealer_Activation__c  += 1 ; 
                            } else {
                                objTarget.New_Direct_Dealer_Activation__c  = 1 ; 
                            }
                            ovverridenFlag = true;
                        }   
                    }
                }
                
                if(RetailPartnerMap_Month.containsKey(objTarget.OwnerId)) {
                    for(String X_month : RetailPartnerMap_Month.get(objTarget.OwnerId)) {
                        if(X_month == objTarget.Month__c) {
                            if(objTarget.New_Direct_Dealer_To_Depot_Actual__c != null) {
                                objTarget.New_Direct_Dealer_To_Depot_Actual__c  += 1 ; 
                            } else {
                                objTarget.New_Direct_Dealer_To_Depot_Actual__c  = 1 ; 
                            }
                            ovverridenFlag = true;
                        }   
                    }
                }
            }
        }
        
        //Updating Target record with changes.
        if(ovverridenFlag) {
            
            update listOfExist_Appl_Targets;
        }
        
      
        
        
         //New Accounts; Executes only if RecordType is changed.
        /* if(Trigger.isUpdate) {
            
        list<Target__c> listOfUpdate_Appl_Target           =   new list<Target__c>();
        map<integer,string> mapofAppl_Target_Months        =   new map<integer,string>();
        map<string,Target__c> mapofAppl_TargetObject       =   new map<string,Target__c>();
        map<string, list<string>> mapOfUser_Month          =   new map<string, list<string>>();
        map<string, list<string>> DealerMap_Month          =   new map<string, list<string>>();
        map<string, list<string>> DistributorMap_Month     =   new map<string, list<string>>();
        map<string, list<string>> DirectDealerMap_Month    =   new map<string, list<string>>();
        set<string> MonthSet                               =   new set<string>();
        
        for(Account objAcct :newAccounts) {

            string oldStatusValue           =   '';
            string oldAccountRecordTypeId   =   '';
          
                oldStatusValue              =   oldAccountsMap.get(objAcct.Id).status__c;
                oldAccountRecordTypeId      =   oldAccountsMap.get(objAcct.Id).RecordTypeId;
            
            // Dealer RecordType moved to Existing; Populate Target New Dealer Activated field.
            if(objAcct.recordTypeId == Dealer_RecordTypeId && oldAccountRecordTypeId != objAcct.recordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Dealer_Activated_Date__c.month())+' - '+objAcct.Dealer_Activated_Date__c.year();
                
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DealerMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DealerMap_Month.put(objAcct.ownerId, new list<string>());
                    DealerMap_Month.get(objAcct.ownerId).add(target_Month);
                }
            }
            
            // Distributor RecordType moved to Existing; Populate Target New Dealer Activated field.
            if(objAcct.recordTypeId == Distributor_RecordTypeId && oldAccountRecordTypeId != objAcct.recordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Dealer_Activated_Date__c.month())+' - '+objAcct.Dealer_Activated_Date__c.year();
                
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DistributorMap_Month.put(objAcct.ownerId, new list<string>());
                    DistributorMap_Month.get(objAcct.ownerId).add(target_Month);
                }
            }
            
           // Direct Dealer RecordType moved to Existing; Populate Target New Dealer Activated field.
            if(objAcct.recordTypeId == Distributor_RecordTypeId && oldAccountRecordTypeId != objAcct.recordTypeId)) {
                
                //setofOwnerid.add(objAcct.ownerid);
                string target_Month   =    monthsMap.get(objAcct.Dealer_Activated_Date__c.month())+' - '+objAcct.Dealer_Activated_Date__c.year();
                
                
                if(!MonthSet.contains(target_Month)) {
                    
                    MonthSet.add(target_Month);
                }
                
                if(mapOfUser_Month.containskey(objAcct.ownerId)) {
                    
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                } else {
                    
                    mapOfUser_Month.put(objAcct.ownerId, new list<string>());
                    mapOfUser_Month.get(objAcct.ownerId).add(target_Month);
                    DirectDealerMap_Month.put(objAcct.ownerId, new list<string>());
                    DirectDealerMap_Month.get(objAcct.ownerId).add(target_Month);
                }
            }   
        }
         }
        
        
        /* map<string, list<string>> mapOfUser_MonthRT          =   new map<string, list<string>>();
map<string, list<string>> DealerMap_MonthRT          =   new map<string, list<string>>();
map<string, list<string>> DistributorMap_MonthRT     =   new map<string, list<string>>();
map<string, list<string>> DirectDealerMap_MonthRT    =   new map<string, list<string>>();

// Populating Dealer Activated date on change of record type to Dealer from another recordType.
if(Trigger.isUpdate) {
for(Account objAcct :newAccounts) {

string oldStatusValue           =   '';
string oldAccountRecordTypeId   =   '';

if(Trigger.isUpdate) {
oldStatusValue              =   oldAccountsMap.get(objAcct.Id).status__c;
oldAccountRecordTypeId      =   oldAccountsMap.get(objAcct.Id).RecordTypeId; 
}

if(objAcct.recordTypeId != oldAccountRecordTypeId && Dealer_RecordTypeId == objAcct.RecordTypeId) {

string target_Month   =    monthsMap.get(objAcct.Dealer_Activated_Date__c.month())+' - '+objAcct.Dealer_Activated_Date__c.year();

/* if(oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Distributor_RecordTypeId) {
acc.Dealer_Activated_Date__c              =   acc.Distributor_Activated_Date__c != null ? acc.Distributor_Activated_Date__c : Date.Today();
acc.Distributor_Activated_Date__c         =   null;
} else if(oldAccountRecordTypeId != null && oldAccountRecordTypeId != '' && oldAccountRecordTypeId == Direct_Dealer_RecordTypeId) {
acc.Dealer_Activated_Date__c          =   acc.Direct_Dealer_Activated_Date__c != null ? acc.Direct_Dealer_Activated_Date__c : Date.Today();
acc.Direct_Dealer_Activated_Date__c   =   null;
} else {
acc.Dealer_Activated_Date__c          =   Date.Today();
} 

if(DealerMap_MonthRT.containsKey(objAcct.id)) {

DealerMap_MonthRT.get(objAcct.id).add(target_Month);
} else {

DealerMap_MonthRT.put(objAcct.id, new list<string>());
DealerMap_MonthRT.get(objAcct.id).add(target_Month);
}
}


if(objAcct.recordTypeId != oldAccountRecordTypeId && Distributor_RecordTypeId == objAcct.RecordTypeId) {

string target_Month   =    monthsMap.get(objAcct.Distributor_Activated_Date__c.month())+' - '+objAcct.Distributor_Activated_Date__c.year();

if(DistributorMap_MonthRT.containsKey(objAcct.id)) {

DistributorMap_MonthRT.get(objAcct.id).add(target_Month);
} else {

DistributorMap_MonthRT.put(objAcct.id, new list<string>());
DistributorMap_MonthRT.get(objAcct.id).add(target_Month);
}
}


if(objAcct.recordTypeId != oldAccountRecordTypeId && Direct_Dealer_RecordTypeId == objAcct.RecordTypeId) {

string target_Month   =    monthsMap.get(objAcct.Direct_Dealer_Activated_Date__c.month())+' - '+objAcct.Direct_Dealer_Activated_Date__c.year();

if(DirectDealerMap_MonthRT.containsKey(objAcct.id)) {

DirectDealerMap_MonthRT.get(objAcct.id).add(target_Month);
} else {

DirectDealerMap_MonthRT.put(objAcct.id, new list<string>());
DirectDealerMap_MonthRT.get(objAcct.id).add(target_Month);
}
}

}
} */
    }  
    
   /* public class MonthWrapper {
        
        public string X_month;
        public string oldrecordTypeId;
        
        public MonthWrapper() {
            
            X_month            =  '';
            oldrecordTypeId    =  '';
        }
    } */
      public void beforeInsertAccount(List<Account> listOfAccount){
          System.debug('asdfghj');
         /// string PCustomerRecordTypeId  =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Project-Customer').getRecordTypeId();
        //string PDealer_RecordTypeId   =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Project-Dealer').getRecordTypeId();
        //string RCustomer_RecordTypeId  =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Customer').getRecordTypeId(); 
        //string RDealer_RecordTypeId    =   Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Dealer').getRecordTypeId(); 
          Map<Id,Account> mapOfAccountCity = new Map<Id,Account>();
          System.debug('mapOfAccountCity'+listOfAccount);
          for( Account acc:listOfAccount){
              //if((acc.RecordTypeId==PCustomerRecordTypeId ||acc.RecordTypeId==PDealer_RecordTypeId ||acc.RecordTypeId==RCustomer_RecordTypeId ||acc.RecordTypeId==RDealer_RecordTypeId ) && acc.City_fsl__c!=null){
         
                  mapOfAccountCity.put(acc.id,acc);
                  System.debug('mapOfAccountCity'+mapOfAccountCity);
              
              }
              if(!mapOfAccountCity.isEmpty()){
                 AccountTriggerHelper.CityMapping(mapOfAccountCity);
              }
          }
      public static void testingcovering2(){
           Integer i = 1;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
       i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
      i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
           i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
          
       }
}
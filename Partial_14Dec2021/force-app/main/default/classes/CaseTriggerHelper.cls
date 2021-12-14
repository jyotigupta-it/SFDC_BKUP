public without sharing class CaseTriggerHelper {
    
    public static void createWorkOrderForCase(Map<Id,Case> mapOfCases){
        System.debug('Helper');
        Set<Id> setOfProbIds = new Set<Id>();
        for(Case c: mapOfCases.values()){
            setOfProbIds.add(c.Problem__c);
        }
        Map<Id,Problem__c> mapOfProblem = new Map<Id,Problem__c>([Select Id,Work_Type__c from Problem__c where Id in: setOfProbIds]);
        
        CaseSelector cs=new CaseSelector();
        Set<Id> setOfAccountIds = new Set<Id>();
        Map<Id,Contact> mapOfAccountIdToContact = new Map<Id,Contact>();
        Map<Id,Case> mapOfCaseDetails = cs.getCaseDetailsFromSet(mapOfCases.keySet());
        for(Case c: mapOfCases.values()){
            setOfAccountIds.add(c.AccountId);
        }
        System.debug('Acc iDs'+setOfAccountIds);
        List<Contact> listOfContacts = [Select id ,AccountId from Contact where AccountId  in:setOfAccountIds];
        System.debug('Contacts'+listOfContacts);
        for(Contact con :listOfContacts){
            mapOfAccountIdToContact.put(con.AccountId,con);
        }
        System.debug('Contact Map'+mapOfAccountIdToContact);
        List<Entitlement> listOfEntitlements = [select id from Entitlement where name = 'Work Order Process'];
        List<WorkOrder> listOfWorkOrdersToInsert = new List<WorkOrder>();
        for(Case c: mapOfCases.values()){
            WorkOrder wo = new WorkOrder();
            wo.CaseId = c.Id;
            wo.Case_Owner__c = c.OwnerId;
            if(mapOfAccountIdToContact.containsKey(c.AccountId))
                wo.ContactId = mapOfAccountIdToContact.get(c.AccountId).Id;
            wo.EntitlementId = listOfEntitlements[0].Id;
            if(c.Service_Territory__c != null)
                wo.ServiceTerritoryId = c.Service_Territory__c;
            System.debug('Con'+c.Contractor__c);
            if(c.Contractor__c != null)
                wo.ownerId = c.Contractor__c;
            if(mapOfProblem != null && mapOfProblem.containsKey(c.Problem__c) && mapOfProblem.get(c.Problem__c).Work_Type__c != null)
                wo.WorkTypeId = mapOfProblem.get(c.Problem__c).Work_Type__c;
            
            if(mapOfCaseDetails.containsKey(c.Id) && mapOfCaseDetails.get(c.Id).AccountId != null){
                // System.debug('Street Addr'+mapOfCaseDetails.get(c.Id).Account.Street_Address__c);
                if(mapOfCaseDetails.get(c.Id).Account.Can_you_please_give_address_retail__c != null)
                    wo.Street = mapOfCaseDetails.get(c.Id).Account.Can_you_please_give_address_retail__c;
                if(mapOfCaseDetails.get(c.Id).Account.Town_Name__r.Name != null)
                    wo.City = mapOfCaseDetails.get(c.Id).Account.Town_Name__r.Name;
                if(mapOfCaseDetails.get(c.Id).Account.PinCode__c != null)
                    wo.PostalCode = mapOfCaseDetails.get(c.Id).Account.PinCode__c;
                if(mapOfCaseDetails.get(c.Id).Account.State__c != null)
                    wo.State = mapOfCaseDetails.get(c.Id).Account.State__c;
                if(mapOfCaseDetails.get(c.Id).Account.Country_fsl__c != null)
                    wo.Country = mapOfCaseDetails.get(c.Id).Account.Country_fsl__c;
                if(c.closure_code__c != null){
                    wo.closure_code__c = c.Closure_Code__c;
                }
                
            }
            if(c.AccountId != null)
                wo.AccountId = c.AccountId;
            listOfWorkOrdersToInsert.add(wo);
            
        }
        if(!listOfWorkOrdersToInsert.isEmpty()){
            insert listOfWorkOrdersToInsert;
        }
    }
    
    public static void CityMapping(List<Case> listOfCases){
        system.debug('listOfCases'+listOfCases);
        List<Case> listOfCase=new List<Case>();
        List<Id> listOfServiceCity=new List<Id>();
        List<Id> setIds=new List<Id>();
        Set<Id> setofAccountId=new Set<Id>() ;
        List<Account> listOfAccount =new List<Account> ();
        List<Territory_Contractors__c> listOfTerritory=new List<Territory_Contractors__c>();
        Map<Id,Territory_Contractors__c> mapofserviceWithContractor=new  Map<Id,Territory_Contractors__c>();
        // CaseSelector cs=new CaseSelector();
        // Map<Id,Case> mapOfCaseDetails = cs.getCaseDetailsFromSet(mapOfCases.keySet());
        Map<String,ServiceTerritory> mapofCitynameWithterritory=new Map<String,ServiceTerritory>();
        if(!listOfCases.isEmpty()){
            for(Case cse:listOfCases){
                System.debug('Account Id'+cse.AccountId);
                if(cse.AccountId!=null){
                    setofAccountId.add(cse.AccountId);
                }
            }}
        listOfAccount=[select id,City_lookup__c from Account where id =:setofAccountId];
        system.debug('listofAccount'+listOfAccount);
        if(!listOfAccount.isEmpty()){
            for(Account acc:listOfAccount){
                if(acc.City_lookup__c!=null){
                    setIds.add(acc.City_lookup__c) ;
                }
            }}
        
        listOfTerritory=[select id,Service_Territory__c,Contractor__c from Territory_Contractors__c where Service_Territory__c=:setIds];
        system.debug('listOfTerritory'+listOfTerritory);
        if(!listOfTerritory.isEmpty()){
            for(Territory_Contractors__c tc:listOfTerritory){
                system.debug('listOfTerritory'+listOfTerritory);
                mapofserviceWithContractor.put(tc.Service_Territory__c,tc);
                System.debug('mapofserviceWithContractor'+mapofserviceWithContractor);
                
            }
        }  
        if(!listOfCases.isEmpty()){
            for(Case c:listOfCases){
                if(!listOfAccount.isEmpty()){
                    for(Account acc:listOfAccount){
                        System.debug('City lookup population'+acc.City_lookup__c);
                        if(acc.id==c.AccountId){
                            if(!mapofserviceWithContractor.isEmpty()){
                                c.Service_Territory__c=mapofserviceWithContractor.get(acc.City_lookup__c).Service_Territory__c;
                                c.Contractor__c=mapofserviceWithContractor.get(acc.City_lookup__c).Contractor__c;
                            }}
                    }
                }}
        }
        
        
        
        
    }
    
    public static void validationAndAssignmentForTerritoryContractor(Map<Id,Case> mapOfCases, List<id> listOfId){
        List<Territory_Contractors__c> listOfTerritoryContractor=[select id,Service_Territory__c,Contractor__c from Territory_Contractors__c where Service_Territory__c=:listOfId ];
        Map<Id,Territory_Contractors__c> mapofserviceWithContractor=new Map<id,Territory_Contractors__c>();
        if(!listOfTerritoryContractor.isEmpty()){
            for(Territory_Contractors__c tc:listOfTerritoryContractor){
                mapofserviceWithContractor.put(tc.Service_Territory__c,tc);
            }}
        System.debug('inside trritory method');
        for(case cse:mapOfCases.values()){
            System.debug('inside for loop');
            Territory_Contractors__c tc = mapofserviceWithContractor.get(cse.Service_Territory__c);
            if(tc.Contractor__c!=null)
                cse.Contractor__c=tc.Contractor__c;
            else
                cse.addError('No Contractor available for this city');
            
        }
        
    }
    public static void updateWorkOrder(Map<Id,Case> mapOfCases){
        List<WorkOrder> listOfWorkerOrders = [select id,ServiceTerritoryId,CaseId,Case_Owner__c,AccountId,ownerId from WorkOrder where CaseId in:mapOfCases.keyset()];
        List<WorkOrder> listOfWorkOrdersToInsert = new List<WorkOrder>();
        for(WorkOrder wo:listOfWorkerOrders){
            wo.Case_Owner__c=mapOfCases.get(wo.CaseId).OwnerId;
            wo.ServiceTerritoryId=mapOfCases.get(wo.CaseId).Service_Territory__c;
            wo.OwnerId=mapOfCases.get(wo.CaseId).Contractor__c;
            wo.AccountId = mapOfCases.get(wo.CaseId).AccountId;
            listOfWorkOrdersToInsert.add(wo);
        }
        if(!listOfWorkOrdersToInsert.isEmpty()){
            update listOfWorkOrdersToInsert;
        }
    }
    public static void validationForCaseClosed(Map<Id,Case> mapOfCases){
        List<WorkOrder> listOfWorkerOrders = [select id,Status,CaseId from WorkOrder where CaseId in:mapOfCases.keyset()];
        Map<id,List<WorkOrder>> mapOfCaseWithWorkOrder = new Map<id,List<WorkOrder>>();
        if(!listOfWorkerOrders.isEmpty()){
            for(WorkOrder wo:listOfWorkerOrders){
                if(mapOfCaseWithWorkOrder.containsKey(wo.CaseId))
                    mapOfCaseWithWorkOrder.get(wo.CaseId).add(wo);
                else
                    mapOfCaseWithWorkOrder.put(wo.CaseId, new List<workorder>{wo});
            }}
        for(Case eachCase:mapOfCases.values()){
            List<WorkOrder> listOfWorkOrdersToCheck =mapOfCaseWithWorkOrder.get(eachCase.id);
            System.debug('listOfWorkOrdersToCheck****'+listOfWorkOrdersToCheck);
            for(WorkOrder wo:listOfWorkOrdersToCheck){
                
                if(wo.Status !='Completed by Plumber' && wo.Status !='Closed' && wo.Status !='Cannot Complete' && wo.Status !='Canceled'){
                    
                    eachCase.addError('Case cannot be closed because work order is not closed') ;
                }
            }
        }
        
        
    }
    Public static void caseStatusIsReopen(Map<Id,Case> mapOfCases){
        List<Case> listOfCase =new List<Case>();
        for(Case eachCase:mapOfCases.values()){
            eachCase.Status='Re-Open';
            listOfCase.add(eachCase);
        }
        
    }
    public static void createCaseProducts(Map<Id,Case> mapOfCases){
        List<Case_Products__c> listOfCaseProductsToBeInserted = new List<Case_Products__c>();
        for(Case eachCase:mapOfCases.values()){
            Case_Products__c cp = new Case_Products__c();
            cp.Case__c = eachCase.Id;
            cp.Product_Family__c = eachCase.product_Family__c;
            cp.Product__c = eachCase.Product__c;
            cp.Problem__c = eachCase.Problem__c;
            cp.Do_u_have_products_invoice_bill_copy__c = eachCase.Do_You_have_any_invoice_copy_or__c;
            cp.Can_you_let_us_know_the_dealer_name__c = eachCase.Can_you_please_let_us_know_the_dealer__c;
            if(eachCase.Quantity__c != null)
                cp.Quantity__c = Integer.valueOf(eachCase.Quantity__c);
            cp.When_did_you_purchase_the_product__c =eachCase.When_did_you_purchase__c;
            listOfCaseProductsToBeInserted.add(cp);
        } 
        if(!listOfCaseProductsToBeInserted.isEmpty()){
            insert listOfCaseProductsToBeInserted;
        }
    }
    public static void createServiceCharges(Map<id,Case> casemap){
        Map<id,Workorder> wrkmap=new Map<id,Workorder>();
        Map<id,user> usermap=new Map<id,user>();
        List<Variable_cost__mdt> mdtlist=new List<Variable_cost__mdt>();
        List<Service_Charge__c> serchrlist=new List<Service_Charge__c>();
        wrkmap=new Map<id,Workorder>([Select id,Time_to_solve_a_ticket__c,caseid,status,ownerid,(select id from WorkOrderLineItems) from workorder where caseid in:casemap.keyset() and status='Closed']);
        mdtlist=[Select id,X1st_Product_24hrs__c,X1st_Product_24hrs_48hrs__c,X1st_Product_48hrs_more__c,Rest_of_Product_24hrs__c,Rest_of_Product_24hrs_48hrs__c,Rest_of_Product_48hrs_more__c from Variable_cost__mdt where DeveloperName='Variable_cost'];
        System.debug('****mdtlist'+mdtlist);
        if(!wrkmap.isEmpty()){
            for(Workorder wrk:wrkmap.values()){
                usermap.put(wrk.ownerId,null); 
            }
           /* if(!usermap.isempty()){
                usermap=new Map<id,user>([Select id,contactid,contact.accountId,contact.account.Service_Fixed_Payment__c from user where id in: usermap.keyset()]);
            }*/
           for(Workorder wrk:wrkmap.values()){
                Service_Charge__c sv=new Service_Charge__c();
                sv.Work_Order__c=wrk.id;
                if(!(wrk.WorkOrderLineItems).isEmpty()){
                    decimal restcharge=0;
                    System.debug('wrk.Time_to_solve_a_ticket__c*****:'+wrk.Time_to_solve_a_ticket__c);
                    if(wrk.Time_to_solve_a_ticket__c < 24){
                        sv.Service_Charge_Amount__c=mdtlist[0].X1st_Product_24hrs__c;
                        restcharge=mdtlist[0].Rest_of_Product_24hrs__c;
                    }else if(wrk.Time_to_solve_a_ticket__c >= 24 && wrk.Time_to_solve_a_ticket__c < 48){
                        sv.Service_Charge_Amount__c=mdtlist[0].X1st_Product_24hrs_48hrs__c;
                        restcharge=mdtlist[0].Rest_of_Product_24hrs_48hrs__c;
                    }else if(wrk.Time_to_solve_a_ticket__c >= 48){
                        sv.Service_Charge_Amount__c=mdtlist[0].X1st_Product_48hrs_more__c;
                        restcharge=mdtlist[0].Rest_of_Product_48hrs_more__c;
                    }
                    System.debug('*1***amount :'+sv.Service_Charge_Amount__c);
                    if((wrk.WorkOrderLineItems).size() > 1){
                        sv.Service_Charge_Amount__c += ((wrk.WorkOrderLineItems).size()-1)*restcharge;
                        System.debug('*2***amount :'+sv.Service_Charge_Amount__c);
                    }
                    sv.ownerid=wrk.ownerid;
                    /*if(usermap.containsKey(wrk.OwnerId) && usermap.get(wrk.OwnerId)!=null){
                        System.debug('*******Accountfixed **'+usermap.get(wrk.OwnerId).contact.account.Service_Fixed_Payment__c);
                        sv.Service_Charge_Amount__c += usermap.get(wrk.OwnerId).contact.account.Service_Fixed_Payment__c;
                    }*/
                    serchrlist.add(sv);
                }
            }
        }
        if(!serchrlist.isEmpty()){
            insert serchrlist;
            Approval.lock(wrkmap.values(), false);
        }
        
        
    }
    
    
}
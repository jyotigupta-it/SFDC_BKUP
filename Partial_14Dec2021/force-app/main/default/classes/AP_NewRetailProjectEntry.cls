global with sharing class AP_NewRetailProjectEntry {

    public Opportunity opportunityRecord {get;set;}
    public list<Influencer__c> influencerList {get;set;}
    public list<wrapperInfluencer> wrapInfuList {get;set;}
    public list<Project_Tracker__c> trackerList {get;set;}
    public String recordTypeId {get;set;}
    public AP_Taluk_Master__c brandingTaluk{get;set;}    
    String returnURL;


    public class myException extends Exception {
        
    }


    public AP_NewRetailProjectEntry(ApexPages.StandardController controller) {
        this.opportunityRecord = new Opportunity();
        this.influencerList = new list<Influencer__c>();
        this.trackerList = new list<Project_Tracker__c>();
        this.wrapInfuList   = new list<wrapperInfluencer>();
        recordTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Individual Contacts'].id;
        returnURL = ApexPages.CurrentPage().getParameters().get('retURL');

        
        Map<String, Influencer_types__c> nameToCstmSettingMap = Influencer_types__c.getAll();
        
        for(String type : nameToCstmSettingMap.keySet()){
            Influencer__c inf = new Influencer__c();
            inf.Influencer_Type__c = nameToCstmSettingMap.get(type).Type__c;
            wrapperInfluencer wInfu = new wrapperInfluencer();
            wInfu.influ = inf;           
            wrapInfuList.add(wInfu);
        }
       
        Map<String, Project_Tracker_Questions__c> trackerNameToCstmSettingMap = Project_Tracker_Questions__c.getAll();
        
        for(String trackerName : trackerNameToCstmSettingMap.keySet()){
            Project_Tracker__c tracker = new Project_Tracker__c();
            tracker.Question__c = trackerNameToCstmSettingMap.get(trackerName).Question__c;
            trackerList.add(tracker);
        }
    }

    /*********** On Save ***********/
    public PageReference saveProject(){
        set<Id> accIds = new set<Id>();
        set<Id> conIds = new set<Id>();
        set<String> updateVisit = new set<String>();
        Savepoint sp = Database.setSavepoint();
        try{

            insert opportunityRecord;

            list<Influencer__c> influencerNewList = new List<Influencer__c>();
            for(wrapperInfluencer wrap:wrapInfuList){

                influencerNewList.add(wrap.influ);
            }
            
            list<Influencer__c> influencerToInsertList = new List<Influencer__c>();
            for(Influencer__c inf:influencerNewList){
                inf.Opportunity__c = opportunityRecord.Id;
                if(inf.Account__c != null){
                    accIds.add(inf.Account__c);
                    
                }
               
                if(inf.Update_of_Last_Visit__c != null){
                    updateVisit.add(inf.Update_of_Last_Visit__c);
                }
                influencerToInsertList.add(inf);
            }
            
            if(accIds.size() == 0 && updateVisit.size() == 0) {
                
                ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'Please fill details of alteast one influencer');
                ApexPages.addMessage(theMessage);
                throw new myException('Please fill details of alteast one influencer');
                return null;
            }
            else {
                insert influencerToInsertList;
            }
            list<Project_Tracker__c> projectTrackerToInsertList = new List<Project_Tracker__c>();
            for(Project_Tracker__c tracker:trackerList){
                tracker.Opportunity__c = opportunityRecord.Id;
                projectTrackerToInsertList.add(tracker);
            }
            insert projectTrackerToInsertList;
          
     
            PageReference pf = new PageReference('/'+opportunityRecord.Id);
            pf.setRedirect(true);
            return pf;
        }
        catch(Exception e){
            opportunityRecord = opportunityRecord.clone(false,false);
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return NULL;
        }

    }


/******** On Cancel *********/

    public PageReference cancel(){
        PageReference pfc = new PageReference('/006/o');
        pfc.setRedirect(true);
        return pfc;
       

    }

    public class wrapperInfluencer {
        public Influencer__c influ {get;set;}
        public String firmName {get;set;}

        public wrapperInfluencer() {
            firmName = '';
        }

    }

    @RemoteAction
    global static String getAccountInfo(String accName){
    
        Account acc;
        //if(accName.size()>0) {

            acc = [SELECT id,Firm_Name__c,Name FROM Account WHERE Name=:accName limit 1];

            return acc.Firm_Name__c;
        
    }

    public PageReference calRender (){
       
        return null;
    }
    public void projectCategoryVal(){
  opportunityRecord.Category__c='';
  
  
 if(Apexpages.currentPage().getParameters().get('firstParam')+''!='null' && Apexpages.currentPage().getParameters().get('firstParam')+''!='' ){
     
             opportunityRecord.Approximate_Project_Value__c=Apexpages.currentPage().getParameters().get('firstParam');
   
    if(opportunityRecord.Approximate_Project_Value__c == 'Rs.0 – Rs.5Lakhs'){
           opportunityRecord.Category__c='Low End';
           }
    else if (opportunityRecord.Approximate_Project_Value__c == 'Rs.5Lakhs – Rs.20Lakhs' ){   
           opportunityRecord.Category__c='Mid End';

        }
        else if (opportunityRecord.Approximate_Project_Value__c == 'Rs.20Lakhs and Above'){
        opportunityRecord.Category__c='High End';
        }
       }
   
  }        
    public void getTalukDetails(){
 system.debug('inside gettaluk');
 
  if(opportunityRecord.taluk__c <> null ){
  
  brandingTaluk = [select Name, Cluster__c, District__c, State__c from AP_Taluk_Master__c where id =:opportunityRecord.taluk__c];
    system.debug('gettaluk'+brandingTaluk);
      opportunityRecord.State__c =brandingTaluk.State__c;
      opportunityRecord.District__c = brandingTaluk.District__c;
      opportunityRecord.Cluster__c = brandingTaluk.Cluster__c;
 }
 
 else{
    opportunityRecord.State__c ='';
      opportunityRecord.District__c = '';
      opportunityRecord.Cluster__c ='';
  }
  
}
}
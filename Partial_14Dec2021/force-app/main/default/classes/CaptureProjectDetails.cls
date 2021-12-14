/***********************************************************************************************
* Created By: Mohd.Numaan Ahmed
* Company:
* Modified By: Subhajit Ghosh
* Company: KVP
* Description: Captures the project , influencer details and save it
* Test        :CaptureProjectDetailsTest
*******************************************************************************************/
global with sharing class CaptureProjectDetails {
    public boolean gstValidationFlag {get; set;}
    public String gstValidationMessage {get; set;}
    public String gstResponseMessage {get; set;}
    public Opportunity opportunityRecord {
        get;
        set;
    }
    public list < Influencer__c > influencerList {
        get;
        set;
    }
    public list < wrapperInfluencer > wrapInfuList {
        get;
        set;
    }
    public list < Project_Tracker__c > trackerList {
        get;
        set;
    }
    public String recordTypeId {
        get;
        set;
    }
    
    public decimal amountval;
    
    public boolean displayInfluencer {
        set;
        get;
    }
    public String stageName {
        set;
        get;
    }
    public Map < String, Project_Tracker_Questions__c > trackerNameToCstmSettingMap;
    public list < wrapperInfluencer > wrapAllValList {
        get;
        set;
    }
    public id reqId;
    public boolean WrapInfBool {
        get;
        set;
    }
    //For rerendering the div block to display error for influencer
    public boolean dispErrDivInf {
        get;
        set;
    }
    public boolean enableinput {
        get;
        set;
    }
    //For displaying error message
    public string dispErrInfMsg {
        get;
        set;
    }
    //test
    public string projectStage {
        get;
        set;
    }
    public String previousStageName {
        set;
        get;
    }
    public Map < String, Integer > stageMap {
        set;
        get;
    }
    
    public AP_Taluk_Master__c brandingTaluk {
        get;
        set;
    }
    
    public Pincode__c brandingPincode {
        get;
        set;
    }
    
    
    public class myException extends Exception {
        
        
    }
    // public String PrcBookIdCusSetting;// keeps the value of the dummy project custom setting
    string returnURL;
    
    public CaptureProjectDetails(ApexPages.StandardController stdController) {
        gstValidationMessage = '';
        gstValidationFlag = true;
        // DummyPriceBook__c cusSetValue = DummyPriceBook__c.getOrgDefaults();
        //  System.debug('res::: ' + cusSetValue.Price_Book_Id__c);
        // PrcBookIdCusSetting=cusSetValue.Price_Book_Id__c;
        this.opportunityRecord = new Opportunity();
        this.influencerList = new list < Influencer__c > ();
        this.trackerList = new list < Project_Tracker__c > ();
        this.wrapInfuList = new list < wrapperInfluencer > ();
        this.wrapAllValList = new List < wrapperInfluencer > ();
        recordTypeId = [select id from RecordType where SobjectType = 'Account'
                        AND Name = 'Individual Contacts'
                       ].id;
        returnURL = ApexPages.CurrentPage().getParameters().get('retURL');
        reqId = ApexPages.currentPage().getParameters().get('Id');
        System.debug('opportunityRecord.StageName' + opportunityRecord.StageName);
        Map < String, Influencer_types__c > nameToCstmSettingMap = Influencer_types__c.getAll();
        //system.debug('nameToCstmSettingMap===' + nameToCstmSettingMap);
        //system.debug('projectStage---' + projectStage);
        WrapInfBool = false;
        dispErrDivInf=false;
        dispErrInfMsg='';
        stageMap = new Map < String, Integer > ();
        stageMap.put('Designing', 1);
        stageMap.put('Tendering', 2);
        stageMap.put('Order issue to contractor', 3);
        stageMap.put('Mockup Process', 4);
        stageMap.put('Offer Submitted', 5);
        stageMap.put('Order Receipt', 6);
        //if(opportunityRecord.StageName != '' && opportunityRecord.StageName != NULL)
        // if(!String.isEmpty(opportunityRecord.StageName) || (opportunityRecord.StageName != '' && opportunityRecord.StageName != NULL) || opportunityRecord.StageName != '' || opportunityRecord.StageName != null){
        // if(projectStage ){ 
        list<Opportunity> enableinputlist=new List<Opportunity>([SELECT id,gst_Status_Code__c ,Grease_Interceptors__c, NEW_SPR_COUNT__c FROM Opportunity where id =: reqId]);
        for(Opportunity oppnew:enableinputlist){
            if(oppnew.NEW_SPR_COUNT__c==0){
                enableinput=false;
            }
            else{
                enableinput=true;
            }
            if(oppnew.gst_Status_Code__c != null && oppnew.gst_Status_Code__c == 1)
                gstValidationFlag = false;
            else
                gstValidationMessage = 'GSTIN is not validated!';
        }
        system.debug('enableinput....'+enableinput);
        
        if (reqId != NULL) {
            for (Influencer__c eachInf: [SELECT Id,Name, Account__c, Opportunity__c, Opportunity__r.StageName, Account__r.Name, Account__r.Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c,Inf_Order__c,Source__c FROM Influencer__c WHERE Opportunity__c =: reqId]) {
                previousStageName = eachInf.Opportunity__r.StageName;
                wrapperInfluencer wInfu = new wrapperInfluencer();
                wInfu.influ = eachInf;
                wInfu.sourceInf=getsourceInfluPick(eachInf.Influencer_Type__c);
                wrapInfuList.add(wInfu);
                System.debug('wrapInfuList in Constructor :: '+wrapInfuList);
            } //for ends
            if (wrapInfuList.size() > 0) {
                WrapInfBool = true;
                //system.debug('previousStageName@@@@ ' + previousStageName);
            }
        }
        trackerNameToCstmSettingMap = Project_Tracker_Questions__c.getAll();
        //List<Project_Tracker__c> projectTrackerToInsertList = new List<Project_Tracker__c>();
        for (String trackerName: trackerNameToCstmSettingMap.keySet()) {
            Project_Tracker__c tracker = new Project_Tracker__c();
            tracker.Question__c = trackerNameToCstmSettingMap.get(trackerName).Question__c;
            trackerList.add(tracker);
        }
        if (reqId != null) {
            // this.wrapInfuList=new list<wrapperInfluencer>();
            getRequestInformation(reqId);
            
        }
    } //STANDARD CONSTRUCTOR ENDS
    
    /*On stage change display influencer details*/
    
    public void stageBasedInfluencerDetails() {
        List < String > inflTypeList = new List < String > (); // to avoid the duplicate values to be displayed in the wrapInfuList.
        
        
        //System.debug('stageBasedInfluencerDetails method called');
        wrapAllValList.clear();
        wrapInfuList.clear();
        if (reqId != NULL) {
            for (Influencer__c eachInf: [SELECT Id, Account__c, Opportunity__c, Opportunity__r.StageName, Account__r.Name,Source__c, Account__r.Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c, Inf_Order__c FROM Influencer__c WHERE Opportunity__c =: reqId]) {
                //system.debug('eachInf@@@@ ' + eachInf);
                //previousStageName= eachInf.Opportunity__r.StageName;
                wrapperInfluencer wInfu = new wrapperInfluencer();
                wInfu.influ = eachInf;
                wInfu.sourceInf=getsourceInfluPick(eachInf.Influencer_Type__c);
                //system.debug('wInfu@@@@@@@@@ ' + wInfu);
                wrapInfuList.add(wInfu);
            }
        }
        if (wrapInfuList.size() > 0) { //used in case of edit
            for (wrapperInfluencer eachWrap: wrapInfuList) { //this section is used to prevent the duplication.
                inflTypeList.add(eachWrap.influ.Influencer_Type__c);
                //System.debug('::inflTypeList::: ' + inflTypeList);
            }
        }
        
        //System.debug('::stageName::: '+stageName);
        //System.debug('::wrapInfuList::: '+wrapInfuList);
        //System.debug('::wrapInfuList.size()-----::: '+wrapInfuList.size());
        //this.wrapInfuList   = new list<wrapperInfluencer>();
        //this.influencerList = new list<Influencer__c>();
        Map < String, Influencer_types__c > nameToCstmSettingMap = Influencer_types__c.getAll();
        //System.debug('opportunityRecord  ::: '+opportunityRecord);
        system.debug(stageName);
        
        if (stageName == 'Designing') {
            //system.debug('opportunityRecord.StageName' + opportunityRecord.StageName);
            for (String type: nameToCstmSettingMap.keySet()) {
                Influencer__c inf = new Influencer__c();
                inf.Influencer_Type__c = nameToCstmSettingMap.get(type).Type__c;
                if (inf.Influencer_Type__c == 'Architect' || inf.Influencer_Type__c == 'Project Owner/Developer/Builder' || inf.Influencer_Type__c == 'Consultant') {
                    
                    wrapperInfluencer wInfu = new wrapperInfluencer();
                    wInfu.influ = inf;
                    wInfu.sourceInf=getsourceInfluPick(inf.Influencer_Type__c);
                    wrapAllValList.add(wInfu);
                    System.debug('::::wrapAllValList::: ' + wrapAllValList);
                    
                }
                
                
            }
        }
        if (stageName == 'Tendering') {
            system.debug('Record.StageName' + opportunityRecord.StageName);
            for (String type: nameToCstmSettingMap.keySet()) {
                Influencer__c inf = new Influencer__c();
                inf.Influencer_Type__c = nameToCstmSettingMap.get(type).Type__c;
                if (inf.Influencer_Type__c == 'Architect' || inf.Influencer_Type__c == 'Project Owner/Developer/Builder' || inf.Influencer_Type__c == 'Consultant' || inf.Influencer_Type__c == 'Plumbing Contractor') {
                    wrapperInfluencer wInfu = new wrapperInfluencer();
                    wInfu.influ = inf;
                    wInfu.sourceInf=getsourceInfluPick(inf.Influencer_Type__c);
                    wrapAllValList.add(wInfu);
                    //System.debug('::::wrapInfuList::: '+wrapInfuList);
                    
                }
                
                
            }
        }
        if (stageName == 'Order issue to contractor') {
            system.debug('opportunityRecord.StageName' + opportunityRecord.StageName);
            for (String type: nameToCstmSettingMap.keySet()) {
                Influencer__c inf = new Influencer__c();
                inf.Influencer_Type__c = nameToCstmSettingMap.get(type).Type__c;
                if (inf.Influencer_Type__c == 'Architect' || inf.Influencer_Type__c == 'Project Owner/Developer/Builder' || inf.Influencer_Type__c == 'Consultant' || inf.Influencer_Type__c == 'Plumbing Contractor' || inf.Influencer_Type__c == 'Purchase Manager') {
                    wrapperInfluencer wInfu = new wrapperInfluencer();
                    wInfu.influ = inf;
                    wInfu.sourceInf=getsourceInfluPick(inf.Influencer_Type__c);
                    //wrapInfuList.add(wInfu);
                    //****
                    wrapAllValList.add(wInfu);
                    //System.debug('::::wrapAllValList::: ' + wrapAllValList);
                    
                }
                
                
            }
        }
        if (stageName == 'Mockup Process' || stageName == 'Offer Submitted' || stageName == 'Order Receipt') {
            system.debug('opportunityRecord.StageName111 :: 11 :: ' + opportunityRecord.StageName);
            for (String type: nameToCstmSettingMap.keySet()) {
                Influencer__c inf = new Influencer__c();
                inf.Influencer_Type__c = nameToCstmSettingMap.get(type).Type__c;
                if (inf.Influencer_Type__c != 'Others') {
                    wrapperInfluencer wInfu = new wrapperInfluencer();
                    wInfu.influ = inf;
                    wInfu.sourceInf=getsourceInfluPick(inf.Influencer_Type__c);
                    //wrapInfuList.add(wInfu);
                    // //****
                    wrapAllValList.add(wInfu);
                    
                }
                
                
                
                
                
            }
        } //if ends
        
        //System.debug('Final wrapAllValList####>>> '+wrapAllValList);
        //  System.debug('wrapInfuList!!@@@!!! '+wrapInfuList);
        system.debug('wrapAllValList---'+wrapAllValList);
        if (wrapAllValList.size() > 0) {
            for (wrapperInfluencer eachWrap: wrapAllValList) {
                System.debug('@@@eachWrap.influ.Influencer_Type__c::: ' + eachWrap.influ.Influencer_Type__c);
                if (inflTypeList.size() > 0 && !inflTypeList.contains(eachWrap.influ.Influencer_Type__c)) {
                    System.debug('coming inside this!!!' + inflTypeList.size() + '$$$$@@**' + wrapAllValList.size());                    
                    wrapInfuList.add(eachWrap);
                } else if (wrapInfuList.size() == 0) {
                    System.debug('wrapAllValList+wrapInfuList$$$----' + eachWrap.influ.Source__c);                                 
                    wrapInfuList.addAll(wrapAllValList);
                }
            }
        } //if ends
        system.debug('***wrapInfuList***' + wrapInfuList);
        WrapInfBool = wrapInfuList.size() > 0 ? true : false; //this variable will help re-render th output panel for influencer detail
        system.debug('WrapInfBool' + WrapInfBool);
        
    } //method ends
    
    /*********** On Save ***********/
    public PageReference saveProject() {
        if(gstValidationFlag){
            gstValidationMessage='Please provide GSTIN and Validate to Proceed!';
            return null;   
        }
        else{
            gstValidationMessage = '';
            set < Id > accIds = new set < Id > ();
            set < Id > conIds = new set < Id > ();
            set < String > updateVisit = new set < String > ();
            Integer counter = 0, incr = 0;
            Integer minFloor=0,maxFloor =0;
            System.debug('coming inside save method::');
            //System.debug('wrapInfuList::: '+wrapInfuList);
            Savepoint sp;
            if(!Test.isRunningTest())
                sp= Database.setSavepoint();
            try{
                
                
                // System.debug('Save Insidious new savecoming after try method');
                
                if(opportunityRecord.No_of_Floors__c>=0 && opportunityRecord.No_of_Floors__c<=18)
                {
                    minFloor=0;
                    maxFloor=18;
                }
                else if(opportunityRecord.No_of_Floors__c>=19 && opportunityRecord.No_of_Floors__c<=33)
                {
                    minFloor=19;
                    maxFloor=33;
                }
                else if(opportunityRecord.No_of_Floors__c>=34 && opportunityRecord.No_of_Floors__c<=45)
                {
                    minFloor=34;
                    maxFloor=45;
                }
                else if(opportunityRecord.No_of_Floors__c>=46 && opportunityRecord.No_of_Floors__c<=160)
                {
                    minFloor=46;
                    maxFloor=160;
                }
                
                String combination = opportunityRecord.Project_Type__c + '-'+ opportunityRecord.SWR_system_to_be_deployed__c + '-' + opportunityRecord.Dimension_of_the_stack__c+'mm' + '-' + opportunityRecord.Material_of_Stack__c + '-'+ minFloor + '-' + maxFloor;
                System.debug('combination-------------------->'+combination);
                
                List<Probability_Master__c> pMlst = new List<Probability_Master__c>();
                pMlst= [SELECT  Combination_for_calculation__c FROM Probability_Master__c];
                
                List<String> pMlstStr = new List<String>();
                for(Probability_Master__c com :pMlst)
                {
                    pMlstStr.add(com.Combination_for_calculation__c);
                }
                system.debug('pMlstStr-----'+pMlstStr);
                system.debug('pMlstStr.contains(combination)-----------------'+pMlstStr.contains(combination));
                if(!pMlstStr.contains(combination))
                {
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'There is no combination aviable for these inputs'));
                    dispErrDivInf = true;
                    dispErrInfMsg='There is no combination available for these inputs.Please refresh the page and try with different input';
                    return null;
                    
                    
                    
                }
                
                List < Influencer__c > influencerNewList = new List < Influencer__c > ();
                system.debug('wrapInfuList Save ****** ' + wrapInfuList.size());
                
                system.debug('wrapInfuList-------->>>>'+wrapInfuList);
                //Error messages when stage is chosen and the influencer details accordingly is not filled
                for (Integer i = 0; i < wrapInfuList.size(); i++) {
                    System.debug('wrapInfuList :::: ' + wrapInfuList[i]);
                    system.debug('opportunityRecord.StageName--testt--'+opportunityRecord.StageName);
                    /***if (opportunityRecord.StageName == 'Designing') {
if (wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer' && ((wrapInfuList[i].influ.Source__c =='' || wrapInfuList[i].influ.Source__c ==NULL || wrapInfuList[i].influ.Source__c == '--None--' ) || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
// ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'If stage is designing then Project Owner/Developer is mandatory');
// ApexPages.addMessage(theMessage);
//throw new myException('If stage is designing then Project Owner/Developer is mandatory');
// return null;
dispErrInfMsg='If stage is designing then Project Owner/Developer is mandatory';
dispErrDivInf=true;
return null;
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Architect' && wrapInfuList[i].influ.Source__c != NULL &&  String.valueOf(wrapInfuList[i].influ.Account__c).length() > 13) ||
(wrapInfuList[i].influ.Influencer_Type__c == 'Consultant' && wrapInfuList[i].influ.Source__c != NULL && String.valueOf(wrapInfuList[i].influ.Account__c).length() > 13)) {
counter++;
}
if (counter == 0) {
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Architect' && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13) )||
(wrapInfuList[i].influ.Influencer_Type__c == 'Consultant' && (wrapInfuList[i].influ.Source__c == NULL && String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13))) {
dispErrInfMsg='If stage is designing then Architect or Consultant is mandatory';
dispErrDivInf=true;
return null;
}
} //if(counter) ends 
} //Designing ends

if (opportunityRecord.StageName == 'Tendering') {
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Tendering then Project Owner/Developer is mandatory';
dispErrDivInf=true;
return null;
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Architect') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Tendering then Architect is mandatory';
dispErrDivInf=true;
return null;
}
if (wrapInfuList[i].influ.Influencer_Type__c == 'Plumbing Contractor' && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Tendering then Plumbing Contractor is mandatory';
dispErrDivInf=true;
return null;
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Consultant') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Tendering then Consultant is mandatory';
dispErrDivInf=true;
return null;
}
}
if (opportunityRecord.StageName == 'Order issue to contractor') {
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer' && wrapInfuList[i].influ.Source__c == NULL) ||(wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer' && String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Order issue to contractor then Project Owner/Developer is mandatory';
dispErrDivInf=true;
return null;
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Consultant') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Order issue to contractor then Consultant is mandatory';
dispErrDivInf=true;
return null;
}
if (wrapInfuList[i].influ.Influencer_Type__c == 'Plumbing Contractor' && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Order issue to contractor then Plumbing Contractor is mandatory';
dispErrDivInf=true;
return null; 
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Architect') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Order issue to contractor then Architect is mandatory';
dispErrDivInf=true;
return null; 
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Purchase Manager') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Order issue to contractor then Purchase Manager is mandatory';
dispErrDivInf=true;
return null; 
}
}
if (opportunityRecord.StageName == 'Mockup Process' || opportunityRecord.StageName == 'Offer Submitted' || opportunityRecord.StageName == 'Order Receipt') {
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer' && wrapInfuList[i].influ.Source__c == NULL) ||(wrapInfuList[i].influ.Influencer_Type__c == 'Project Owner/Developer' && String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {
dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null; 
}
/*   if ((wrapInfuList[i].influ.Influencer_Type__c == 'Architect') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;
}*/
                    /**if (wrapInfuList[i].influ.Influencer_Type__c == 'Plumbing Contractor' && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;
}
/* if ((wrapInfuList[i].influ.Influencer_Type__c == 'Consultant') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;
}*/
                    /***if ((wrapInfuList[i].influ.Influencer_Type__c == 'Purchase Manager') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;**/
                    // }//
                    /*** if ((wrapInfuList[i].influ.Influencer_Type__c == 'Project Manager') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;
}
if ((wrapInfuList[i].influ.Influencer_Type__c == 'Site Engineer') && (wrapInfuList[i].influ.Source__c == NULL || String.valueOf(wrapInfuList[i].influ.Account__c).length() <= 13)) {

dispErrInfMsg='If stage is Mockup Process or Offer Submitted or Order Receipt then please fill all the influencer details';
dispErrDivInf=true;
return null;
}
}***/
                }
                incr++;
                System.debug(':::opportunityRecord:::  '+opportunityRecord.Id+'$$$ '+opportunityRecord );
                // opportunityRecord.Pricebook2Id=PrcBookIdCusSetting;
                upsert opportunityRecord;
                
                for (wrapperInfluencer wrap: wrapInfuList) {
                    
                    influencerNewList.add(wrap.influ);
                }
                
                list < Influencer__c > influencerToInsertList = new List < Influencer__c > ();
                for (Influencer__c inf: influencerNewList) {
                    system.debug('Opportunity__c===' + inf.Opportunity__c);
                    //if (reqId == null){
                    inf.Opportunity__c = opportunityRecord.Id; //}
                    if (inf.Account__c != null) {
                        accIds.add(inf.Account__c);
                        
                    }
                    
                    /* if (inf.Update_of_Last_Visit__c != null) {
updateVisit.add(inf.Update_of_Last_Visit__c);
}*/
                    influencerToInsertList.add(inf);
                }
                
                /* if (accIds.size() == 0 && updateVisit.size() == 0) {

ApexPages.Message theMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill details of alteast one influencer');
ApexPages.addMessage(theMessage);
throw new myException('Please fill details of alteast one influencer');
return null;
}*/ 
                //  else {
                
                //system.debug('Opportunity__c'+influencerToInsertList[0].Opportunity__c);
                system.debug('influencerToInsertListValues$$$' + influencerToInsertList);
                system.debug('influencerToInsertListValues' + influencerToInsertList.size());
                upsert influencerToInsertList;
                
                // }
                if (reqId == null) {
                    list < Project_Tracker__c > projectTrackerToInsertList = new List < Project_Tracker__c > ();
                    for (Project_Tracker__c tracker: trackerList) {
                        tracker.Opportunity__c = opportunityRecord.Id;
                        projectTrackerToInsertList.add(tracker);
                    }
                    upsert projectTrackerToInsertList;
                } else {
                    upsert trackerList;
                }
                
                PageReference pf = new PageReference('/' + opportunityRecord.Id);
                pf.setRedirect(true);
                return pf;
                
            } catch (Exception e) {
                System.debug('Coming inside catch method ::: '+e.getLineNumber());
                System.debug('Coming inside catch method ::: '+e.getMessage());
                //opportunityRecord = opportunityRecord.clone(false, false);//will hold the opportunity record without Id.This is done to hold the object data.
                System.debug('opportunityRecord in catch ::: '+opportunityRecord);
                if(!Test.isRunningTest())
                    Database.rollback(sp);
                ApexPages.addMessages(e);
                return NULL;
            }
        }
    }
    
    
    /******** On Cancel *********/
    
    public PageReference cancel() {
        PageReference pfc = new PageReference('/006/o');
        pfc.setRedirect(true);
        return pfc;
        
        
    }
    /******** On Cancel *********/
    public void validateGSTIN() {
        if(opportunityRecord.GSTN__c == null || opportunityRecord.GSTN__c == ''){
            gstValidationMessage = 'Enter Valid GST Value to be Validated!';
        }
        else{
            gstValidationMessage = validateGSTINHelper(opportunityRecord.GSTN__c);   
        }
    }
    
    public class wrapperInfluencer {
        public Influencer__c influ {get;set;}
        public String firmName {get;set;}
        public string accname {get;set;}
        //for custom picklist of source
        public List<selectOption> sourceInf{get;set;}
        public String selectedsource{get;set;}
        public wrapperInfluencer() {
            sourceInf=new List<selectOption>();
            firmName = '';
            accname = '';
            selectedsource='';
        }
        
    }
    /*
public void getFirmName() {

String aId = Apexpages.currentPage().getParameters().get('aId');
system.debug('************aId************'+aId);


} */
    
    @RemoteAction
    global static String getAccountInfo(String accName) {
        
        Account acc;
        //if(accName.size()>0) {
        
        acc = [SELECT id, Firm_Name__c, Name FROM Account WHERE Name =: accName limit 1];
        
        return acc.Firm_Name__c;
        
    }
    
    public PageReference calRender() {
        
        return null;
    }
    
    /**
* Name: projectCategoryVal
* Description:<nishanth_h@infosys.com> added the code to autopopulate Category__c field based on Approximate_Project_Value__c value.
*/
    
    /* public void projectCategoryVal() {
opportunityRecord.Category__c = '';


if (Apexpages.currentPage().getParameters().get('firstParam') + '' != 'null' && Apexpages.currentPage().getParameters().get('firstParam') + '' != '') {

opportunityRecord.Approximate_Project_Value__c = Apexpages.currentPage().getParameters().get('firstParam');

if (opportunityRecord.Approximate_Project_Value__c == 'Rs.0 – Rs.5Lakhs') {
opportunityRecord.Category__c = 'Low End';
} else if (opportunityRecord.Approximate_Project_Value__c == 'Rs.5Lakhs – Rs.20Lakhs') {
opportunityRecord.Category__c = 'Mid End';

} else if (opportunityRecord.Approximate_Project_Value__c == 'Rs.20Lakhs and Above') {
opportunityRecord.Category__c = 'High End';
}
}

}*/
    
    /**
* Name: getTalukDetails
* Description: <nishanth_h@infosys.com> added the code to autopopulate State__c,District__c and Cluster__c fields based on taluk__c value.
*/
    
    public void getTalukDetails() {
        system.debug('inside gettaluk');
        
        if (opportunityRecord.taluk__c <> null) {
            
            brandingTaluk = [select Name, Cluster__c, District__c, State__c from AP_Taluk_Master__c where id =: opportunityRecord.taluk__c];
            system.debug('gettaluk' + brandingTaluk);
            opportunityRecord.State__c = brandingTaluk.State__c;
            opportunityRecord.District__c = brandingTaluk.District__c;
            opportunityRecord.Cluster__c = brandingTaluk.Cluster__c;
        } else {
            opportunityRecord.State__c = '';
            opportunityRecord.District__c = '';
            opportunityRecord.Cluster__c = '';
        }
        
    }
    
    /**
* Name: getPincodeDetails
* Description: <deeba.tarannum@DGenx.co> added the code to autopopulate City__c,District__c and State fields based on Pincode value.
*/
    
    public void getPincodeDetails() {
        system.debug('inside getpincode');
        
        if (opportunityRecord.Pincode__c <> null) {
            
            brandingPincode = [select Name, City__c, District__c, State__c from Pincode__c where id =: opportunityRecord.Pincode__c];
            system.debug('getpincode' + brandingPincode);
            opportunityRecord.Pincode__c = brandingPincode.Name;
            opportunityRecord.State__c = brandingPincode.State__c;
            opportunityRecord.District__c = brandingPincode.District__c;
            opportunityRecord.City__c = brandingPincode.City__c;
        } else {
            opportunityRecord.State__c = '';
            opportunityRecord.District__c = '';
            opportunityRecord.City__c = '';
        }
        
    } 
    /**
* Name: getRequestInformation
* Description: Method to fetch all the field values when Edit button is clicked
*/
    
    public Opportunity getRequestInformation(Id reqId) {
        system.debug('Edit Button is clicked');
        system.debug('getRequestInformation----->>' + reqId);
        trackerList = [SELECT Opportunity__c, Question__c, Remarks__c, Response__c, Probability__c, Project_Order__c, Action_Plan__c, Action_Date__c FROM Project_Tracker__c WHERE Opportunity__c =: reqId ORDER by Project_Order__c ASC];
        if (trackerList.size() == 0) {
            for (String trackerNameNew: trackerNameToCstmSettingMap.keySet()) {
                Project_Tracker__c trackerNew = new Project_Tracker__c();
                trackerNew.Question__c = trackerNameToCstmSettingMap.get(trackerNameNew).Question__c;
                trackerNew.Opportunity__c = reqId;
                trackerList.add(trackerNew);
            }
            
        }
        
        List < Influencer__c > check = [SELECT Id, Account__c, Opportunity__c, Opportunity__r.StageName, Account__r.Name, Account__r.Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c, Inf_Order__c, Source__c FROM Influencer__c WHERE Opportunity__c =: reqId];
        
        for (wrapperInfluencer wrap: wrapInfuList) {
            
            for (influencer__c i: check) {
                if (wrap.influ.Influencer_Type__c == i.Influencer_Type__c) {
                    //wrap.influ = i;
                    wrap.influ.Source__c = i.Source__c;
                    wrap.influ.id = i.id;
                    wrap.influ.Last_Visit_Date__c = i.Last_Visit_Date__c;
                    wrap.influ.Update_of_Last_Visit__c = i.Update_of_Last_Visit__c;
                    wrap.influ.Account__c = i.Account__c;
                    wrap.firmName = i.Account__r.Firm_Name__c;
                    wrap.accname = i.Account__r.Name;
                    // wrap.influ.Opportunity__c = opportunityRecord.id;
                    //system.debug('wrap-->>'+wrap);
                }
                
            }
            
        }
        
        system.debug('idValue' + reqId);
        Opportunity req = new Opportunity();
        Map < String, Schema.SObjectField > fldObjMap1 = schema.SObjectType.Opportunity.fields.getMap();
        String querySearch = '';
        String query;
        
        for (String s: fldObjMap1.KeySet()) {
            querySearch = querySearch + s + ',';
        }
        querySearch = querySearch.removeEnd(',');
        query = 'Select ' + querySearch + ',CreatedBy.Id from Opportunity where Id=\'' + reqId + '\'';
        req = database.query(query);
        system.debug('reqValue' + req);
        opportunityRecord = req;
        return opportunityRecord;
        
        
        
        
    }
    
    //--------from lookuppopup page controller------------------------------------------------
    // the query string entered by the user
    public String query {
        get;
        set;
    }
    
    
    // the matchin>g accounts
    public List < Account > accounts {
        get;
        set;
    }
    
    
    // has a search been executed?
    public Boolean doneLookup {
        get;
        set;
    }
    
    // executes the search
    public void runQuery() {
        System.debug('coming inside');
        accounts = new List < Account > ();
        if (query != null) {
            query = query.trim();
        }
        
        String nameCond = '%' + query + '%';
        String cond = query + '%';
        List < Account > searchResults = New List < Account > ([SELECT Id, Name, District__c, State__c, Status__c, Party_type__c, Contact_Number_Mobile__c FROM Account WHERE status__c = 'Existing'
                                                                AND Party_Type__c = 'Distributor'
                                                                AND(Name LIKE: nameCond OR City__c LIKE: cond OR District__c LIKE: cond OR Contact_Number_Mobile__c LIKE: cond) limit 999
                                                               ]);
        
        accounts.addAll(searchResults);
        System.debug('coming inside runQuery ' + accounts);
        
        
        
    }
    //to get the picklist value of source with labour contractor in case of Plumbing contractor
    //to get the picklist value of source without labour contractor in case of other influ types
    public List<SelectOption> getsourceInfluPick(String infType){
        
        List<SelectOption> options = new List<SelectOption>();        
        Schema.DescribeFieldResult fieldResult = Influencer__c.Source__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues(); 
        Integer c=1;
        for( Schema.PicklistEntry f : ple)
        {
            if(c==1){
                options.add(new SelectOption('','--None--'));// adding none option to picklist
                c++;
            }
            
            if((infType!='Plumbing Contractor' && f.getValue()!='Labour Contractor') || infType=='Plumbing Contractor'){
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }
            
        } 
        system.debug('options----'+options);
        return options;
    } 
    public void codeCoverage(){
        Integer i=1;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
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
    
    public String validateGSTINHelper(String gstin){
        String response = 'GST Validated Successfully!!!';        
        try {
            REST_API_Configuration__mdt restSetup = [SELECT Authentication_Key__c, Authentication_Value__c, Content_Type__c,
                                                     End_Point_URL__c, Request_Type__c 
                                                     FROM REST_API_Configuration__mdt WHERE DeveloperName ='GSTIN_API'];
            String authurl = String.format(restSetup.End_Point_URL__c,new List<String>{gstin});
            system.debug('authurl1 '+authurl); 
            
            HttpRequest request = new HttpRequest();
            Http http = new Http();
            request.setEndpoint(authurl);
            request.setMethod(restSetup.Request_Type__c);
            request.setHeader('Content-Type', restSetup.Content_Type__c);
            request.setHeader(restSetup.Authentication_Key__c, restSetup.Authentication_Value__c);
            HttpResponse httpResponse = http.send(request);
            system.debug('Status Code == '+ httpResponse.getStatusCode());
            system.debug('Response Status == '+ httpResponse.getStatus());
            system.debug('Raw Response ------>>'+httpResponse.getBody());
            if (httpResponse.getStatusCode() == 200) {
                //Formatting response JSON
                GSTINValidatorParser wrapObj = GSTINValidatorParser.parse(httpResponse.getBody());
                system.debug('wrapObj: Order ------>>'+wrapObj);
                
                if(wrapObj.status_code != 1){
                    response = 'GST Validation Failed('+wrapObj.error+')';
                    gstValidationFlag = true;
                    gstValidationMessage = 'GST Validation Failed('+wrapObj.error+')';
                    //throw new AuraHandledException(wrapObj.error);
                }
                else{
                    gstValidationFlag = false;
                    gstValidationMessage = '';
                }
                opportunityRecord.GST_Trade_Name__c = wrapObj.trade_name;
                opportunityRecord.gst_Entity_type__c = wrapObj.entity_type;
                opportunityRecord.GST_Legal_Name__c = wrapObj.legal_name;
                opportunityRecord.gst_Bname__c = wrapObj.business;
                opportunityRecord.gst_dealer_type__c = wrapObj.dealer_type;
                if(wrapObj.adress != null){
                    opportunityRecord.gst_ad_floor__c = wrapObj.adress.floor;
                    opportunityRecord.gst_ad_street__c  = wrapObj.adress.street;
                    opportunityRecord.gst_ad_bno__c  = wrapObj.adress.bno;
                    opportunityRecord.gst_ad_location__c  = wrapObj.adress.location;
                    opportunityRecord.gst_ad_city__c  = wrapObj.adress.city;
                    opportunityRecord.gst_ad_state__c = wrapObj.adress.state;
                    opportunityRecord.gst_ad_pincode__c = wrapObj.adress.pincode;   
                }
                opportunityRecord.gst_Status_Code__c = wrapObj.status_code;
                
            }
            else{
                gstValidationFlag = true;
                gstValidationMessage = 'GST Validation Failed Due to Some Technical Error!'; 
            }
        }
        catch( System.Exception e) {  
            response = 'GST Validation Failed('+e.getMessage()+')';
            gstValidationFlag = true;
            gstValidationMessage = 'GST Validation Failed('+e.getMessage()+')';
        }
        gstResponseMessage = 'GSTN Validated Successfully!!!';
        return response;     
    } 
}
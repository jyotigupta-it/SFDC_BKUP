/*********************************************************************************      
* Name: MapAccountUtility
* Description: Class for handling all the accounts for plotting on GoogleMap 
* Created By: Chakresh Verma, Bishal Polai, Samarth Nadig
* Created Date: 
*
**********************************************************************************/
public with sharing class MapAccountUtility {
    
    public String geocode_latitude{get; set;}
    public String geocode_longitude{get; set;}
    public String latitudeData{get; set;}
    public String longitudeData{get; set;}
    public Integer radius{get; set;}
    public boolean pickHandle{get; set;}
    public boolean valHandle{get; set;}
    public boolean dateHandle{get; set;} 
    public boolean boolHandle{get; set;} 
    public boolean integerHandle{get;set;}
    public boolean doubleHandle{get;set;}
    public String boolVal{get; set;}        
    public boolean acc{get;set;} 
    public boolean accVar{get;set;} 
    public Date datVal{get;set;}
    public String sel{get;set;}
    public List<SelectOption> pickListValuesList{get;set;}
    public List<SelectOption> operatorValues{get;set;}
    
    public String searchRecByName{get;set;}      //Common Filter   
    public String selectedRating{get;set;}  //Account Filter
    public String selectedField{get;set;}
    public String operatorVal{get;set;}
    public String selectedValByString{get;set;}
    public String selectedValByPickList{get;set;}
    public Integer selectedValByInteger{get;set;}
    public Double selectedValByDouble{get;set;}
    public Map<String,Schema.SObjectField> allfield{get;set;}
    public List<SelectOption> relatedObjectFieldsList{get;set;}
    public map<string,Schema.SObjectType> allSchema{get;set;}
    public List<String> filterAddVal{get;set;}
    public List<String> selectedFieldList{get;set;}
    public List<String> selectedOperatorList{get;set;}
    Public List<String> selectedStringValList{get;set;}
    Public List<String> selectedPickListValList{get;set;}
    Public List<Date> selectedDateValList{get;set;}
    Public List<Boolean> selectedBoolValList{get;set;}
    public List<Integer> selectedIntegerList{get;set;}
    public List<Double> selectedDoubleList{get;set;}
    public List<Object> filteredList{get;set;}
    public boolean disableDoneButton{get;set;}
    public Map<String,Object> mapVal;
    public String[] pickListValues{get;set;}
    public List<SelectOption> booleanValue{get;set;}
    public List<Object> allSelecttedValues;
    
    public static String currentChurn{get;set;}
    public static String currentNPS{get;set;}
    public static String recPhNo{get;set;}
    public static string recName{get; set;} //SAMARTH
    public static Id recId{get;set;} //SAMARTH
    public List<Opportunity> oppList{get;set;} //SAMARTH
    public List<Secondary_Sales_Order__c> orderList{get;set;} //SAMARTH
    public List<Promotion__c> promoList{get;set;}//SAMARTH
    public List<Attachment> attachedFiles{get;set;}
    public List<MapRepTest__c>getData {get;set;}
    public List<SecondaryWrapper> secondaryData{get;set;}
   
    Map<Id,Id> beatplanAccMap{get;set;}
    
    //---------------------------SAVING THE BEAT---------------------------
    public boolean displayPopup {get; set;}  
    //public Beat_Plan__c beatplan{get;set;}
    public string searchbeat{get;set;}
    public Date beatDate{get;set;}
    public List<Beat_Plan__c> saveBeat{get;set;}
    public List<Beat_Plan_Account__c> saveBeatPlanAccount{get;set;}
    public List<Beat_Master__c> beatMasterList{get;set;}
    public boolean renderPlanTable{get;set;}
    public Integer checkListSize{get;set;}
    //---------------------------SAVING THE BEAT---------------------------
    public boolean checkindatavalue{get;set;}
    public string CurrentId{get;set;}
   
    public String currentlat{get;set;}
    public String currentlng{get;set;}
    
    Map<String,MapRepTest__c> mapReportsCustom{get;set;}
    
    
    public String test{get;set;}
    public String tempSelectedfield;
    
    //creating beat
    
    public String BeatMsName{get;set;}
    public String BeatId{get;set;}
    public String BtName{get;set;}
    public String BtId{get;set;}
    
    public AP_Site_Visit__c visitsitedata{get;set;}
    public boolean displayPopupbeat {get; set;} 
    public boolean displayPopupbeat2 {get; set;} 
    public Beat_Plan__c beatplan{get;set;}
    public ApexPages.StandardController controller; 
    public Beat_Master__c beatmst{get;set;}
    public Beat_Master_Account__c btacc{get;set;}
    
    public Set<Id> beatAccountId {get;set;}
    public List<Account> beatAccounts{get;set;}
    public boolean showbeatstr{get;set;}
    public List<Beat_Plan_Account__c> retrieveBeat {get;set;}
    
    public Beat_Master__c setbeatmst(Beat_Master__c bm){
        this.beatmst=bm;
        return beatmst;
    }
    public boolean beatUpdatemessage{get;set;}//for beat update message
    
    //-----------------------CONSTRUCTOR STARTS-------------------------
    public MapAccountUtility(ApexPages.StandardController controller){
        
        renderPlanTable = false;
        beatmst=new Beat_Master__c();
        btacc =new Beat_Master_Account__c();
        visitsitedata = new AP_Site_Visit__c();
        
        pickListValuesList= new List<SelectOption>();
        operatorValues=new List<SelectOption>();
        pickListValues= new List<String>();
        beatMasterList = new List<Beat_Master__c>();
        allSelecttedValues= new List<Object>();
        booleanValue= new List<SelectOption>();
        
        // latLong=false;  
        // selectedField='';
        selectedValByInteger=null;
        selectedValByDouble=null;
        System.debug('Constru'+selectedValByDouble);
        disableDoneButton=true;
        
        
        //checkindatavalue = false;
        beatUpdatemessage = false;
        boolVal='false';
        filterAddVal=new List<String>();
        searchRecByName=null;        
        selectedRating=null;
        geocode_latitude=null;
        geocode_longitude=null;
        radius=null;
        pickHandle=false;
        boolHandle=false;
        valHandle=true;
        dateHandle=false;
        integerHandle=false;
        doubleHandle=false;
        acc=false;
        allSchema=Schema.getGlobalDescribe();
        allfield= new  Map<String,Schema.SObjectField>();
        selectedFieldList= new List<String>();
        selectedOperatorList= new List<String>();
        selectedStringValList= new List<String>();
        selectedPickListValList= new List<String>();
        selectedDateValList= new List<Date>();
        selectedBoolValList= new List<Boolean>();
        selectedIntegerList= new List<Integer>();
        selectedDoubleList= new List<Double>();      
        filteredList= new List<Object>();
        mapVal= new Map<String,Object>();
        tempSelectedfield='';
        
        Map<String,MapRepTest__c>alldata= MapRepTest__c.getAll();   
        getData = alldata.values();
        system.debug('getData ' + getData);
        beatplanAccMap= new map<id,id>();
        BeatplanVisitmethod();
        
        
        
    }
    //-----------------------CONSTRUCTOR ENDS-------------------------
    
    // method to return Account all fields as a picklist
    public List<SelectOption> getAccountFields() {
        System.debug(allField);  
        // relatedObjectFieldsList.add(new SelectOption('-Choose Field-','-Choose Field-'));
        allfield= allSchema.get('Account').getDescribe().fields.getMap();   
        relatedObjectFieldsList= new List<SelectOption>();
        relatedObjectFieldsList.add(new selectoption('-None-','-None-'));
        for(String srt:allfield.keyset()){
            Schema.DisplayType fielddataType = allfield.get(srt).getDescribe().getType();
            if(String.valueOf(fielddataType)=='PICKLIST'||String.valueOf(fielddataType)=='PHONE'||String.valueOf(fielddataType)=='STRING'||String.valueOf(fielddataType)=='DATETIME'
               ||String.valueOf(fielddataType)=='DATE'||String.valueOf(fielddataType)=='DOUBLE'||String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY'||String.valueOf(fielddataType)=='BOOLEAN'){
                   
                   string objectlable=allfield.get(srt).getDescribe().getLabel();
                   if(objectlable!='No Remarks'&& objectlable!='Yes Remarks'&& objectlable!='Total Order Value'){
                       
                       relatedObjectFieldsList.add(new selectoption(srt,objectlable));            
                   }
               }
        } 
        relatedObjectFieldsList.sort();
        return relatedObjectFieldsList;
    }
    
    
    
    //method to return the Logical Operator as a picklist(SOQL)
    public List<SelectOption> getOperators() {
        if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
            Schema.DisplayType fielddataType = allfield.get(selectedField).getDescribe().getType();
            System.debug('null'+fielddataType);
            //operators which are suitable for PICKLIST data type
            if(String.valueOf(fielddataType)=='PICKLIST'&&fielddataType!=null){                
                //operatorValues.add(new SelectOption('LIKE','Contains'));
                operatorValues.add(new SelectOption('IN','Equals'));
                operatorValues.add(new SelectOption('Not IN','Not equals'));
            }
            //operators which are suitable for STRING data type
            
            if((String.valueOf(fielddataType)=='STRING'&&fielddataType!=null)||(String.valueOf(fielddataType)=='PHONE'&&fielddataType!=null)){
                operatorValues.add(new SelectOption('LIKE','Contains'));
                operatorValues.add(new SelectOption('=','Equals'));      
                operatorValues.add(new SelectOption('!=','Not equals'));
                operatorValues.add(new SelectOption('LIKE1','Starts with'));
                //operators which are suitable for DATETIME data type
                
            } if((String.valueOf(fielddataType)=='DATETIME'&&fielddataType!=null)||(String.valueOf(fielddataType)=='DATE'&&fielddataType!=null)) {          
                // operatorValues.add(new SelectOption('=','Equals'));      
                operatorValues.add(new SelectOption('!=','Not equals'));
                operatorValues.add(new SelectOption('<','Less than'));
                operatorValues.add(new SelectOption('<=','Less or equal'));
                operatorValues.add(new SelectOption('>','Greater than'));
                operatorValues.add(new SelectOption('>=','Greater or equal')); 
                
                
                //operators which are suitable for DOUBLE or INTEGER data type
                
            } if((String.valueOf(fielddataType)=='DOUBLE'||String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY')&&fielddataType!=null){                
                operatorValues.add(new SelectOption('=','Equals'));      
                operatorValues.add(new SelectOption('!=','Not equals'));
                operatorValues.add(new SelectOption('<','Less than'));
                operatorValues.add(new SelectOption('<=','Less or equal'));
                operatorValues.add(new SelectOption('>','Greater than'));
                operatorValues.add(new SelectOption('>=','Greater or equal')); 
                
                
            }
            if(String.valueOf(fielddataType)=='BOOLEAN'&&fielddataType!=null){
                //operatorValues.add(new SelectOption('LIKE','Contains'));
                operatorValues.add(new SelectOption('=','Equals'));      
                operatorValues.add(new SelectOption('!=','Not equals'));
                //operatorValues.add(new SelectOption('LIKE1','Starts with'));
                //operators which are suitable for DATETIME data type
                
            }           
            
        }
        else{
            
            operatorValues.clear();
        }
        
        return operatorValues;
    }
    
    
    // method  to return Account Fields in String(JSON format)  
    public String getAccountLatLong1(){ 
        
        System.debug('Coming in add check method'+mapVal);
        
        
        List<Object> totResults = new List<Object>(); 
        
        //List<Object> results;
        List<String> columns = new List<String>();  
        System.debug('fielddataType='+datVal);
        String orderBy = '';
        String sql = 'SELECT ';
        System.debug('lat long value'+geocode_latitude+' '+geocode_longitude);
        // sql += 'Name,Map_Field__c,Id,Contact_Number_Mobile__c,Party_Type__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Account WHERE Geolocation__Latitude__s!=null And Geolocation__Longitude__s!=null And Geolocation__Latitude__s!= 0 And Geolocation__Longitude__s!= 0 ';// And Account.OwnerID =\''+UserInfo.getUserId()+'\'';
        sql += 'Name,Map_Field__c,Id,Party_Type__c,Contact_Number_Mobile__c,Total_Order_Values__c,PredictedClass__c,Current_NPS__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Account WHERE Geolocation__Latitude__s!=null And Geolocation__Longitude__s!=null And Geolocation__Latitude__s!= 0 And Geolocation__Longitude__s!= 0 And PredictedClass__c!=null And Account.OwnerID =\''+UserInfo.getUserId()+'\'';
        
        
        
        /* Added by bishal for Geocoder Purpose*/
        
        /* if(geocode_latitude!=null && geocode_latitude!='' && geocode_longitude!=null && geocode_longitude!='' && radius!=null && radius!='' && radius=='[0-9] {2}'){
sql+='And DISTANCE(BillingAddress, GEOLOCATION('+geocode_latitude+', '+geocode_longitude+'), \'km\') < '+radius;
}else{
sql+='';
}*/
        
        if(geocode_latitude!=null && geocode_latitude!='' && geocode_longitude!=null && geocode_longitude!='' && radius!=null&&radius>0){
            sql+=' And DISTANCE(Geolocation__c, GEOLOCATION('+geocode_latitude+', '+geocode_longitude+'), \'km\') < '+radius;
        }else{
            sql+='';
        }
        Integer fieldList=0;
        Integer OperatorList=0;
        Integer StringValList=0; 
        Integer pickList=0;
        Integer dateList=0;
        Integer integerList=0;
        integer operatorList01;
        integer StringValList12;
        integer integerList22;
        integer operatorList7;
        integer doubleList12;
        integer operatorList5;
        integer selectedOperatorList12;
        integer operatorList3;
        integer operatorList2;
        Integer doubleList=0;
        Integer fieldList1=selectedFieldList.size();
        Integer OperatorList1=selectedOperatorList.size();
        Integer StringValList1=selectedStringValList.size();
        Integer pickList1=selectedPickListValList.size();
        Integer dateList1=selectedDateValList.size();
        Integer integerList1=selectedIntegerList.size();
        Integer doubleList1=selectedDoubleList.size();
        
        Schema.DisplayType fielddataType;
        IF(selectedFieldList.size()>0&&!selectedFieldList.contains('-None-')&&selectedOperatorList.size()>0&&!allSelecttedValues.isEmpty()){
            for(Integer i =0;i<selectedFieldList.size();i++){            
                if(fieldList1>0){//1
                    fielddataType = allfield.get(selectedFieldList[fieldList]).getDescribe().getType();
                    sql+=' And '+selectedFieldList[fieldList];
                    
                    //System.debug('VAlue Of if '+fieldList1+' '+OperatorList1+' '+StringValList1+' '+pickList1);
                    //start of string type field
                    if(String.valueOf(fielddataType)=='STRING'||String.valueOf(fielddataType)=='PHONE'){//2
                        if(OperatorList1>0){//3
                            if(selectedOperatorList[OperatorList]=='LIKE1'){
                                sql+=' LIKE';  
                                
                            }else{
                                sql+=' '+selectedOperatorList[OperatorList];
                            }
                            //if(StringValList1>0){//4
                            if(selectedOperatorList[OperatorList]=='LIKE'){//4.1
                                
                                String namVal= '%'+(String)allSelecttedValues[fieldList]+'%';
                                sql+=' \''+namVal+'\'';
                                system.debug('selectedOperatorList======>'+selectedOperatorList+OperatorList);
                                
                            }else if(selectedOperatorList[operatorList]=='LIKE1'){//4.2
                                String namVal= (String)allSelecttedValues[fieldList]+'%';
                                sql+=' \''+namVal+'\'';
                                
                                
                            }
                            //else for Other Operator
                            else{//4.3
                                sql+=' \''+(String)allSelecttedValues[fieldList]+'\''; 
                                
                            }//4.3
                            
                            //}//4
                        }//3
                        // StringValList++;
                        //StringValList1--;
                        
                    }//2
                    if(String.valueOf(fielddataType)=='PICKLIST'){
                        if(OperatorList1>0){//3
                            sql+=' '+selectedOperatorList[OperatorList];
                            // if(pickList1>0){
                            
                            //else for Other Operator
                            
                            sql+=' ('+(String)allSelecttedValues[fieldList]+') '; 
                            
                            
                            // }
                            
                        }
                        //   pickList++;
                        //   pickList1--;
                    }
                    if(String.valueOf(fielddataType)=='DATETIME'||String.valueOf(fielddataType)=='DATE'){
                        if(OperatorList1>0){//3
                            sql+=' '+selectedOperatorList[OperatorList];
                            //if(dateList1>0){
                            datVal=(Date)allSelecttedValues[fieldList];
                            sql+=':datVal';                            
                        }                                                
                        // }
                        // dateList++;
                        // dateList1--;                                        
                    }
                    if(String.valueOf(fielddataType)=='DOUBLE'){
                        if(OperatorList1>0){
                            sql+=' '+selectedOperatorList[OperatorList];
                            //if(doubleList1>0){
                            sql+=' '+(Double)allSelecttedValues[fieldList];
                            // }
                        }   
                        
                        // doubleList++;
                        //doubleList1--;
                        
                    }
                    if(String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY'){
                        if(OperatorList1>0){
                            sql+=' '+selectedOperatorList[OperatorList];
                            //  if(integerList1>0){
                            sql+=' '+(Integer)allSelecttedValues[fieldList];
                            //  }                                                
                        }   
                        
                        // integerList++;
                        // integerList1--;
                        
                    }
                    
                    if(String.valueOf(fielddataType)=='BOOLEAN'){
                        if(OperatorList1>0){
                            sql+=' '+selectedOperatorList[OperatorList];
                            //  if(integerList1>0){
                            sql+=' '+(BOOLEAN)allSelecttedValues[fieldList];
                            //  }                                                
                        }   
                        
                        // integerList++;
                        // integerList1--;
                        
                    }
                    
                    fieldList++;
                    OperatorList++;
                    
                    
                    fieldList1--;
                    OperatorList1--;                                                                
                }//1
                
            }    
        }
        
        sql+=' LIMIT 100';
        //-----------------------------------SEARCHING BASED ON CONDITION ENDS------------------------------------
        
        /* if(orderBy != null && orderBy != '') {

orderBy += ', Name ';

} else {

orderBy += ' Name ';
}
sql += ' ORDER BY '+orderBy+ 'LIMIT 500';

*/
        System.debug('The final sql is ' + sql);
        
        List<Object> results = Database.query(sql);
        system.debug('CONTENTS of RESULTS are ' + results);
        
        
        String resultsSerialized = JSON.serialize(results);
        
        resultsSerialized = resultsSerialized.replace('Geolocation__Latitude__s', 'Latitude');
        resultsSerialized = resultsSerialized.replace('Geolocation__Longitude__s', 'Longitude');
        
        List<Object> meta = (List<Object>) JSON.deserializeUntyped(resultsSerialized);
        
        system.debug('SQL::'+sql);
        system.debug('resultsSerialized:'+meta);
        
        
        
        //system.debug('Contents of results are ' + results);
        totResults.addAll(meta);
        if(JSON.serialize(totResults)==''||JSON.serialize(totResults)==null){
            System.debug('In the Null'+JSON.serialize(totResults));
        }
        
        
        //system.debug('results::'+results);
        // system.debug('totResults are ' + JSON.serialize(totResults));
        return JSON.serialize(totResults);
        
    }
    //----------------------------OBJECT WISE DISPLAY STARTS------------------------------
    
    public void accVar(){
        acc=true; 
        // accnew= true;
        geocode_latitude=null;
        geocode_longitude=null;
        radius=null;
        searchRecByName=null;
        selectedRating=null;
    }
    
    
    
    //----------------------------OBJECT WISE DISPLAY ENDS------------------------------
    
    
    public void search(){
        system.debug('search called');
        /*  if((selectedField!=null&&selectedField!=''&&operatorVal!=null&&operatorVal!='')||(selectedValByString!=null&&selectedValByString!='')
||(selectedValByPickList!=null&&selectedValByPickList!='')||datVal!=null||boolVal!=null||(selectedValByInteger!=null)||(selectedValByDouble!=null))
{
addListMethod();
}*/
        // latLong = true;
    }
    
    //this method handle the output panel when user select the field according to field which input should populate
    public void accFilter(){
        System.debug('Coming In accFilter');
        if(selectedField!='-None-'){
            Schema.DisplayType fielddataType = allfield.get(selectedField).getDescribe().getType();
            if(operatorValues!=null){
                operatorValues.clear();
            }
            if(relatedObjectFieldsList!=null){
                relatedObjectFieldsList.clear();
            }
            if(pickListValuesList!=null){
                pickListValuesList.clear();
            }
            System.debug('ACcFIlter'+String.valueOf(fielddataType)=='PICKLIST');
            // selectedFieldList.clear();
            if(String.valueOf(fielddataType)=='PICKLIST'){
                PartyTypeOptions();
                pickHandle=true;
                valHandle=false;
                dateHandle=false;
                boolHandle=false;
                integerHandle=false;
                doubleHandle=false;
                //selectedVal='';
            } if(String.valueOf(fielddataType)=='DATETIME'||String.valueOf(fielddataType)=='DATE'){
                pickHandle=false;
                dateHandle=true;
                valHandle=false;
                boolHandle=false;
                integerHandle=false;
                doubleHandle=false;
                // selectedVal='';
                
            } if(String.valueOf(fielddataType)=='BOOLEAN'){
                booleanValues();
                pickHandle=false;
                dateHandle=false;
                valHandle=false;
                boolHandle=true;
                integerHandle=false;
                doubleHandle=false;
            }
            if(String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY'){
                valHandle=false;
                dateHandle=false;
                pickHandle=false;
                boolHandle=false;
                integerHandle=true;
                doubleHandle=false;
                
            }
            if(String.valueOf(fielddataType)=='DOUBLE'){
                selectedValByDouble=null;
                valHandle=false;
                dateHandle=false;
                pickHandle=false;
                boolHandle=false;
                integerHandle=false;
                doubleHandle=true;
                System.debug('AccFilter'+selectedValByDouble);
                
            }
            if(String.valueOf(fielddataType)=='STRING'){
                valHandle=true;
                dateHandle=false;
                pickHandle=false;
                boolHandle=false;
                integerHandle=false;
                doubleHandle=false;
                
            }
            
            
        } 
        selectedValByString=null;
        selectedValByPickList=null;
        datVal=null;
        boolVal='false';
        selectedValByDouble=null;
        selectedValByInteger=null;        
        boolVal=null;
        if(pickListValues.size()>0&&pickListValues!=null){
            pickListValues.clear(); 
        }
    }
    
    //Creating dynamic picklists if user select the picklist type field 
    public void partyTypeOptions() {
        //System.debug('party type '+selectedField);
        if(selectedField!='-None'){
            Schema.DisplayType fielddataType = allfield.get(selectedField).getDescribe().getType();
            if(String.valueOf(fielddataType)=='PICKLIST'){
                list<Schema.PicklistEntry> values =
                    allfield.get(selectedField).getDescribe().getPickListValues();
                System.debug('PickList Values'+values);          
                //pickListValuesList.add(new SelectOption('-None-', '-None-'));
                for( Schema.PicklistEntry pickListVal : values){                            
                    pickListValuesList.add(new SelectOption(pickListVal.getLabel(), pickListVal.getValue()));     
                }
            }
            
            pickListValuesList.sort();
            
        }
        //return pickListValuesList;
    }
    
    public void booleanValues(){
        if(selectedField!='-None-'){
            Schema.DisplayType fielddataType = allfield.get(selectedField).getDescribe().getType();
            if(String.valueOf(fielddataType)=='BOOLEAN'){
                
                
                booleanValue.add(new SelectOption('false','False'));
                booleanValue.add(new SelectOption('true','True'));
                
            }
        }
    }
    
    
    
    public void addListMethod(){
        //System.debug('Values'+selectedValByDouble);
        
        //filteredList.clear();
        System.debug('Coming in add method'+mapVal);
        Schema.DisplayType fielddataType;
        string fieldlable;
        String fieldAPIName;
        if(selectedField!=null&&selectedField!='-None-'){
            fielddataType = allfield.get(selectedField).getDescribe().getType();
            fieldlable=allfield.get(selectedField).getDescribe().getLabel();
            fieldAPIName=selectedField;
            
        }
        if(operatorValues!=null){
            operatorValues.clear();
        }
        if(relatedObjectFieldsList!=null){
            relatedObjectFieldsList.clear();
        }
        if(pickListValuesList!=null){
            pickListValuesList.clear();
        }
        if(booleanValue!=null){
            booleanValue.clear();
        }
        
        if(mapVal.containsKey(selectedField)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info, 'You cannot add multiple filter on same field'));  
            selectedValByString=null;
        }
        
        if(!mapVal.containsKey(selectedField)){
            if((String.valueOf(fielddataType)=='STRING'&&fielddataType!=null&&selectedValByString!=null&&selectedValByString!='')||String.valueOf(fielddataType)=='PHONE'&&selectedValByString!=null&&selectedValByString!=''){
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                }  
                
            }
            if(String.valueOf(fielddataType)=='PICKLIST'&&pickListValues!=null&&!pickListValues.isEmpty()&&pickListValues.size()>0){
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                }  
                
            }
            if(String.valueOf(fielddataType)=='DATETIME'&&datVal!=null||String.valueOf(fielddataType)=='DATE'&&datVal!=null){
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                }   
            }
            if(String.valueOf(fielddataType)=='BOOLEAN'&&boolVal!=NULL){
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                } 
            }
            if((String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY')&&selectedValByInteger!=null&&selectedValByInteger!=0){ 
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                } 
            }   
            if(String.valueOf(fielddataType)=='DOUBLE'&&selectedValByDouble!=null&&selectedValByDouble!=0){ 
                if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                    selectedFieldList.add(selectedField);
                    
                    
                }
                if(operatorVal!=null&&operatorVal!=''){
                    selectedOperatorList.add(operatorVal);
                } 
            }   
            
            //for getting the selected field type
            if(selectedField!=null&&selectedField!=''&&selectedField!='-None-'){
                if((String.valueOf(fielddataType)=='STRING'&&fielddataType!=null&&selectedValByString!=null&&selectedValByString!='')||String.valueOf(fielddataType)=='PHONE'&&selectedValByString!=null&&selectedValByString!=''){
                    //  if(selectedValByString!=null&&selectedValByString!=''){
                    //selectedStringValList.add(selectedValByString);
                    // mapVal.put();
                    allSelecttedValues.add(selectedValByString);
                    //
                    mapVal.put(selectedField, selectedValByString);
                    // }
                }
                if(String.valueOf(fielddataType)=='PICKLIST'&&pickListValues!=null&&!pickListValues.isEmpty()&&pickListValues.size()>0){
                    // if(selectedValByPickList!=null&&selectedValByPickList!=''){
                    //selectedPickListValList.add(selectedValByPickList);
                    //selectedValByPickList=selectedValByPickList.remove('[');
                    
                    //  selectedValByPickList=selectedValByPickList.remove(']');
                    
                    // List<String>pickListValList=selectedValByPickList.split(',');
                    System.debug('pickList'+pickListValues);
                    
                    
                    String mainPickListString='';
                    if(pickListValues.size()==1){
                        pickListValues[0].trim();
                        
                        mainPickListString+='\''+pickListValues[0]+'\'';
                    }
                    else{
                        for(Integer i=0;i<pickListValues.size();i++){
                            if(i<pickListValues.size()-1){
                                pickListValues[i].trim();
                                mainPickListString+='\''+pickListValues[i]+'\',';
                            }
                            else{
                                pickListValues[i].trim();
                                
                                mainPickListString+='\''+pickListValues[i]+'\''; 
                            }
                        }
                    }
                    mapVal.put(selectedField, mainPickListString);
                    allSelecttedValues.add(mainPickListString);
                    
                    //}                                         
                }
                if(String.valueOf(fielddataType)=='DATETIME'||String.valueOf(fielddataType)=='DATE'){
                    if(datVal!=null){
                        //selectedDateValList.add(datVal);
                        // mapVal.put(selectedField, datVal);
                        allSelecttedValues.add(datVal);
                        
                        
                    }               
                }
                
                
                
                if(String.valueOf(fielddataType)=='BOOLEAN'){
                    if(boolVal!=null){
                        if(boolVal=='false'){
                            mapVal.put(selectedField, false);
                            allSelecttedValues.add(false);
                        }
                        else{
                            mapVal.put(selectedField, true);
                            allSelecttedValues.add(true);
                        }
                        
                    }
                }
                if(String.valueOf(fielddataType)=='INTEGER'||String.valueOf(fielddataType)=='CURRENCY'){ 
                    if(selectedValByInteger!=null&&selectedValByInteger!=0){
                        // mapVal.put(selectedField, selectedValByInteger);
                        allSelecttedValues.add(selectedValByInteger);
                        
                        
                    }           
                }
                System.debug('Values'+selectedValByDouble);
                if(String.valueOf(fielddataType)=='DOUBLE'){
                    
                    
                    if(selectedValByDouble!=null&&selectedValByDouble!=0){
                        // mapVal.put(selectedField, selectedValByDouble);
                        allSelecttedValues.add(selectedValByDouble);
                        
                        
                    }
                    
                }
                //System.debug('CheckIn the FieldList'+selectedFieldList);
                //System.debug('CheckIn the Operator List'+selectedOperatorList);           
                //System.debug('CheckIn the pickListVal'+selectedPickListValList);
                //System.debug('CheckIn the StringListVal'+selectedStringValList);
                //System.debug('CheckIn the IntegerListVal'+selectedValByInteger);
                System.debug('CheckIn the DoubleListVal'+selectedValByDouble);
                
                
                //Previous Filters Values On VF
                if(fieldlable!=null&&fieldlable!=''){
                    // if(String.valueOf(fielddataType)=='STRING'&&selectedValByString!=''&&selectedValByString!=null||String.valueOf(fielddataType)=='PHONE'&&selectedValByString!=''&&selectedValByString!=null||String.valueOf(fielddataType)=='DOUBLE'&&selectedValByDouble!=null&&selectedValByDouble>=0.0||String.valueOf(fielddataType)=='INTEGER'&&selectedValByInteger!=null&&selectedValByInteger>=0){
                    //mapVal.put(selectedField,selectedValByString);
                    // filtList.add(selectedField);
                    if(String.valueOf(fielddataType)=='STRING'&&selectedValByString!=null&&selectedValByString!=''){
                        if(operatorVal=='LIKE'){
                            filteredList.add(fieldlable+' Contains '+selectedValByString);
                            
                        } else if(operatorVal=='LIKE1'){
                            filteredList.add(fieldlable+' Starts With '+selectedValByString);
                            
                        }else if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+selectedValByString);
                            
                        }else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+selectedValByString);
                            
                        }
                        selectedValByString=null;
                        
                        
                    }
                    
                    if(String.valueOf(fielddataType)=='PICKLIST'&&pickListValues!=null&&!pickListValues.isEmpty()&&pickListValues.size()>0){
                        //mapVal.put(selectedField,selectedValByPickList);
                        // filtList.add(selectedField);
                        if(operatorVal=='LIKE'){
                            filteredList.add(fieldlable+' Contains '+pickListValues);
                            
                        } else if(operatorVal=='LIKE1'){
                            filteredList.add(fieldlable+' Starts With '+pickListValues);
                            
                        }else if(operatorVal=='IN'){
                            filteredList.add(fieldlable+' Equals '+pickListValues);
                            
                        }else if(operatorVal=='Not IN'){
                            filteredList.add(fieldlable+' Not Equals '+pickListValues);
                            
                        }
                        
                        pickListValues.clear();
                        // selectedValByPickList=null;
                        
                    }
                    if((String.valueOf(fielddataType)=='DATETIME'||String.valueOf(fielddataType)=='DATE')&&datVal!=null){
                        // mapVal.put(selectedField,datVal);
                        
                        if(operatorVal=='>'){
                            filteredList.add(fieldlable+' Greater than '+datVal);
                            
                        } else if(operatorVal=='<'){
                            filteredList.add(fieldlable+' Less than '+datVal);
                            
                        }else if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+datVal);
                            
                        }else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+datVal);
                            
                        }
                        else if(operatorVal=='>='){
                            filteredList.add(fieldlable+' Greater or equal '+datVal);
                            
                        }else if(operatorVal=='<='){
                            filteredList.add(fieldlable+' Less or equal '+datVal)  ; 
                        }   
                        datVal=null;
                    }
                    if(String.valueOf(fielddataType)=='DOUBLE'&& selectedValByDouble!=null&&selectedValByDouble!=0){
                        
                        
                        if(operatorVal=='>'){
                            filteredList.add(fieldlable+' Greater than '+selectedValByDouble);
                            
                        } else if(operatorVal=='<'){
                            filteredList.add(fieldlable+' Less than '+selectedValByDouble);
                            
                        }else if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+selectedValByDouble);
                            
                        }else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+selectedValByDouble);
                            
                        }
                        else if(operatorVal=='>='){
                            filteredList.add(fieldlable+' Greater or equal '+selectedValByDouble);
                            
                        }else if(operatorVal=='<='){
                            filteredList.add(fieldlable+' Less or equal '+selectedValByDouble);
                            
                        }
                        // selectedValByDouble=0.0;
                        selectedValByDouble=null;
                        
                        
                    }
                    if(String.valueOf(fielddataType)=='INTEGER'&&selectedValByInteger!=null&&selectedValByInteger!=0){
                        
                        
                        if(operatorVal=='>'){
                            filteredList.add(fieldlable+' Greater than '+selectedValByInteger);
                            
                        } else if(operatorVal=='<'){
                            filteredList.add(fieldlable+' Less than '+selectedValByInteger);
                            
                        }else if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+selectedValByInteger);
                            
                        }else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+selectedValByInteger);
                            
                        }
                        else if(operatorVal=='>='){
                            filteredList.add(fieldlable+' Greater or equal '+selectedValByInteger);
                            
                        }else if(operatorVal=='<='){
                            filteredList.add(fieldlable+' Less or equal '+selectedValByInteger);
                            
                        }   
                        selectedValByInteger=null;
                        
                    }
                    if(String.valueOf(fielddataType)=='CURRENCY'&&selectedValByInteger!=null&&selectedValByInteger!=0){
                        
                        if(operatorVal=='>'){
                            filteredList.add(fieldlable+' Greater than '+selectedValByInteger);
                            
                        } else if(operatorVal=='<'){
                            filteredList.add(fieldlable+' Less than '+selectedValByInteger);
                            
                        }else if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+selectedValByInteger);
                            
                        }else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+selectedValByInteger);
                            
                        }
                        else if(operatorVal=='>='){
                            filteredList.add(fieldlable+' Greater or equal '+selectedValByInteger);
                            
                        }else if(operatorVal=='<='){
                            filteredList.add(fieldlable+' Less or equal '+selectedValByInteger);
                            
                        }   
                        selectedValByInteger=null;
                        
                    }
                    
                    
                    
                    if(String.valueOf(fielddataType)=='BOOLEAN'&&boolVal!=null){
                        //mapVal.put(selectedField,selectedValByPickList);
                        // filtList.add(selectedField);
                        if(operatorVal=='='){
                            filteredList.add(fieldlable+' Equals '+boolVal);
                            
                        } else if(operatorVal=='!='){
                            filteredList.add(fieldlable+' Not Equals '+boolVal);
                            
                        }else if(operatorVal=='IN'){
                            filteredList.add(fieldlable+' Equals '+boolVal);
                            
                        }else if(operatorVal=='Not IN'){
                            filteredList.add(fieldlable+' Not Equals '+boolVal);
                            
                        }
                        boolVal=null;
                        
                    }
                    
                }   
            }
        }
        if(filteredList.size()>0){
            disableDoneButton=false; 
        }
        else{
            disableDoneButton=true; 
            
        }
        if(!selectedField.equals('-None-'))
        {
            tempSelectedfield=selectedField; 
        }               
        selectedField='-None-';
        valHandle=true;
        dateHandle=false;
        pickHandle=false;
        boolHandle=false;
        integerHandle=false;
        doubleHandle=false;
    }
    
    //this method is to remove the filters that are appended by the applied filters  
    public void removeFilter(){
        Schema.DisplayType fielddataType;
        // string fieldlable;
        string fieldlable;
        // String fieldAPIName;
        if(tempSelectedfield!=null&&tempSelectedfield!='-None-'){
            fielddataType = allfield.get(tempSelectedfield).getDescribe().getType();
            fieldlable=allfield.get(tempSelectedfield).getDescribe().getLabel();
            
            
            
            if(operatorValues!=null){
                operatorValues.clear();
            }
            if(relatedObjectFieldsList!=null){
                relatedObjectFieldsList.clear();
            }
            if(pickListValuesList!=null){
                pickListValuesList.clear();
            }
            if(booleanValue!=null){
                booleanValue.clear();
            }
            
            // System.debug('Coming n the rmove'+ApexPages.currentPage().getParameters().get('prmVal'));
            Integer i=Integer.valueOf(ApexPages.currentPage().getParameters().get('prmVal'));
            if(mapVal.containsKey(selectedFieldList.get(i))){
                mapVal.remove(selectedFieldList.get(i));
                
                
            }
            pickHandle=false;
            valHandle=true;
            dateHandle=false;
            boolHandle=false;
            integerHandle=false;
            doubleHandle=false;
            selectedFieldList.remove(i);
            selectedOperatorList.remove(i);
            filteredList.remove(i);
            allSelecttedValues.remove(i);
            //String s =(String)filteredList.get(i);
            
            
            
        }
        if(filteredList.size()==0){
            disableDoneButton=false; 
        }
        
    }
    
    
    //this method is to clear and rediderct to thst page only
    public PageReference redirectUser(){
        PageReference ref = new PageReference('https://ashirwardpipeslighting--partial--c.cs17.visual.force.com/apex/MapAshirvadDemoFinal?core.apexpages.request.devconsole=1');
        return ref;
    }
    
    public void actfunmethod()
    {
        system.debug('lat val---> '+apexpages.currentPage().getparameters().get('latv'));
        latitudeData=apexpages.currentPage().getparameters().get('latv');
        longitudeData=apexpages.currentPage().getparameters().get('longv');
        system.debug('long val---> '+apexpages.currentPage().getparameters().get('longv'));
        //aaccFilter();
    }
    
    
    public void filterAddValMeth(){
        
        
    }
    
    public List<String> getFileId() {
        String[] fileId = new List<String>();
        attachedFiles = new List<Attachment>();
        attachedFiles = [select Id from Attachment where parentId =: recId AND contenttype in ('image/png','image/gif','image/jpg','image/jpeg','image/svg') order By LastModifiedDate DESC limit 3];
        if(attachedFiles != null && attachedFiles.size() > 0 && !attachedFiles.isEmpty()) {
            for (Integer i=0 ; i < attachedFiles.size(); i++) {   
                fileId.add(attachedFiles[i].Id);
            } 
            //fileId = attachedFiles[0].Id;
        }
        //System.debug('fileId ' + fileId + ' recId ' + recId);
        return fileId;
    }
    
    public void testFunction(){
        /*system.debug('Coming inside this function ');
oppList = new List<Opportunity>();
system.debug('Clicked marker id inside testFunction method ' + recId);
oppList = [select Name, CloseDate, StageName from Opportunity where Project_By__c =: recId];
system.debug('opp list value is ' + oppList);*/
        system.debug('Coming inside this function ');
        oppList = new List<Opportunity>();
        orderList = new List<Secondary_Sales_Order__c>();
        promoList = new List<Promotion__c>();
        secondaryData = new List<SecondaryWrapper>();
        system.debug('Clicked marker id inside testFunction method ' + recId);
        oppList = [select Name, CloseDate, StageName from Opportunity where Project_By__c =: recId LIMIT 3];
        //orderList = [select OrderNumber,EffectiveDate,Post_Order_Value__c from Order where AccountId =: recId LIMIT 3];
        orderList = [select Amount__c,Date__c,Account__c from Secondary_Sales_Order__c where Account__c =: recId ORDER BY Date__c Desc LIMIT 10];
        Map<Integer,Double> separatingByMonthMap= new Map<Integer,Double>();
        
        for(Secondary_Sales_Order__c od:orderList){
            if(od.Date__c!=null){
                Date monthValue=od.Date__c;
                if(separatingByMonthMap.containsKey(monthValue.month())){
                    separatingByMonthMap.put(monthValue.month(),separatingByMonthMap.get(monthValue.month())+od.Amount__c);
                }
                else{
                    separatingByMonthMap.put(monthValue.month(),od.Amount__c);
                    
                }   
            }
            
        }
        
        List<Integer> temporaryList= new List<Integer>(separatingByMonthMap.keySet());
        temporaryList.sort();
        for(Integer i:temporaryList){
            if(i==1){
                secondaryData.add(new SecondaryWrapper('Jan',separatingByMonthMap.get(i)));
            }
            else if(i==2){
                secondaryData.add(new SecondaryWrapper('Feb',separatingByMonthMap.get(i)));
                
                
            }else if(i==3){
                secondaryData.add(new SecondaryWrapper('Mar',separatingByMonthMap.get(i)));
                
                
            }
            else if(i==4){
                secondaryData.add(new SecondaryWrapper('Apr',separatingByMonthMap.get(i)));
                
                
                
            }else if(i==5){
                secondaryData.add(new SecondaryWrapper('May',separatingByMonthMap.get(i)));
                
                
            }
            else if(i==6){
                secondaryData.add(new SecondaryWrapper('Jun',separatingByMonthMap.get(i)));
                
                
            }else if(i==7){
                
                secondaryData.add(new SecondaryWrapper('Jul',separatingByMonthMap.get(i)));
                
                
            }
            else if(i==8){
                secondaryData.add(new SecondaryWrapper('Aug',separatingByMonthMap.get(i)));
                
                
            }else if(i==9){
                secondaryData.add(new SecondaryWrapper('Sep',separatingByMonthMap.get(i)));
                
            }
            else if(i==10){
                secondaryData.add(new SecondaryWrapper('Oct',separatingByMonthMap.get(i)));
                
            }else if(i==11){
                secondaryData.add(new SecondaryWrapper('Nov',separatingByMonthMap.get(i)));
                
            }
            else if(i==12){
                secondaryData.add(new SecondaryWrapper('Dec',separatingByMonthMap.get(i)));
                
            }
        }
        System.debug('mapValue'+secondaryData);
        system.debug('opp list value is ' + oppList);
        
        system.debug('order list value is ' + orderList);
        promoList = [select Name,Dealer1__c,Vertical__c,Total_Expenses__c from Promotion__c where Dealer1__c =: recId Order by CreatedDate DESC LIMIT 3];
        system.debug('Promotion list value is ' + promoList);
    } 
    
    public string usrtgtId{get;set;}
    public List<Target__c> getTarget(){
        List<Target__c> tList = new List<Target__c>();
        Integer month=System.today().month();
        tList = [select id, name from Target__c where Approval_Status__c = 'Approved' AND CALENDAR_MONTH(Start_Date__c) =:month AND CALENDAR_MONTH(End_Date__c) =:month AND Target__c.OwnerID =: UserInfo.getUserId() Order By CreatedDate Desc LIMIT 1];
        system.debug('@@@@@@@@@@@@@@LISTLIST@@@@@@@@@@@@@ ' + tlist);
        return tlist; 
    }
    
    
    public List<AP_Site_Visit__c> getVisitData(){
        List<AP_Site_Visit__c> visitData = new List<AP_Site_Visit__c>();
        visitData = [select Party_Name__c,Date__c,Target_Vertical__c,Purpose_of_Visit__c,Order_Value__c,CPVC_Order_Value__c from AP_Site_Visit__c where Party_Name__c =: recId AND Date__c <= TODAY AND Location__c != NULL ORDER BY Date__c DESC LIMIT 3 ];
        system.debug('recId ' + recId);
        system.debug('visitData ' + visitData);
        return visitData;   
    }
    
    public PageReference redirectProject(){
        PageReference pageRef = new PageReference('/apex/AshirvadMapProjectPage');
        return pageRef;  
    }
    public void BeatplanVisitmethod(){
    list<Beat_Plan_Account__c> BeatplanforVisit=[select id,name,Account__c,Beat_Plan__c from Beat_Plan_Account__c where Beat_Plan__r.beat_date__C=TODAY  AND Beat_Plan__r.Beat_Master__r.OwnerID =: UserInfo.getUserId()];
        system.debug('plan from visit'+BeatplanforVisit);
        if(!BeatplanforVisit.isempty()){
        for(Beat_Plan_Account__c BPV:BeatplanforVisit){
        if(BPV.Beat_Plan__c!=null && BPV.Account__c!=null){
        beatplanAccMap.put(BPV.Account__c,BPV.Beat_Plan__c);
        
        }
        }
       }
       system.debug('map values test...'+beatplanAccMap);
    }
    
    public void CheckinData()
    {
    
        checkindatavalue = false;
        list<AP_Site_Visit__c> applsite = new list<AP_Site_Visit__c>();
        currentlat=apexpages.currentPage().getparameters().get('clt');
        currentlng=apexpages.currentPage().getparameters().get('clg');
        CurrentId=apexpages.currentPage().getparameters().get('cid');
        system.debug('CurrentId val-- -> '+apexpages.currentPage().getparameters().get('cid'));
        
        
        Date d= System.today();
        for(AP_Site_Visit__c visitsite :[select name,Beat_Plan_From_MAP__c,party_name__c,Location__c from AP_Site_Visit__c where date__c=:d and Location__c=null And party_name__c=:CurrentId]){
            try{
                if(visitsite.party_name__c==CurrentId){
                    
                    visitsite.Location__c=currentlat+','+currentlng;
                   
                    if(beatplanAccMap.containskey(visitsite.Party_Name__c) &&  (beatplanAccMap.get(visitsite.Party_Name__c)!=null?true:false)){
                    visitsite.Beat_Plan_From_MAP__c=beatplanAccMap.get(visitsite.Party_Name__c);
                    }
                    System.debug('its here now'+currentlng+' '+currentlat);
                    applsite.add(visitsite);
                    update applsite;
                    checkindatavalue = true;
                    system.debug('value'+applsite);
                    System.debug('checkindata val'+checkindatavalue);
                    
                }
                else{
                    checkindatavalue = false;
                    System.debug('checkindatavalue  in esle'+checkindatavalue);
                }
            }catch(Exception e){
                system.debug('ffdf'+e.getMessage());
            }
        }
        
    }
    
    public List<Account> getAccDispFields(){
        List<Account> accDispList = new List<Account>();
        accDispList = [select name,Contact_Number_Mobile__c from Account where id =: recId Limit 100] ;
        return accDispList;
    }
    
    public void getMapReportCustom(){
        mapReportsCustom=MapRepTest__c.getAll();
        System.debug('Acc Custom Setting Value'+mapReportsCustom);
        
        // return null;
    }
    //--------------------NPTB--------------------
    public List<String> getnptbList(){
        Integer monthType =System.today().month();
        List<NPTB__c> nptb = new List<NPTB__c>();
        List<String> nptbData= new List<String>();
        System.debug('recId'+recId);
        nptb = [select Product__c from NPTB__c where Account__c =: recId And Product__c!=null order by CreatedDate desc limit 100];
        System.debug('nptb------>'+nptb);
        if(nptb!=null&&!nptb.isEmpty()){
            for(NPTB__c np:nptb){
                String s=np.Product__c;
                if(s.length()>30){
                    s=s.substring(0,30);
                    nptbData.add(s);
                }
                else{
                    nptbData.add(s);
                }
            }          
        }
        System.debug('nptbData'+nptbData);
        return nptbData;
    }
    //--------------------NPTB--------------------
    
    
    //-----------------------------------------------SAVING THE BEAT-----------------------------------------------
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void OpenPopup() { 
        system.debug('coming inside open popup');       
        displayPopup = true;    
    }
    
    
    
    public PageReference BeatList(){
        renderPlanTable = true;
        String beatAccounts = '%' + searchbeat + '%';
        beatMasterList = new List<Beat_Master__c>();
        beatMasterList = [select Name,NoOfAccounts__c,Checked__c,(select Account__c from Beat_Master_Account__r ) from Beat_Master__c where NoOfAccounts__c!=null AND Name LIKE :beatAccounts AND NoOfAccounts__c>0 ];
        System.debug('beatMasterList after '+beatMasterList);
        return null;
    }
    
    
    public PageReference processSelected() {
        
        List<Beat_Master__c> checkboxList = new List<Beat_Master__c>();
        for(Beat_Master__c wbm: beatMasterList){
            if(wbm.Checked__c == true)
            {
                checkboxList.add(wbm);
            }
        }
        system.debug('checkboxList is ' + checkboxList);
        
        saveBeat = new List<Beat_Plan__c>();
        saveBeatPlanAccount = new List<Beat_Plan_Account__c>();
        
        String ss = beatDate.format();
        system.debug('Beat Date is ' + beatDate);
        system.debug('Beat Date is ' + ss);
        
        checkListSize = checkboxList.size();
        system.debug('check size is ' + checkListSize);
        
        if(checkboxList.size() == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info, 'No Accounts Selected'));
        }
        else{
            for(Beat_Master__c wbm: beatMasterList) {
                if(wbm.Checked__c == true) {
                    Beat_Plan__c bp = new Beat_Plan__c();
                    bp.Beat_Master__c = wbm.Id;
                    bp.Beat_Date__c = Date.parse(ss);                
                    saveBeat.add(bp);
                }
            }
            system.debug('Beat Plan Details ' + saveBeat);
            insert saveBeat;
            
            
            Set<ID> beatPlanId = new Set<ID>();
            Set<ID> beatMasterId = new Set<ID>();
            
            for(Beat_Plan__c bplan : saveBeat){
                beatPlanId.add(bplan.id);
                beatMasterId.add(bplan.Beat_Master__c);
            }
            system.debug('Beat Plan Id Set ' + beatPlanId);
            system.debug('Beat Master Id Set ' + beatMasterId);
            
            Map<ID,List<Beat_Master_Account__c>> beatMap = new Map<ID,List<Beat_Master_Account__c>>();
            
            for(Beat_Master__c wbm: beatMasterList) {
                if(beatMasterId.contains(wbm.Id)){
                    List<Beat_Master_Account__c> beatMasterAccountList = wbm.Beat_Master_Account__r;
                    beatMap.put(wbm.id, wbm.Beat_Master_Account__r);
                }
                
            }
            system.debug('Beatmap Value is ' + beatMap);
            
            List<Beat_Master_Account__c> finalBMAlist = new List<Beat_Master_Account__c>();
            for(Beat_Plan__c bPlanAcc : saveBeat){
                finalBMAlist = beatMap.get(bPlanAcc.Beat_Master__c);
                for(Beat_Master_Account__c each : finalBMAlist){
                    Beat_Plan_Account__c bpAccount = new Beat_Plan_Account__c();
                    bpAccount.Account__c = each.Account__c;
                    bpAccount.Beat_Plan__c = bPlanAcc.id;
                    saveBeatPlanAccount.add(bpAccount);
                }
            }
            
            insert saveBeatPlanAccount;
            //renderPlanTable = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info, 'Beat Planned successfully'));
        }
        /*ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
ApexPages.addMessage(myMsg);*/
        
        return null;
    }
    
    //-----------------------------------------------SAVING THE BEAT----------------------------------------------- 
    //creating beat master record
    
    public void closePopupBeat(){
        displayPopupbeat = false;
        
    }
    public void OpenPopupBeat(){
        displayPopupbeat = true;
    }
    
    public PageReference redirectPopup(){
        displayPopupbeat = false;
        return null;
    }
    
    
    
    public void doUpdate() {
        System.debug('beatplan values'+beatmst);
        Beat_Master__c btm = new Beat_Master__c();
        
        system.debug('beat valus names from vf first---> '+apexpages.currentPage().getparameters().get('BtName'));
        system.debug('BtName---> '+BtName);
        
        
        
        // if(BtName!=null || BtName!='' || !btname.isEmpty()){
        if(BtName!=''){
            btm.Name=beatmst.Name;
            system.debug('beat master values on 1'+btm);
            insert btm;
            beatUpdatemessage = true;
            system.debug('beatUpdatemessage '+beatUpdatemessage);
            system.debug('beat master values on 2 '+btm);
        }else{
            // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Name'));
            beatUpdatemessage = false;
            system.debug('Beat failed'); 
        }
        
        
        
        //list<Integer> lst = new list<Integer>();
        //lst = BtName.split(',');
        List<String> strlist = BtName.split('/');
        System.debug(strlist);
        
        list<Beat_Master_Account__c> beatAccountlist = new list<Beat_Master_Account__c>();
        
        for(String str : strlist){
            
            Beat_Master_Account__c bma = new Beat_Master_Account__c();
            if(str!=''){
                System.debug('str--:'+str);
                bma.Account__c =Id.valueOf(str);
                bma.Beat_Master__c = btm.Id;
                //  bma.Name = 'abc';
                //  bma.Name = String.valueOf(str);
                beatAccountlist.add(bma);
            }
            else{
                System.debug('hre on else section'); 
            }
        }
        if(!beatAccountlist.isEmpty()){
            insert beatAccountlist; 
            System.debug('hre on insert block section'); 
        }
        
        //insert beatAccountlist;
        
        System.debug('beatplan values'+beatmst);
        
    }
    public String getBeatRecords(){ 
        showbeatstr = true;
        System.debug('Ashim test'+mapVal);
        
        List<Object> BPAtotResults = new List<Object>();
        system.debug('coming inside RetrieveBeat on click of Show Beat button');
        retrieveBeat = new List<Beat_Plan_Account__c>();
        retrieveBeat = [Select Account__c from Beat_Plan_Account__c where Beat_Plan__r.Beat_Date__c = TODAY And Beat_Plan__r.Beat_Master__r.OwnerID =: UserInfo.getUserId()];
        system.debug('retrieveBeat List is ' + retrieveBeat);
        
        beatAccountId = new Set<Id>();
        for(Beat_Plan_Account__c bpacc : retrieveBeat){
            beatAccountId.add(bpacc.Account__c);
        }
        
        beatAccounts = new List<Account>();
        beatAccounts = [SELECT Name,Id,Map_Field__c
                        ,Contact_Number_Mobile__c,Total_Order_Values__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Account WHERE ID IN: beatAccountId];
        system.debug('beatAccounts value is ' + beatAccounts);
        
        
        List<Object> totResults = new List<Object>();
        
        List<String> columns = new List<String>();  
        System.debug('fielddataType='+datVal); //coming null in debug
        String orderBy = '';
        String sql = 'SELECT ';
        System.debug('lat long value'+geocode_latitude+' '+geocode_longitude); //coming null in debug
        sql += 'Name,Map_Field__c,Id,Party_Type__c,Contact_Number_Mobile__c,Total_Order_Values__c,PredictedClass__c,Current_NPS__c, Geolocation__Latitude__s, Geolocation__Longitude__s FROM Account WHERE ID IN: beatAccountId AND Geolocation__Latitude__s!=null And Geolocation__Longitude__s!=null And Geolocation__Latitude__s!= 0 And Geolocation__Longitude__s!= 0 And PredictedClass__c!=null'; 
        sql+=' LIMIT 100';

        System.debug('The final sql is ' + sql);
        
        List<Object> results = Database.query(sql);
        system.debug('CONTENTS of RESULTS are ' + results);
        
        
        String resultsSerialized = JSON.serialize(results);
        
        resultsSerialized = resultsSerialized.replace('Geolocation__Latitude__s', 'Latitude');
        resultsSerialized = resultsSerialized.replace('Geolocation__Longitude__s', 'Longitude');
        
        List<Object> meta = (List<Object>) JSON.deserializeUntyped(resultsSerialized);
        
        system.debug('SQL::'+sql);
        system.debug('resultsSerialized:'+meta);
        
        
        
        //system.debug('Contents of results are ' + results);
        totResults.addAll(meta);
        if(JSON.serialize(totResults)==''||JSON.serialize(totResults)==null){
            System.debug('In the Null'+JSON.serialize(totResults));
        }
        
        
        //system.debug('results::'+results);
        system.debug('totResults are ' + JSON.serialize(totResults));
        return JSON.serialize(totResults);
        
    }
    public class SecondaryWrapper{
        public String monthsValue{get;set;}
        public Double orderValue{get;set;}
        public SecondaryWrapper(String monthsValue,Double orderValue){
            this.monthsValue=monthsValue;
            this.orderValue=orderValue;
        }
    }
    
}
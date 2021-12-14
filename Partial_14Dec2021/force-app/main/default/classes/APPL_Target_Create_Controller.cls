/*
Author: Satyanarayana
Description : Target Allocation for the users in different column; Monthly wise by HO.
Last modified by :SudhaMurthy 16/04/2019 ------ code optimisation and roles picklist dynamic
Date : 13/04/2015    */

public  class APPL_Target_Create_Controller {
    
    public Target__c target{get;set;}
    public String SelectedMonth{get;set;}
    // public User user{get;set;}
    public list<SelectOption> Months {get;set;}
    //public list<SelectOption> UserSelection {get;set;}
    public static integer NUMBER_OF_MONTHS = 3; // Target Allocation for Quarterly; Half-yearly=6; Yearly=12. 
    /*public list<user> userlist {get;set;}
// public string SelectedRH{get;set;}
public list<SelectOption> RegionalHead {get;set;}
public list<SelectOption> RSM {get;set;}
public list<SelectOption> ASM {get;set;}
public list<SelectOption> BDM {get;set;}*/
    public string selectedRegionalHead {get;set;}
    public string selectedRSM {get;set;}
    public string selectedASM {get;set;}
    public list<string> promotionTypes {get; set;}
    public map<string, string> promotionTypes_Map {get; set;}
    public list<promotionWrapper> promotionWrapperInstance {get; set;}
    public boolean showTable {get;set;}
    public boolean showOutputPanel {get;set;}
    public boolean showOutputPanel2 {get; set;}
    public boolean showOutputPanel3 {get; set;}
    public integer val_x {get; set;}
    public integer promActivity {get; set;}
    public integer retailing {get; set;}
    public integer marketDevelopment {get; set;}
    public integer primarySales {get; set;}
    public string PromotionType {get; set;}
    public string RetailingType {get; set;}
    public string IndustryType {get; set;}
    public integer industrialVisits {get; set;}
    public string ActivityType {get; set;}
    public string Primarytype {get; set;}
    public string keyPrefix {get; set;}
    list<SelectOption> otherValues = new list<SelectOption>();
    map<String, Integer> monthsMap = new map<String, Integer>{'January'=> 1,'February'=> 2, 'March'=> 3, 'April'=> 4, 'May'=> 5,'June'=> 6, 'July'   => 7, 'August'   => 8,'September'=> 9, 'October'  => 10, 'November' => 11, 'December' => 12};
        
        public APPL_Target_Create_Controller(Apexpages.standardController controller) {
            
            keyPrefix = '';
            target = new Target__c();
            selectedRegionalHead = '';
            selectedRSM  = '';
            selectedASM = '';
            showTable = false;
            showOutputPanel = true;
            showOutputPanel2 = false;
            showOutputPanel3 = false;
            val_x = 0;
            PromotionType = '';
            Primarytype ='';
            RetailingType ='';
            IndustryType ='';
            ActivityType ='';
            Schema.DescribeSObjectResult targetSchema = Target__c.sObjectType.getDescribe();
            system.debug('targetSchema :::'+ targetSchema );
            keyPrefix = targetSchema.getKeyPrefix();
            system.debug('targetSchema.keyPrefix :::'+ keyPrefix );
            populateMonths();    
        }
    
    public List<SelectOption> populateMonths() {
        
        Months = new List<SelectOption>();
        Months.add(new SelectOption('','--None--'));
        otherValues.add(new SelectOption('','--None--'));
        
        for(integer i = 0; i < NUMBER_OF_MONTHS ; i++) {
            
            DateTime hourDateTime          =   DateTime.now().addHours(5);
            DateTime secondDateTime        =   hourDateTime.addMinutes(30);
            DateTime currentDateTime       =   secondDateTime.addMonths(i); //IST Time.
            system.debug(currentDateTime);
            //DateTime ISTTime =
            Months.add(new SelectOption(currentDateTime.format('MMMMM')+' - '+currentDateTime.Year(), currentDateTime.format('MMMMM')+' - '+currentDateTime.Year()));
            otherValues.add(new SelectOption(currentDateTime.format('MMMMM')+' - '+currentDateTime.Year(), currentDateTime.format('MMMMM')+' - '+currentDateTime.Year()));   
        }
        return Months;
    }
    
    
    //Query Regional Head
    /* public void queryRH() {

set<string> RoleSet = new set<String>{'RH', 'Sr-RSM', 'RSM'};
RegionalHead = new list<SelectOption>();
RegionalHead.add(new SelectOption('--None--','--None--'));

for (User userInfo : [select id, Name, Role__c from User where Allocated_State__c Includes(:target.state__c) and Vertical_Type__c =: target.Vertical__c and Role__c IN: RoleSet and IsActive = true]) {

RegionalHead.add(new SelectOption(userInfo.Id, userInfo.Name)); 
}
}

public void queryRSM() {

set<string> RSMSet = new set<String>{'Sr-RSM', 'RSM'};
RSM = new list<SelectOption>();
RSM.add(new SelectOption('--None--','--None--'));

for (User userInfo : [select id, Name, Role__c from User where Allocated_State__c Includes(:target.state__c) and Vertical_Type__c =: target.Vertical__c and Role__c IN: RSMSet and ManagerID =: selectedRegionalHead and IsActive = true]) {

RSM.add(new SelectOption(userInfo.Id, userInfo.Name +' - '+ userInfo.Role__c));
}
}


public void queryASM() {

ASM = new list<SelectOption>();
ASM.add(new SelectOption('--None--','--None--'));
//system.debug([select id, Name, Role__c from User where Allocated_State__c Includes(:target.state__c) and Vertical_Type__c =: target.Vertical__c and Role__c = 'ASM']);
for (User userInfo : [select id, Name, Role__c from User where Allocated_State__c Includes(:target.state__c) and Vertical_Type__c =: target.Vertical__c and Role__c = 'ASM' and IsActive = true]) {
system.debug(userinfo);
ASM.add(new SelectOption(userInfo.Id, userInfo.Name));
}
} */
    
    public PageReference ToContinue() {
        
        if(target.Vertical__c == null) {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,'[ERROR]Please populate Vertical'));
        } else if(SelectedMonth == null) {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,'[ERROR]Please populate Month'));
        } else if(target.State__c == null) {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,'[ERROR]Please populate State'));
        } else {
            
            list<User> AllUserList = new list<User>();
            //set<String> rolesSet = new set<String> {'RH', 'RGM', 'Sr-AGM', 'AGM', 'Sr-TGM', 'TGM', 'TGE'};
            set<String> rolesSet = new set<String>();
            List<SelectOption> options = new List<SelectOption>();
                Schema.DescribeFieldResult roles= Schema.sObjectType.User.fields.Role__c.getSObjectField().getDescribe();
                 options.add(new SelectOption('none','none'));
                for(PicklistEntry ent:roles.getpicklistvalues())
                {
                    
                options .add(new SelectOption(ent.getValue(), ent.getLabel()));
                rolesSet.add(ent.getvalue());
                } 
          
                promActivity = 0;
            retailing  = 0;
            industrialVisits = 0;
            marketDevelopment = 0;
            primarySales  = 0;
            showOutputPanel = false;
            showOutputPanel3 = true;
            
            promotionTypes_Map = new map<String, String>();
            promotionTypes = new list<String>();
            promotionWrapperInstance = new list<promotionWrapper>();   
            
            promotionTypes.add('Select');
            promotionTypes.add('User');
            promotionTypes.add('Role');
            promotionTypes.add('Market-Type');
            showTable = true;
            
            for (promotionWrapper tempObj : promotionWrapperInstance) {
                tempObj.targetCheck = false;
            }
            list<Visit_Promotion_type__c > visitlist= [select Promotion_Type__c, Target_API__c, KRA_Name__c, Retailing_Activities__c, Sort_Order__c, Vertical__c  from Visit_Promotion_type__c where Vertical__c =: target.Vertical__c order by Sort_Order__c];
            for(Visit_Promotion_type__c visitType :visitlist) {
                
                system.debug('visitType :::'+ visitType );
                val_x += 1;
                if(visitType.KRA_Name__c == 'PROMOTIONAL ACTIVITY' || visitType.KRA_Name__c == 'INFLUENCER MANAGEMENT') {
                    
                    promActivity += 1;
                    ActivityType =visitType.KRA_Name__c;
                } else if(visitType.KRA_Name__c == 'RETAILING'||visitType.KRA_Name__c == 'CHANNEL ENGAGEMENT') {
                    
                    retailing += 1;
                    RetailingType =visitType.KRA_Name__c;
                    
                }  else if(visitType.KRA_Name__c == 'INDUSTRIAL VISITS') {
                    
                    industrialVisits += 1;
                    IndustryType =visitType.KRA_Name__c;
                    
                } else if(visitType.KRA_Name__c == 'MARKET DEVELOPMENT' || visitType.KRA_Name__c == 'PROJECT DEVELOPMENT') {
                    
                    marketDevelopment += 1;
                    PromotionType = visitType.KRA_Name__c;
                } else if(visitType.KRA_Name__c == 'PRIMARY SALES : (In Lacs)' ) {
                    
                    primarySales += 1;
                    Primarytype=visitType.KRA_Name__c; 
                }
                
                promotionTypes.add(visitType.Promotion_Type__c);
                promotionTypes_Map.put(visitType.Promotion_Type__c, visitType.Target_API__c);
            }
            
            system.debug('promotionTypes::::'+ promotionTypes);
            
            set<User> RHUserList = new set<User>();
            set<user> RSMUserList = new set<User>();
            set<User> SrASMUserList = new set<user>();
            set<User> ASMUserList = new set<user>();
            set<User> SrBDMUserList = new set<User>();
            set<User> BDMUserList = new set<user>();
            set<User> BDEUserList = new set<user>();
            set<ID> targetAssignedUser = new set<Id>();
            list<Target__c> Targetlist=[select Target_User__c from Target__c where Vertical__c =: target.Vertical__c and State__c =: target.State__c and Month__c =: SelectedMonth];
                
            for(Target__c targetInstance :Targetlist ) {
                targetAssignedUser.add(targetInstance.Target_User__c);
            }
            
            list<User> Userlist=[select id, Name, Role__c,Market_Type__c from User where Allocated_State__c Includes(:target.state__c) and Vertical_Type__c =: target.Vertical__c and Role__c IN: rolesSet and IsActive = true and Id NOT IN : targetAssignedUser];
            for(User UserData : Userlist) {
                
                if(userData.Role__c == 'RH') {
                    RHUserList.add(UserData);
                } else if(userData.Role__c == 'RGM') {
                    RSMUserList.add(UserData);  
                }else if(userData.Role__c == 'Sr-AGM') {
                    SrASMUserList.add(UserData);
                } else if(userData.Role__c == 'AGM') {
                    ASMUserList.add(UserData);
                } else if(userData.Role__c == 'Sr-TGM') {
                    SrBDMUserList.add(UserData);
                } else if(userData.Role__c == 'TGM') {
                    BDMUserList.add(UserData);
                } else if(userData.Role__c == 'TGE') {
                    BDEUserList.add(UserData);
                } 
            }
            
            if(RHUserList.size() > 0) AllUserList.addAll(RHUserList);
            if(RSMUserList.size() > 0) AllUserList.addAll(RSMUserList);
            if(SrASMUserList.size() > 0) AllUserList.addAll(SrASMUserList);
            if(ASMUserList.size() > 0) AllUserList.addAll(ASMUserList);
            if(SrBDMUserList.size() > 0) AllUserList.addAll(SrBDMUserList);
            if(BDMUserList.size() > 0) AllUserList.addAll(BDMUserList);
            if(BDEUserList.size() > 0) AllUserList.addAll(BDEUserList);
            set<id> ownerIdsSet = new set<id>();
            
            integer UsersSize = AllUserList.size();
            
            // Querying the existing Target records for the selected month of selected vertical Users. 
            if(UsersSize > 0) {
                for(Target__c targetInfo : [select id, OwnerId from Target__c where ownerID IN: AllUserList and Month__c =: SelectedMonth]) {
                    ownerIdsSet.add(targetInfo.ownerId);
                }
            }
            
            if(UsersSize > 0) {
                for(User userInfo : AllUserList) {
                    if(!ownerIdsSet.contains(userInfo.id)) { // Hiding the Users for which Target is already allocated for another state.
                        promotionWrapper pmInstance = new promotionWrapper();
                        pmInstance.userDetails.userName = userInfo.Name;
                        pmInstance.userDetails.userId = userInfo.Id;
                        pmInstance.userDetails.Market_Type= userInfo.Market_Type__c;
                        pmInstance.userDetails.userRole = userInfo.Role__c;
                        
                        list<promotionValueWrapper> promotionWrapList = new list<promotionValueWrapper>();
                        
                        for(integer i=4, j=promotionTypes.size(); i<j; i++) {
                            
                            promotionValueWrapper pw = new promotionValueWrapper();
                            pw.promotionName = promotionTypes.get(i);
                            promotionWrapList.add(pw);
                        }
                        pmInstance.promotionValueInstance = promotionWrapList;
                        promotionWrapperInstance.add(pmInstance);
                    }
                }
            }
        }
        system.debug('promotionWrapperInstance:::'+promotionWrapperInstance);
        return null;
    }
    
    
    public class promotionWrapper {
        
        public boolean targetCheck {get; set;}
        public userWrapper userDetails {get; set;}
        //public Map<Id,String> userMap {get;set;}
        public list<promotionValueWrapper> promotionValueInstance {get; set;}
        
        public promotionWrapper() {
            
            targetCheck = true;
            userDetails = new userWrapper();
            //userMap = new Map<Id,String>();
            promotionValueInstance = new list<promotionValueWrapper>();
        }
    }
    
    
    public class userWrapper {
        
        public string userName {get; set;}
        public id userId {get; set;}
        public string userRole {get; set;}
        public string Market_Type{get; set;}
        
        public userWrapper() {
            userName = '';
            userId = null;
            userRole = '';
            Market_Type='';
        }
        
    }
    
    public class promotionValueWrapper {
        
        public string promotionName {get; set;}
        public decimal promotionValue {get; set;}
        
        public promotionValueWrapper() {
            
            promotionName = '';
            //promotionValue = '';
        }
    }
    
    /*******************************
Save to Target Obj

********************************/
    public PageReference toSave() {
        
        list<Target__c> targetListToSave = new list<Target__c>();
        
        RecordType RT_Plumbing;
        RecordType RT_Column;
        RecordType RT_Project;
        RecordType RT_Branding;
        RecordType RT_industrial;
       
        if(target.Vertical__c == 'Plumbing') {
            RT_Plumbing = [select id from RecordType where sobjectType= 'Target__c' and developername ='Plumbing_fornightly'];
        } else if(target.Vertical__c == 'column') {
            RT_Column = [select id from RecordType where sobjectType= 'Target__c' and developername ='column'];
        } else if(target.vertical__c == 'projects') {
            RT_Project = [select id from RecordType where sobjectType= 'Target__c' and developername ='project'];
        }else if(target.vertical__c == 'Branding') {
            RT_Branding = [select id from RecordType where sobjectType= 'Target__c' and developername ='Branding'];
         }else if(target.vertical__c == 'Industrial') {
            RT_industrial = [select id from RecordType where sobjectType= 'Target__c' and developername ='industrial'];
        }
        
        
        for(promotionWrapper pro : promotionWrapperInstance) {
            
            if(pro.targetCheck) {
                
                Target__c targetInstance = new Target__c();
                targetInstance.put('Target_User__c', pro.userDetails.userId);
                targetInstance.put('ownerId', pro.userDetails.userId);
                targetInstance.put('State__c', target.State__c);
                targetInstance.put('Vertical__c', target.Vertical__c);
                RecordType rt;
                
                if(target.Vertical__c == 'Plumbing') {
                    rt = RT_Plumbing;
                } else if(target.Vertical__c == 'column') {
                    rt = RT_Column;
                } else if(target.vertical__c == 'projects') {
                    rt = RT_Project;
                } else if(target.vertical__c == 'Branding') {
                    rt = RT_Branding;
                }  else if(target.vertical__c == 'Industrial') {
                    rt = RT_industrial;
                }
                
                
                targetInstance.put('recordtypeId', rt.id);
                string[] str = SelectedMonth.split(' - ');  //monthsMap
                
                targetInstance.put('Start_Date__c', date.newinstance(integer.valueOf(str[1]),monthsMap.get(str[0]),1));
                integer endDate = Date.daysInMonth(integer.valueOf(str[1]), monthsMap.get(str[0]));
                targetInstance.put('End_Date__c', date.newinstance(integer.valueOf(str[1]),monthsMap.get(str[0]),endDate));
                for(promotionValueWrapper pv : pro.promotionValueInstance) {
                    try {
                        targetInstance.put(promotionTypes_Map.get(pv.promotionName), double.valueOf(pv.promotionValue));
                    } catch(Exception e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
                    }
                }
                targetListToSave.add(targetInstance);          
            }  
        }
        
        if(targetListToSave.size() > 0) {
            try {
                insert targetListToSave;
            } catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
            }
        }
        
        integer x = 0;
        
        for(SelectOption opValue : otherValues) {
            
            if(opValue.getValue() == SelectedMonth) {
                Months.remove(x);
            }
            x++;
        }
        
        showOutputPanel = false;
        showOutputPanel2 = true;
        showOutputPanel3 = false;
        
        return null;
    }  
    
    //Cancel to redirect to Target Tab view.
    public PageReference toCancel() {
        
        pagereference pr = new pagereference('/'+keyprefix+'/o');
        return pr;
    }
    
    public void clonebtn() {
        
        if(SelectedMonth == null) {
            showOutputPanel = false;
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,'[ERROR]Please populate Month'));
        } else {
            
            //Months.remove(new SelectOption(SelectedMonth, SelectedMonth)); new SelectOption(userInfo.Id, userInfo.Name)
            showOutputPanel = false;
            showOutputPanel2 = false;
            showOutputPanel3 = true;
        }
    }   
}
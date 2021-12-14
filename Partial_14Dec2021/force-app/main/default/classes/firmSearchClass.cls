public class firmSearchClass {
public Account accField{get;set;}
public list <AP_Site_Visit__c> accList{get;set;}
public set<AP_Site_Visit__c> firmname{get;set;}
public Boolean displayTable{get;set;}
public string firmclass{get;set;}
public static final string account_RTYPE = Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();

 public firmSearchClass(){
  accField= new Account();
  accList= new list<AP_Site_Visit__c>();
  firmname = new set<AP_Site_Visit__c>();
  displayTable=false;
  
  }
  
  public  pagereference searchFirm(){
  
  if(accField.Firm_Name__c == null || accField.Firm_Name__c =='' ){
   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter a Firm Name ')); 
   displayTable=false;
  accList= new list<AP_Site_Visit__c>();
  
   }
   
  if(accField.Firm_Name__c <> null && accField.Firm_Name__c <>'' ){
   displayTable=true;
   system.debug('firmname :'+accField.Firm_Name__c);
   
   string fname='%'+accField.Firm_Name__c+'%';
   //accList= [select Id,Name from Account where Firm_Name__c=: accField.Firm_Name__c and recordTypeid=:account_RTYPE];
  accList=[select id,Name,Party_Name__r.Id,Party_Name__r.Name,Target_Vertical__c,Party_Type__c,Party_Name__r.Firm_Name__c from AP_Site_Visit__c where Party_Name__r.Firm_Name__c like :fname and Party_Name__r.recordTypeid=:account_RTYPE];
   firmname.addall(accList);
 
   system.debug('accList:'+accList);
  if(accList.isEmpty()){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,'No results found')); 
    displayTable=false;
  }
 }
 
  return null;
}
}
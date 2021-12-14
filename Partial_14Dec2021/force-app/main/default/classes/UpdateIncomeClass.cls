/** Company - Epeople Bespoke Consulting Private Limited.
     Description -For one Tour Program Tour plan Willbe created for 1 week i.e 7 days.For 
     all the 7 Records same page have to be edited.For that we are using this Class and Mass Edit visualforce page and added this vf Page to Tpur Plan button
     Created By  -Prabha.k 11/02/2014
     Modified By  -prabha.k 12/02/2014
**/
public with sharing class UpdateIncomeClass {
public Id opid{get;set;}
public Tour_Program__c tp{get;set;}
public Id aid {get;set;}
  List<Tour_Plan1__c> UpdateList=new List<Tour_Plan1__c>();
public UpdateIncomeClass(ApexPages.StandardController controller) 
    {
        String  opid=ApexPages.CurrentPage().getParameters().get('Id');
        tp=[SELECT Id, Name,From_Date__c,To_Date__c FROM Tour_Program__c WHERE Id = :opid]; 
        plans=[select id,name,Date__c,State__c,Country__c,District__c,Worked_With__c,BD_Tour_Plans_1__c,Tour_Plans_2__c,Tour_Plans_3__c,District_1__c,District_2__c,District_3__c,Location__c,Location_1__c,Location_2__c,Location_3__c,User__c,User_2__c,User_3__c,No_of_Architects__c,No_of_Consultants__c,No_of_Plumbing_Contractor__c,No_of_Dealers__c,No_of_Distributors__c,No_of_Engineers__c,No_of_Builders_Planned__c,Other_Contacts_If_Any__c, Visit_Type__c 
               from Tour_Plan1__c where Tour_Program__c=:tp.id ORDER BY Date__c  ASC] ;  
        
      
    }
Public void Autorun()
    {
       
     
    }
    
private List<Tour_Plan1__c > plans;
private List<Tour_Plan1__c > plans1;
public List<Tour_Plan1__c > getplans() 
  {     
      return plans;
  }
public List<Tour_Plan1__c > getplans1() 
  {          
      return plans1;
  }  
  
public void GetID(){
      
      system.debug('aid'+aid);     
  }
 
public PageReference UpdateRecords()
   {
       update plans;
       PageReference pageRef = new PageReference('/'+ ApexPages.currentPage().getParameters().get('id'));
       return pageRef;    
    
   }
}
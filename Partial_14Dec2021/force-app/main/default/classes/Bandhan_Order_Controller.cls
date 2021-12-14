public class Bandhan_Order_Controller{
public string AccountId;

public ApexPages.StandardController controller;
 Public String callPersonName {get; set;}

 Public Bandhan_Orders__c bandhanOBJ = new Bandhan_Orders__c();
    public Bandhan_Orders__c getbandhanOBJ()
    {
        return bandhanOBJ;
    }
 public Bandhan_Order_Controller(ApexPages.StandardController Controller){ 
         AccountId=ApexPages.currentPage().getParameters().get('pid') ;
         bandhanOBJ = (Bandhan_Orders__c)Controller.getRecord(); 
         this.controller=Controller;  
     }
 //method to save
    public PageReference save() {       
      system.debug(bandhanOBJ);
      bandhanOBJ.Account__c=AccountId;//bandhanId;
      system.debug(bandhanOBJ);
      insert bandhanOBJ; 
      PageReference returnPage=new PageReference('/'+bandhanOBJ.id);
      return returnPage;
    }  
         //method to save & new 
      public PageReference saveAndNew() {
          system.debug(bandhanOBJ);
          bandhanOBJ.Account__c=AccountId;//bandhanId;
          system.debug(bandhanOBJ);
          insert bandhanOBJ; 
          String url = '/apex/Bandhan_Orders?pid='+AccountId;
          PageReference pr= new PageReference(url);
          pr.setRedirect(true);
          system.debug(url+'&&**URL**&&');
          return pr;          
    }  
}
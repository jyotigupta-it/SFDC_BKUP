public class Addrowspecialpricingreq 
{
    public String sid{get;set;}
    public account acc{get;set;}
    public Addrowspecialpricingreq(ApexPages.StandardController controller) {
    orderList = new list<order__c>();
    sid=Apexpages.currentpage().getparameters().get('id');
    }


    public PageReference saveorder() {
     insert orderList;
     pagereference pg = new pagereference('/'+sid);
        return pg;
    }
     public PageReference cancelorder() {
   
     pagereference pf = new pagereference('/'+sid);
        return pf;
    }

    public  List<Order__c> orderList {get;set;}
    public List<Order__c> orderAddList {get;set;}
    public String ordervalue {get;set;}   
    
    public Addrowspecialpricingreq()
    {
       
    }
    public void AddRow()
    {
        orderList .add(new Order__c(projects__C=sid));
    }  
}
public with sharing class promotionclass {

   
public String sid{get;set;}
    public promotionclass() {
 sid=Apexpages.currentpage().getparameters().get('id');
    prm=new Promotion__c(Site_Visit__c=sid);
    }


   
    public Promotion__c prm{get;set;}
    public PageReference Cancel()
    {
    pageReference p1=new PageReference('/home/home.jsp');
    return p1;
    }
     


    public PageReference quicksave() {
        upsert prm;
        
       pageReference p=new pageReference('/apex/PageforPromotion?id='+sid);
       p.setRedirect(true);
        return p;
    }


    public PageReference save() {
       
       
       insert prm;
   PageReference pr= new PageReference('/'+prm.id);
      pr.setRedirect(true);
       return pr;
       
    }

   

}
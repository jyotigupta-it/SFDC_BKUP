public class addrowCon
{ 
   Integer count = 0; 
  public integer num { get; set; }
  public List<Site_Visit__c> accts {get; set;} 
  public Site_Visit__c vis{get;set;}
  public Integer rowNum{get;set;}
  public Tour_Plan1__c  TourPlan{get;set;}
  public Account acce1{get;set;}
  public String ShowAccountID{get;set;}
  public Boolean ShowReason{get;set;}
   public Promotion__c prm{get;set;}
    public Tour_Plan1__c emtourplan{get;set;}
   public Map<Id,String> AccountStates {get;set;}
  
    
  public addrowCon()
  {
     vis=new Site_Visit__c();
     accts = new List<Site_Visit__c>(); 
     //accts.add(new Site_Visit__c());    
  }
   public void add_rows() {
   try
   {
    // accts = new List<Site_Visit__c>(); 
    for(integer i=0;i<num ;i++)
        {
            string reason ='';
            System.debug('vis.Tour_Plan1__r.State__c ********* '+vis.Tour_Plan1__r.State__c);
           accts.add(new Site_Visit__c(Date__c=vis.Date__c,Tour_Plan1__c=vis.Tour_Plan1__c,Type__c=vis.Type__c,Reason_for_change_in_the_Tour_Plan__c=reason,User__c=vis.User__c,TL__c=vis.TL__c ));  
          //Date__c=vis.Date__c,Tour_Plan1__c=vis.Tour_Plan1__c,Type__c=vis.Type__c    
        }
        this.emtourplan = [Select Id, Name, State__c from Tour_Plan1__c Where Id = :vis.Tour_Plan1__c];
     }   
     Catch(Exception e)
     {
         System.Debug(e);
     }   
     }
     public void nameChanged(){
        this.emtourplan = [Select Id, Name, State__c from Tour_Plan1__c Where Id = :vis.Tour_Plan1__c];

    }
    public void donothing(){
    }
     public void findstate(){
        set<Id> ids = new set<Id>();
        System.debug('inside Findstate ############');
        AccountStates = new Map<Id,String>();
           for(Site_Visit__c each : accts){
               if(each.Party_Name__c!=null){
                System.debug('inside party*******');
                ids.add(each.Party_Name__c);
            }
            if(each.Distributor_Dealer__c!=null){
                ids.add(each.Distributor_Dealer__c);
                System.debug('inside dealer **********');
            }
           }
           for(Account eacAct: [select id, State__c from Account where id in :ids]){
            AccountStates.put(eacAct.id,eacAct.State__c);
           }
           for(Distributor_Dealer__c eacAct: [select id, State__c from Distributor_Dealer__c where id in :ids]){
            AccountStates.put(eacAct.id,eacAct.State__c);
           }
        

    }


     public void delRow()
    {
        try
        {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
        accts.remove(rowNum);   
        }
        catch(exception e)
        {}
    }    
  public PageReference save_close(){ 
  List<Site_Visit__c> sllist=new List<Site_Visit__c >();
   //insert vis;
   System.debug('Inside Save Close *************');
   for(Site_Visit__c each : accts){
       System.debug('Name ***** = '+each.name);
       System.debug('Party_Name__c ***** = '+each.Party_Name__c);
       
       if(each.Party_Type__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Party Type !!'));
        return null;
        } 
        else if(each.Party_Name__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Party Name !!'));
        return null;
        } 
        
        else if(each.Purpose_of_Visit__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Purpose of Visit !!'));
        return null;
        } 
        else if(each.Products__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Products!!'));
        return null;
        } 
        else if(each.Purpose_of_Visit__c=='New Order Booking' && each.Order_Value__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please  Enter Order Value!!'));
        return null;
        } 
       else if(each.Party_Type__c!=Null && (each.Party_Name__c!=Null || each.Distributor_Dealer__c!=Null || each.Contacts__c!=Null||each.Projects__c!=Null) && each.Purpose_of_Visit__c!=Null)
       {
           sllist.add(each);
       }
   }
    insert sllist;
    Schema.DescribeSObjectResult result = Site_visit__c.SObjectType.getDescribe();
    PageReference pageRef = new PageReference('/' + vis.Tour_Plan1__c);
    pageRef.setRedirect(true);
    return pageRef;
   
  }
  public PageReference save_closeadd(){ 
  List<Site_Visit__c> sllist=new List<Site_Visit__c >();
   for(Site_Visit__c each : accts){
       System.debug('Name ***** = '+each.name);
       System.debug('Party_Name__c ***** = '+each.Party_Name__c);
       
           sllist.add(each);
      
   }
   if(vis.Tour_Plan1__c!=null && vis.user__c!=null && sllist.size()>0)
   {
   
    insert sllist;
   }
  else if(vis.Tour_Plan1__c!=null && vis.user__c!=null)
  {
  insert vis;
  }
  else if(vis.Tour_Plan1__c!=null && sllist.size()>0)
   {
   
    insert sllist;
   }
    Schema.DescribeSObjectResult result = Site_visit__c.SObjectType.getDescribe();
    PageReference pageRef = new PageReference('/' + vis.Tour_Plan1__c);
    pageRef.setRedirect(true);
    return pageRef;
   
  }
   public PageReference save_close1(){       
    insert vis;
      PageReference pr= new PageReference('/'+vis.Tour_Plan1__c);
      pr.setRedirect(true);
       return pr;
       }
  public PageReference createVisitEntry1(){       
    insert vis;
      PageReference pageRef = Page.VisitNewPage;
    pageRef.setRedirect(true);
    return pageRef;
  }
 
  public PageReference createVisitEntry3(){       
    insert vis;
      PageReference pageRef = Page.TLVisitEntry;
    pageRef.setRedirect(true);
    return pageRef;
  }
  public PageReference createVisitEntry2(){       
   List<Site_Visit__c> sllist=new List<Site_Visit__c >();
   for(Site_Visit__c each : accts){
       System.debug('Name ***** = '+each.name);
       System.debug('Party_Name__c ***** = '+each.Party_Name__c);
       
           sllist.add(each);
      
   }
   if(vis.Tour_Plan1__c!=null && vis.user__c!=null && sllist.size()>0)
   {
   
    insert sllist;
   }
  else if(vis.Tour_Plan1__c!=null && vis.user__c!=null)
  {
  insert vis;
  }
  else if(vis.Tour_Plan1__c!=null && sllist.size()>0)
   {
   
    insert sllist;
   }
    Schema.DescribeSObjectResult result = Site_visit__c.SObjectType.getDescribe();
    PageReference pageRef = Page.TLVisitEntry;
    pageRef.setRedirect(true);
    return pageRef;
     
  }
  public PageReference incrementCounter() {
            count++;
            return null;
    }
                        
    public Integer getCount() {
        return count;
    }
    public PageReference createVisitEntry()
    {
    
   List<Site_Visit__c> sllist=new List<Site_Visit__c >();
   //insert vis;
   System.debug('Inside Save Close *************');
   for(Site_Visit__c each : accts){
       System.debug('Name ***** = '+each.name);
       System.debug('Party_Name__c ***** = '+each.Party_Name__c);
      if(each.Party_Type__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Party Type !!'));
        return null;
        } 
        else if(each.Party_Name__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Party Name !!'));
        return null;
        } 
        
        else if(each.Purpose_of_Visit__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Purpose of Visit !!'));
        return null;
        } 
        else if(each.Products__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Choose Products!!'));
        return null;
        } 
        else if(each.Purpose_of_Visit__c=='New Order Booking' && each.Order_Value__c==null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please  Enter Order Value!!'));
        return null;
        } 
       else  if(each.Party_Type__c!=Null && (each.Party_Name__c!=Null || each.Distributor_Dealer__c!=Null || each.Contacts__c!=Null||each.Projects__c!=Null) && each.Purpose_of_Visit__c!=Null)           
       {
           sllist.add(each);
       }
  
  
  
    }
    if(sllist.Size()>0)
    {
    insert sllist;
    }
    Schema.DescribeSObjectResult result = Site_visit__c.SObjectType.getDescribe();
    PageReference pageRef = Page.VisitNewPage;
    pageRef.setRedirect(true);
    return pageRef;
   
    }
   public PageReference createPromotion()
    {
     insert vis;
   
    return new PageReference('/apex/PageforPromotion?id='+vis.id); 
    
    }
  
  /*public void ShowAddress(){
  
      system.debug('LLLLLLLLLLLLLLLLl  '+vis.Tour_Plan1__c);
     TourPlan = new Tour_Plan1__c (); 
     TourPlan = [select id,State__c from Tour_Plan1__c where 
                Id=:vis.Tour_Plan1__c];
     
  }
  
  public void ShowAccAddress(){
  
      String Acc;
      acce1=new Account();
      ShowAddress();
      system.debug('HHHHHHHHH'+ApexPages.CurrentPage().getParameters().get('rrrr')+'hfffffffff'+accts+'TourPlan.State__c'+TourPlan.State__c);
       try{
      acce1=[select State__c from Account where id=:accts[0].Party_Name__c];
      
      if(TourPlan.State__c != acce1.State__c){
          ShowReason = TRUE;
      }else{
          ShowReason = False;
      }
     }
     catch(exception e){}
      
  }
  */
  
}
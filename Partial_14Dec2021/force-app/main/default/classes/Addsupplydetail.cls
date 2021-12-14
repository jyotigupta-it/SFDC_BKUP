public class Addsupplydetail
{
    public boolean message{get;set;}
    public string pageid{get;set;}
    public account acc{get;set;}
    public Supply_Detail__c supplyid{get;set;}
    public Addsupplydetail(ApexPages.StandardController controller) {
    try{
        pageid= apexpages.currentpage().getparameters().get('id');
        acc= [select id,name,Total_Order_Quantity__c,Total_Supply_Value__c,(select id,Projects__c from Supply_Details1__r order by name asc Limit 1 ) from account where id=:pageid];
        supplyList = new list<Supply_Detail__c>();
        supplyid = acc.Supply_Details1__r[0];
        message=false;
        }
        catch(exception e)
        {
        }
    }
    
    
    public PageReference savesupplydetail() {
        list<Supply_Detail__c > slist = new   list<Supply_Detail__c >();
        Double supplyqty=0;
        try
        {
            for(Supply_Detail__c s:supplyList)
            {
                supplyqty+=s.Supply_Quantity__c;  
                slist.add(s);    
            }
            if( supplyqty > acc.Total_Order_Quantity__c-acc.Total_Supply_Value__c)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Supply Quantity should not be greater than order quantity'));
                return null;
            }
            else if(supplyqty < acc.Total_Order_Quantity__c-acc.Total_Supply_Value__c || supplyqty == acc.Total_Order_Quantity__c-acc.Total_Supply_Value__c)
            {
                insert slist;
                pagereference pg = new pagereference('/'+pageid);
                return pg;
            }
            
            pagereference pg = new pagereference('/'+pageid);
            return pg;
        }
        
        Catch(Exception e)
        {
            return null;
        } 
    } 
    public PageReference cancelsupplydetail() {
        
        pagereference pf = new pagereference('/'+pageid);
        return pf;
    }
    
    public  List<Supply_Detail__c> supplyList {get;set;}
    public List<Supply_Detail__c> supplyAddList {get;set;}
    //public String ordervalue {get;set;}   
    
    public Addsupplydetail()
    {
        
        
    }
    public void AddRow()
    {
        try
        {
            supplyList.add(new Supply_Detail__c(projects__C=pageid));
        }
        Catch(Exception e)
        {
            System.Debug(e);
        }   
    }  
}
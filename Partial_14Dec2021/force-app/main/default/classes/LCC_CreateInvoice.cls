public without sharing class LCC_CreateInvoice {
    public class ServiceChargeWrapper{
        @AuraEnabled
        public Service_Charge__c sc;
        @AuraEnabled
        public Boolean check;
    }
    public class Datawarp{
        @auraEnabled
        public List<Service_Charge__c> sclist;
        @auraEnabled
        public String total;
        @auraEnabled
        public String totalserviceCharges;
         @auraEnabled
        public String FixedCharges;
        @auraEnabled
        public id accountid;
    }
    @auraEnabled
    public static Datawarp getsreciveCharges(string scids){
        System.debug('Id is'+scids);
        Type idArrType = Type.forName('List<string>');
    	List<string> wrapperList = (List<string>) JSON.deserialize(scids, idArrType);
        //List<id> listids=new List<id>();
        Datawarp da=new Datawarp();
        Map<id,user> usermap=new Map<id,user>();
        //listids=scids.split(',');
        //Set<id> idset=new Set<id>();
        //idset.addAll(listids);
        List<Service_Charge__c> shlist=new List<Service_Charge__c>();
        shlist=[Select id,Name,Status__c,Service_Charge_Amount__c,work_order__r.ownerid from Service_Charge__c where id=:wrapperList  ];
        if(!shlist.isEmpty()){     
           usermap=new Map<id,user>([Select id,contactid,contact.accountId,contact.account.Service_Fixed_Payment__c from user where id =:shlist[0].work_order__r.ownerid]);
        }
        System.debug('usermap is'+usermap);
        Decimal total=0;
        if(!shlist.isEmpty()){
            for(Service_Charge__c sc:shlist){
                total +=sc.Service_Charge_Amount__c; 
            }
        }
        da.totalserviceCharges=String.valueOf(total);
        if(!usermap.isEmpty()){
            if( usermap.values()[0].contact.account.Service_Fixed_Payment__c!=null)
            total =total + usermap.values()[0].contact.account.Service_Fixed_Payment__c;
            da.FixedCharges=String.valueOf(usermap.values()[0].contact.account.Service_Fixed_Payment__c);
            da.accountid=usermap.values()[0].contact.accountId;
        }
        
         
        da.total=String.valueOf(total);
        da.sclist=shlist;
        System.debug('shlist*******'+shlist);
        return da;
    }
     @auraEnabled
    public static String updatesreciveCharges(string invid,List<Service_Charge__c> sclist){
          if(!sclist.isEmpty()){
            for(Service_Charge__c sc:sclist){
                sc.put('Invoice__c',invid); 
                sc.put('status__c','Raised');
            }
            update sclist;
        }
        System.debug('invalid is'+invid);
        return invid;
    }
    
    @AuraEnabled
    public static List<ServiceChargeWrapper> getServiceCharges(){
        List<ServiceChargeWrapper> scwlist = new List<ServiceChargeWrapper>();
        Id currentUserId = UserInfo.getUserId();
        //added by Haritha
        
          Integer month = Date.Today().Month();
          Integer year = Date.Today().Year();
          system.debug('****month-->'+month);
          system.debug('****year-->'+year);
          Datetime currentMonthDate = Datetime.newInstanceGmt(year, month, 7);
          system.debug('****currentMonthDate-->'+currentMonthDate);
          if(month == 1){
             month = 12;
             year -= 1;
            }
       else{
           month -= 1;
            }
         
        Datetime PreviousMonthDate = Datetime.newInstanceGmt(year, month , 8);
        
        system.debug('****nextMonthDate-->'+PreviousMonthDate);       
        
        //Code end
        for(Service_Charge__c src : [Select Id,Name, Customer_Name__c ,Location_Name__c, Plumber__c , Service_Charge_Amount__c  from Service_Charge__c where Invoice__c = null and OwnerId =: currentUserId ]){
            ServiceChargeWrapper scw = new ServiceChargeWrapper();
            scw.check = false;
            scw.sc = src;
            scwlist.add(scw);
        }
        return scwlist;
    }
}
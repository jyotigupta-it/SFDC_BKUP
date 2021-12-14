@RestResource(urlMapping='/BrandingPortal/*')
global with sharing class BrandingPortalIntegration {
    @HttpGet
    global static void fetchBrandingRecords(){
        RestRequest req = RestContext.request;
        String fromAndToDate = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('fromAndToDate'+fromAndToDate);
        List<String> brandingDate = fromAndToDate.split('TO');
        system.debug('brandingDate==>'+brandingDate);
        String fromDate= brandingDate[0];//2020-12-23
        List<String> fromDateString = (fromDate).split('-');
        system.debug('fromDateString==>'+fromDateString);
        String formatedFromDt = String.valueOf(Date.newInstance(Integer.valueOf(fromDateString[0]),Integer.valueOf(fromDateString[1]),Integer.valueOf(fromDateString[2])));//.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'');
        String toDate= brandingDate[1];
        List<String> toDateString = toDate.split('-');
        String formatedToDt = String.valueOf(Date.newInstance(Integer.valueOf(toDateString[0]),Integer.valueOf(toDateString[1]),Integer.valueOf(toDateString[2])));//.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'');
        system.debug('fromAndToDate after split string: from date--> '+fromDate+' to date-->:'+toDate);
        //system.debug('After Coversion: from date--> '+fromDateD+' to date-->:'+toDateD);
        RestResponse res = Restcontext.response;        
        Map<String,Object> responseMap = new Map<String,Object>();  
        List<Branding_Request__c> accountList= new List<Branding_Request__c>();
        List<Wrapper> wrapData = new List<Wrapper>();
        Wrapper wrp;
        try{
            //String formatedToDt = toDateD.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'');
            //String formatedFromDt = toDateD.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'');
            List<String> dateString = (system.label.BrandingCreatedDate).split('/');
            DateTime brdDate = DateTime.newInstance(Integer.valueOf(dateString[2]),Integer.valueOf(dateString[1]),Integer.valueOf(dateString[0]));
            system.debug('BRDDate:'+brdDate);
            system.debug(formatedToDt);
            system.debug(''+formatedToDt);
            system.debug(''+formatedFromDt);
            String queryString = 'SELECT Id,Vendor_Account__r.Name,RBM_Approval_Date__c,Name,Shop_Name__r.Name,Address__c,Vertical_type__c,Shop_Name__r.Dealer_Number__c,Shop_Name__r.Id,Shop_Name__r.State__c,Shop_Name__r.City__c,Shop_Name__r.Cluster_of_Taluka__c,Type__c,Branding_Type__c, Shop_Name__r.VAT_CST_Number__c,Shop_Name__r.Contact_Number_Mobile__c,createdBy.name, createddate,createdBy.EmployeeNumber,createdBy.MobilePhone,'+
                'createdBy.Email,RBM_Name__c,Request_completed_date__c,createdBy.Branding_Team_Member__r.EmployeeNumber,createdBy.Id,createdBy.Branding_Team_Member__r.Id,User1__r.id,createdBy.Branding_Team_Member__r.Email,createdBy.Branding_Team_Member__r.MobilePhone,Vendor_Code__c,User1__r.Name,User1__r.Vendor_Code__c from Branding_Request__c where Vendor_Code__c!=Null AND Branding_Approved_Rejected__c =\'Vendor Assigned\' AND RBM_Approval_Date__c>='+formatedFromDt+' and  RBM_Approval_Date__c<='+formatedToDt;
            system.debug(queryString);   
            system.debug(database.query(queryString));
            //fetch branding accounts
            for(Branding_Request__c acc : Database.query(queryString)){
                wrp = new Wrapper();
                wrp.Unique_Branding_ID=acc.Name;
                wrp.Branding_ID=acc.Id;
                wrp.Createddate=acc.Createddate;
                wrp.Shop_Name=acc.Shop_Name__r.Name;
                wrp.Shop_Address=acc.Address__c;
                wrp.BusinessVertical_Type=acc.Vertical_type__c;
                wrp.Shop_City=acc.Shop_Name__r.City__c;
                wrp.Shop_State=acc.Shop_Name__r.State__c;
                wrp.Shop_Taluk=acc.Shop_Name__r.Cluster_of_Taluka__c;
                wrp.BrandingType=acc.Branding_Type__c;
                wrp.DealerCategory=acc.Type__c;
                wrp.Shop_GST_Number=acc.Shop_Name__r.VAT_CST_Number__c;
                wrp.Shop_MobileNumber=acc.Shop_Name__r.Contact_Number_Mobile__c;
                wrp.Salesperson_Name=acc.createdBy.name;
                wrp.Branding_RequestedDate=acc.createddate;
                wrp.Salesperson_EmpNumber=acc.createdBy.EmployeeNumber;
                wrp.Salesperson_MobileNumber=acc.createdBy.MobilePhone;
                wrp.Salesperson_EmailID=acc.createdBy.Email;
                wrp.RBM_Name=acc.RBM_Name__c;
                wrp.RBM_EmpNumber=acc.createdBy.Branding_Team_Member__r.EmployeeNumber;
                wrp.RBM_EmailID=acc.createdBy.Branding_Team_Member__r.Email;
                wrp.RBM_MobileNumber=acc.createdBy.Branding_Team_Member__r.MobilePhone;
                wrp.VendorCode=acc.Vendor_Code__c;
                if(acc.Vendor_Account__r.Name!=null){
                    wrp.VendorCodeName=acc.Vendor_Account__r.Name;}
                if(acc.User1__r.Name!=null){
                    wrp.VendorCodeName=acc.User1__r.Name;}
                
               // wrp.VendorUserCodeName=acc.User1__r.Name;
                wrp.DealerCode=acc.Shop_Name__r.Dealer_Number__c;
                wrp.Unique_ShopID=acc.Shop_Name__r.Id;
                wrp.Unique_SalesPersonID=acc.createdBy.Id;
                wrp.Unique_RBMPersonID=acc.createdBy.Branding_Team_Member__r.Id;
                wrp.Unique_VendorPersonID=acc.User1__r.id;
                wrp.RBM_ApprovedDate=acc.RBM_Approval_Date__c;                                     
                wrapData.add(wrp);
            }
            
            //add into response
            responseMap.put('statusCode','200');
            responseMap.put('statusMessage','Success');
            responseMap.put('response',wrapData);
            
            if(test.isRunningTest()){
                //Integer i=1/0;
            }
            
        }
        catch(Exception e){
            
            //  HandleException.captureError('', '500', e.getMessage(), 'FetchWorkShop', 'fetchWorkShopAccounts', e); //handle exception class
            responseMap.put('statusCode','500');
            responseMap.put('statusMessage','Failed');
            responseMap.put('response',e.getMessage());
            
        }
        if(!responseMap.isEmpty()){
            
            res.responseBody = Blob.valueOf(JSON.serialize(responseMap));  
            
        }
    }
    public class Wrapper{
        String Unique_Branding_ID;
        Id Branding_ID;
        String Shop_Name;
        String Shop_Address;
        String BusinessVertical_Type;
        String Shop_City;
        String Shop_State;
        String Shop_Taluk;
        String BrandingType;
        String DealerCategory;
        String Shop_GST_Number;
        String Shop_MobileNumber;
        String Salesperson_Name;
        DateTime Branding_RequestedDate;
        String Salesperson_EmpNumber;
        String Salesperson_MobileNumber;
        String Salesperson_EmailID;
        String RBM_Name;
        String RBM_EmpNumber;
        String RBM_EmailID;
        String RBM_MobileNumber;
        String VendorCode;
        String VendorCodeName;
       // String VendorUserCodeName;
        String DealerCode;
        String Unique_ShopID;
        String Unique_SalesPersonID;
        String Unique_RBMPersonID;
        String Unique_VendorPersonID;
        Date RBM_ApprovedDate;
        DateTime Createddate;
        
    }
    
    
}
public class BrandingRequestController {
public List<String> cluster{get;set;}
public Account acc{get;set;}
public boolean rec{get;set;}
public String idCluster{get;set;}
public String idAccount{get;set;}
public String idOwner{get;set;}
public String nameAccount{get;set;}
public static Integer count{get;set;}
public String profileName{get;set;}
public String pinCode{get;set;}
public String state{get;set;}
public String district{get;set;}
public String city{get;set;}
public String streetAddress{get;set;}
public String contactNumber{get;set;}
public Date StartDate{get;set;}
public Date EndDate{get;set;}

public static Final String BrandingRequest='01230000001DRzUAAW';

    public BrandingRequestController(){
        try{
            profileName=[select Name from Profile where id=:userinfo.getProfileId()].name;
            rec=false;
            String ids=ApexPages.currentPage().getParameters().get('id');
            System.debug(ids);
            if(ids.length()!=0){
                rec=true;
                acc=[select id,OwnerId,name,APPL_Taluk__r.Cluster__C,APPL_Taluk__r.Name,APPL_Taluk__c,PIN_Code__c,State__c,District__c,City__c,Street_Address__c,Contact_Number_Mobile__c from Account where id=:ids limit 1];
                idCluster=acc.APPL_Taluk__r.Cluster__C;
                nameAccount=acc.name;
                idAccount=acc.id;
                idOwner=acc.OwnerId;
                pinCode=acc.PIN_Code__c;
                state=acc.State__c;
                district=acc.District__c;
                city=acc.City__c;
                streetAddress=acc.Street_Address__c;
                contactNumber=acc.Contact_Number_Mobile__c;
            }
        }catch(Exception ex){
            System.debug(ex);
        }
    }
    
    @RemoteAction
    public static List<String> collectLanguage(){
        List<String> lang=new List<String>();
        lang.add('None');
        try{
            List<Schema.PicklistEntry> picklist=Branding_Request__c.Language__c.getDescribe().getPicklistValues();
            for(Schema.PicklistEntry temp:picklist){
                lang.add(temp.getValue());
            }
            return lang;
        }catch(Exception ex){
            System.debug(ex);
            return lang;
        }
    }

    @RemoteAction
    public static List<Account> collectVendors(List<String> cluster){
        return([select id,Name,Vendor_Cluster__c,isActive__c from Account where Vendor_Cluster__c in:cluster and isActive__c=true and vendor_cluster_active__c=true]);
    }

    @RemoteAction
    public static  WrapBrand getDetails(){
        System.debug('PEEE  '+userInfo.getUserId());
        WrapBrand brandList=new WrapBrand();
        DateTime d2=System.Today()-180;
        List<String> profName=new List<String>();
        profName.add('Regional Branding Manager');
        profName.add('Head Branding');
        profName.add('System Administrator');
        String usrProfileId=userInfo.getProfileId();
        String prof='';
        String sys='';
        List<Branding_Request__c> brdList=new List<Branding_Request__c>();
        List<Profile> proflist=[select id,name from profile where name in:profName];
       System.debug(prof);
        for(Profile pf:proflist){
            if(pf.id==usrProfileId){
                prof=pf.Name;
                break;
            }
        }

        System.debug(prof);
        set<Id> accId=new set<Id>();
        set<Id> bndId=new set<Id>();
        set<String> clist=new set<String>();
        System.debug(brandList.newRequest);
		Set<Id> vendorAccAccessIds = new Set<Id>();
        for(AccountShare accShare : [SELECT Id, AccountId FROM AccountShare where UserOrGroupId =: userInfo.getUserId()]){
            vendorAccAccessIds.add(accShare.AccountId);
        }
        if(prof=='Regional Branding Manager' || prof=='System Administrator'){
            brdList.addall([select id,User1__r.Name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__c, Cluster__c,User1__c,Branding_type__c,Vertical_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,shop_Name__r.APPL_Taluk__r.Cluster__c,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c, Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name,Submitted_By__c,Submitted_By__r.Name from Branding_Request__c where RBM__c=:userInfo.getUserId() AND Branding_Approved_Rejected__c='Submitted To RBM'  order By Shop_Name__r.Name ASC]);          
            BrandingRequestController.count=brdList.size();
            brandList.newRequest.addAll(brdList);
            for(Branding_Request__c t:brdList){
                accId.add(t.Shop_Name__c);
                bndId.add(t.id);
                
                clist.add(t.shop_Name__r.APPL_Taluk__r.Cluster__c);
            }
            brdList.clear();
        }
        System.debug(brandList.newRequest);
        if(prof=='Head Branding' ){
            brdList.addall([select id,User1__r.name,Shop_Name__c,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c, Cluster__c,User1__c, Branding_type__c,Vertical_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,shop_Name__r.APPL_Taluk__r.Cluster__c,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c, Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name,Submitted_By__c,Submitted_By__r.Name from Branding_Request__c where  ( Branding_Approved_Rejected__c='Vendor Assigned' OR  Escalated_To_Branding_Head__c=true )  AND Branding_Head__c=:userInfo.getUserId() order By Shop_Name__r.Name ASC]);           
            BrandingRequestController.count=brdList.size();
            brandList.newRequest.addAll(brdList);
            for(Branding_Request__c t:brdList){
                accId.add(t.Shop_Name__c);
                bndId.add(t.id);
                clist.add(t.shop_Name__r.APPL_Taluk__r.Cluster__c);
            }
            brdList.clear();
       }
       brandList.oldRequest.addAll([select id,Shop_Name__c,Type__c,Media_Type__c,Branding_type__c,Vendor_Account__c,Vendor_account__r.Name from Branding_Request__c where createdDate>=:d2 and Shop_Name__c in:accId and id not in:bndId ]);
       brandList.approval.addAll([SELECT TargetObjectId,LastActor.Name, SubmittedById, CompletedDate, Status, Id,(SELECT Id, StepStatus, Comments FROM StepsAndWorkitems where (StepStatus='Approved' OR StepStatus='Rejected' )) FROM ProcessInstance where TargetObjectId in:bndId and (status='Approved' OR Status='Rejected' )]);
       brandList.vendor.addAll([select id,Name,Vendor_Cluster__c,isActive__c,RBM__c from Account where RecordType.Name = 'Branding Vendor' and /*Vendor_Cluster__c in:clist and*/ isActive__c=true and vendor_cluster_active__c=true and Id In: vendorAccAccessIds]);
       System.debug(brandList.newRequest);
        System.debug(BrandingRequestController.count);
            return brandList;
    }

    @RemoteAction
    public static string collectVertical(){
        User usr=new User();
        usr=[Select id,vertical_type__c from user where id=:userinfo.getuserid() limit 1];
        return usr.vertical_type__c ;
    }

    @RemoteAction
    public static string collectProfile(){
        Profile pf=[select Id,Name from Profile where id =:userInfo.getProfileId()];
        return(pf.Name);
    }

    @RemoteAction
    public static set<string> collectCluster(){
        set<string> temp = new set<string>();        
        set<id> clusterSet=new set<id>();
        List<User_Taluk_Master_Junction__c> clus=new List<User_Taluk_Master_Junction__c>();
        clus.addAll([select Id,Name,User__c,Cluster__c,Record_Vertical__c from User_Taluk_Master_Junction__c where user__c=:userInfo.getUserId()]);
        for (User_Taluk_Master_Junction__c tempU: clus){
            temp.add(tempU.Cluster__c);
        }
        return temp;
    }

    @RemoteAction
    public static  List<Account> collectAccount(String accName,string clusterID){
        List<String> cluslst=clusterID.split(':');
        /*if(cluslst.size()>0){
            cluslst=cluslst[1].split('&');
        }*/
        System.debug(cluslst);
        System.debug(accName);
        List<String> zz=new List<string>{'Direct Dealer','Distributor','Dealer'};
        List<recordType> rd=[select id,name from recordType where name in:zz];
        List<string> strRecordType =new  List<string>();
        for(recordtype r:rd){
            strRecordType.add(r.id);
        }
        List<account> accLis1=[Select  id,Name,ownerId,Media__c,APPL_Taluk__c,APPL_Taluk__r.Name,APPL_Taluk__r.Record_Vertical__c,PIN_Code__c,State__c,District__c,City__c,Street_Address__c,Contact_Number_Mobile__c from account where APPL_Taluk__r.Cluster__c in:cluslst AND Recordtypeid in:strRecordType AND( name like :accName+'%' OR Contact_Number_Mobile__c like : accName+'%')];       
        System.debug(acclis1);
        return acclis1;
    }
   //To get stored Branding Request.
    @RemoteAction
    public static List<Branding_Request__c> collectStoredBranding(){
        List<Branding_Request__c> brandingList=new List<Branding_Request__c>();
        brandingList.addAll([select id,Type__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c,Submitted_By__c,Language__c,Shop_Name__c,Cluster__c,Request_Type__c,Media_Type__c,Vertical_type__c,Branding_type__c,Branding_Request__r.CaseNumber,Shop_Name__r.Name,shop_Name__r.APPL_Taluk__c,Vendor_Account__c,Vendor_Account__r.Name from Branding_Request__c where CreatedBy.Id=:userinfo.getUserId() and shop_Name__r.APPL_Taluk__c!='' and Branding_Approved_Rejected__c='Request Created' ]);        
        return brandingList;
    }
    //To get Accounts.
    @RemoteAction
    public static List<Account> collectAccount1(string id){
        list<Account> newListAccount=new list<Account>();
        List<String> zz=new List<string>{'Direct Dealer','Distributor','Dealer'};
        List<recordType> rd=[select id,name from recordType where name in:zz];
        List<string> strRecordType =new  List<string>();
        for(recordtype r:rd){
            strRecordType.add(r.id);
        }
      newListAccount.addAll([select id,ownerId,name,PIN_Code__c,State__c,District__c,City__c,Street_Address__c,Contact_Number_Mobile__c from Account where APPL_Taluk__r.Cluster__c =:id  AND Recordtypeid in:strRecordType ]);
      
       System.debug(newListAccount);
        return newListAccount;
    }

   @RemoteAction
   public static boolean approveRequest(List<String> brandids,String comment,List<String> vendlst){
       System.debug('=====>>'+comment);
        return (approvalProcess(brandids,comment,'Approve',vendlst));
   }

   @RemoteAction
   public static boolean rejectRequest(List<String> brandids,String comment,List<String> vendlst){
       System.debug('=====>>'+comment);
        return (approvalProcess(brandids,comment,'Reject',vendlst));
   }

    @RemoteAction
    public static boolean approvalProcess(List<String> brandids,String comment, String action,List<String> vendlst){
        try{
                        //branding list
                        System.debug('branding list ---> '+brandids);
                        List<Branding_Request__c> brandInfoList=new List<Branding_Request__c>();
                        brandInfoList.addAll([select Id,Name,User1__c,Cluster__c,Branding_Type__c,Request_Type__c,Media_Type__c,Vendor_Fee__c,Vendor_Account__c,Vendor_Account__r.Name  from Branding_Request__c where id in:brandids]);
                        //vendor list
                         System.debug('vendor list ---> '+vendlst);
                        List<Account> VendorInfoList=new List<Account>();
                        VendorInfoList.addAll([select Id,Name,Vendor_Cluster__c,Board_4X2__c,Board_6X3__c,Board_8X3__c,Board_8X4__c from Account where RecordType.Name = 'Branding Vendor' and Name in:vendlst]);

                        Map<Id,Branding_Request__c> brdMap=new Map<Id,Branding_Request__c>();
                        for(Branding_Request__c temp:brandInfoList){
                            brdMap.put(temp.Id,temp);
                        }

                        Map<Id,List<Account>> vendMap=new Map<Id,List<Account>>();
                        for(Account temp:VendorInfoList){
                            if(vendMap.containsKey(temp.Id)){
                                List<Account> vtemp=vendMap.get(temp.Id);
                                vtemp.add(temp);
                                vendMap.put(temp.Name,vtemp);
                            }else{
                                List<Account> vtemp=new List<Account>();
                                vtemp.add(temp);
                                vendMap.put(temp.Id,vtemp);
                            }
                        }
                        System.debug(vendMap);
            List<Branding_Request__c> updBrandList=new List<Branding_Request__c>();
            System.debug(brandids);
            System.debug(comment);
            System.debug(action);
            List<ProcessInstance> PIList=new List<ProcessInstance>();
            List<ProcessInstanceWorkitem> PIWList;
            List<Approval.ProcessWorkitemRequest> APWRList;
            PIList.addAll([SELECT Id, Status,TargetObjectId FROM ProcessInstance WHERE TargetObjectId IN :brandids and Status = 'Pending']);
            System.debug(PIList);
            Set<Id> targetIdSet=new Set<Id>();
            
            for(ProcessInstance temp:PIList){
                targetIdSet.add(temp.Id);
            }
            System.debug(targetIdSet);
            PIWList=new List<ProcessInstanceWorkitem>();
            if(targetIdSet.size()>0){
                PIWList.addAll([SELECT Id,ProcessInstanceId FROM ProcessInstanceWorkitem where ProcessInstanceId IN: targetIdSet]);
                APWRList=new List<Approval.ProcessWorkitemRequest>();
                for(ProcessInstanceWorkitem temp:PIWList){
                    Approval.ProcessWorkitemRequest appReq = new Approval.ProcessWorkitemRequest();
                    appReq.setComments(comment);
                    appReq.setAction(action);
                    appReq.setWorkitemId(temp.Id);
                    APWRList.add(appReq);
                }

                System.debug('APWRList--'+APWRList);

                if(APWRList.size()>0){
                    list<Approval.ProcessResult> Result=  Approval.process(APWRList);
                    System.debug(Result);
                    List<Id> resIds=new List<Id>();
                    boolean appr=true;
                    for(Approval.ProcessResult resultTemp:Result){

                        if(resultTemp.isSuccess() && resultTemp.getInstanceStatus()=='Approved' ){
                            System.debug(resultTemp.getEntityId());
                            Integer n=-1;
                            for(Integer i=0;i<brandids.size();i++){
                                if(brandids[i]==resultTemp.getEntityId()){
                                    n=i;
                                    break;
                                }
                            }

                            Branding_Request__c brandtemp=brdMap.get(brandids[n]);
                            brandtemp.Vendor_Account__c=vendlst[n];
                            brandtemp.Branding_Approved_Rejected__c= 'Vendor Assigned';
                            brandtemp.Vendor_Fee__c=0;
                            Account selectedVendor=null;

                            Decimal Total=0;
                            if(brandtemp.Branding_Type__c=='Standard' ){
                                 List<Account> vendortemplst=vendMap.get(vendlst[n]);
                                 for(Account t:vendortemplst){
                                 
                                    if(brandtemp.Cluster__c.toUpperCase()==t.Vendor_Cluster__c ){
                                        selectedVendor=t;
                                        break;
                                    }
                                 }

                                if(brandtemp.Media_Type__c=='4x2'){
                                    Total=Total+(4*2*Decimal.valueOf(String.ValueOf(selectedVendor.get('Board_4X2__c')==null?0:selectedVendor.get('Board_4X2__c'))));
                                }else if(brandtemp.Media_Type__c=='6x3'){
                                    Total=Total+(6*3*Decimal.valueOf(String.ValueOf(selectedVendor.get('Board_6X3__c')==null?0:selectedVendor.get('Board_6X3__c'))));
                                }else if(brandtemp.Media_Type__c=='8x3'){
                                    Total=Total+(8*3*Decimal.valueOf(String.ValueOf(selectedVendor.get('Board_8X3__c')==null?0:selectedVendor.get('Board_8X3__c'))));
                                }else if(brandtemp.Media_Type__c=='8x4'){
                                    Total=Total+(8*4*Decimal.valueOf(String.ValueOf(selectedVendor.get('Board_8X4__c')==null?0:selectedVendor.get('Board_8X4__c'))));
                                }else{
                                    Total=0;
                                }
                                                             
                                brandtemp.Vendor_Fee__c=Total+Decimal.valueOf(String.valueOf(Label.MiscellaneousCost));
                            }
                            updBrandList.add(brandtemp);

                        }else{
                            appr=false;
                        }
                    }

                    if(updBrandList.size()>0)
                        update updBrandList;
                    System.debug(Result);
            }
         }else{
             return false;
         }
            return true;
        }catch(Exception ex){
            System.debug(ex.getLineNumber());
            System.debug(ex.getMessage());
            System.debug(ex);
            return false;
        }
    }

 @RemoteAction
    public static WrapBrand relatedBrandingRequests(string da, string db){
    List<String> profName=new List<String>();
    profName.add('Regional Branding Manager');
    profName.add('BD');
    profName.add('Head Branding');
    profName.add('System Administrator');

    String usrProfileId=userInfo.getProfileId();
    String prof='';
    String sys='';

    List<Profile> proflist=[select id,name from profile where name in:profName];

   System.debug(prof);
    for(Profile pf:proflist){
        if(pf.id==usrProfileId){
            prof=pf.Name;
            break;
        }
    }

    WrapBrand z=new WrapBrand();
    List<Branding_Request__c> brandingList=new List<Branding_Request__c>();
    brandingList.clear();
    System.debug(da);
    System.debug(db);

   DateTime d1 = DateTime.Valueof(da+' 00:00:00');
    DateTime d2 = DateTime.Valueof(db+' 24:59:59');
    System.debug(prof);

    if(prof=='BD'){  
     brandingList.addAll([select id,User1__c,User1__r.name,Vertical_type__c,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__c, Cluster__c, Branding_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c, Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name  from Branding_Request__c  where Submitted_By__c=:userInfo.getUserId() AND CreatedDate>=:d1 AND CreatedDate<=:d2]); 
    }else if(prof=='Regional Branding Manager'){
        brandingList.addAll([select id,User1__c,User1__r.name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__c,Vertical_type__c, Cluster__c, Branding_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.ShippingCity,shop_Name__r.ShippingStreet,shop_Name__r.ShippingState,shop_Name__r.ShippingPostalCode,shop_Name__r.ShippingCountry,Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name from Branding_Request__c  where RBM__c=:userInfo.getUserId() AND CreatedDate>=:d1 AND CreatedDate<=:d2 AND Branding_Approved_Rejected__c!='Request Created']);
    }else if(prof=='Head Branding'){
        brandingList.addAll([select id,User1__c,User1__r.name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__c,Vertical_type__c, Cluster__c, Branding_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.ShippingCity,shop_Name__r.ShippingStreet,shop_Name__r.ShippingState,shop_Name__r.ShippingPostalCode,shop_Name__r.ShippingCountry,Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name from Branding_Request__c  where Branding_Head__c=:userInfo.getUserId() AND CreatedDate>=:d1 AND CreatedDate<=:d2]);
    }else{
        brandingList.addAll([select id,User1__c,User1__r.name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__c, Vertical_type__c,Cluster__c, Branding_type__c,Request_Type__c, Branding_Approved_Rejected__c, Media_Type__c,Type__c,Shop_Name__r.Contact_Name__c , Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,Shop_Name__r.name, shop_Name__r.APPL_Taluk__c,shop_Name__r.APPL_Taluk__r.Name,CreatedBy.name,CreatedDate,shop_Name__r.Website,shop_Name__r.Shop_Image__c,Submit_For_Aprroval_Date__c,Branding_Products__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.ShippingCity,shop_Name__r.ShippingStreet,shop_Name__r.ShippingState,shop_Name__r.ShippingPostalCode,shop_Name__r.ShippingCountry,Escalated_To_Branding_Head__c,Vendor_Account__c,Vendor_Account__r.Name from Branding_Request__c  where  CreatedDate>=:d1 AND CreatedDate<=:d2]);
    }
        
         Set<Id> setIds=new Set<Id>();
         z.newrequest.addAll(brandingList);
         for(Branding_Request__c tt:brandingList){
             setIds.add(tt.Id);
         }
        
         z.approval.addAll([SELECT TargetObjectId,LastActor.Name,SubmittedById, CompletedDate, Status, Id,(SELECT Id, StepStatus, Comments FROM StepsAndWorkitems where (StepStatus='Approved' OR StepStatus='Rejected' )) FROM ProcessInstance where TargetObjectId in:setIds and (status='Approved' OR Status='Rejected' )]);

         return z;

}

//change Shop Address
@RemoteAction
   
   public static  boolean changeAddress(String id,String street,String city,String state,String district,String pin){

    try{
        Account acc=new Account();
        acc.id=id;
        acc.Street_Address__c=street;
        acc.City__c=city;
        acc.State__c=state;
        acc.District__c=district;
        acc.PIN_Code__c=pin;       
        update acc;
        return true;
   }catch(Exception ex){
       System.debug(ex);
       return false;
   }
}

   // ends here!

   @RemoteAction
    public static String updateReloaded(List<BrandWrap> bwlist,List<String> delIds,boolean casebol,String caseId){
        try{
            List<Branding_Request__c> newBrand= new List<Branding_Request__c>();
            List<Branding_Request__c> oldBrand= new List<Branding_Request__c>();
            Set<String> accSet=new Set<String>();
            Set<String> clusSet=new Set<String>();
            for(BrandWrap temp:bwlist){
                accSet.add(temp.Shop);
                clusSet.add(temp.Cluster);
            }

           List<Account> vendorNames=new List<Account>();
           vendorNames.addAll([select Id,Primary_Vendor__c,Vendor_Cluster__c,Name from Account where RecordType.Name = 'Branding Vendor' and Primary_Vendor__c=true AND Vendor_Cluster__c IN: clusSet]);
           System.debug('Vendorrr List'+vendorNames);

           map<String,Id> mGetVendor =new map<String,Id>();
           for(Account vid:vendorNames){
                mGetVendor.put(vid.Name,vid.Id);

            }

            List<Branding_Request__c> brandaingReqlst= [SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate,Vendor_Account__c,Vendor_Account__r.Name  FROM  Branding_Request__c WHERE Shop_Name__c IN:accSet];
            Integer errcnt=0;
            Boolean bool;
            String ErroMessage='';
            for(BrandWrap temp:bwlist){
                if(temp.Id==''){
                    bool=false;
                    for(Branding_Request__c r:brandaingReqlst){
                        if(r.Shop_Name__c==temp.Shop && r.Branding_Approved_Rejected__c!='Rejected by RBM'   && (r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' ||r.Escalated_To_Branding_Head__c==true ||  r.Branding_Approved_Rejected__c=='Request Created')){
                        ErroMessage= ErroMessage + r.Shop_Name__r.Name+ ' is already in progress.';
                            bool=true;
                            break;
                        }

                    }
                    if(bool){
                        return ErroMessage ;
                    }else{
                        Branding_Request__c brdcrt=new Branding_Request__c();
                        if(mGetVendor.containsKey(temp.Cluster.toUpperCase())){
                           brdcrt.user1__c=mGetVendor.get(temp.Cluster.toUpperCase());
                           System.debug(mGetVendor.get(temp.Cluster.toUpperCase()));
                        }
                        brdcrt.Language__c=temp.Language;
                        brdcrt.Branding_Approved_Rejected__c='Request Created';
                        brdcrt.Shop_Name__c=temp.Shop;
                        brdcrt.Branding_Type__c=temp.BrandType;
                        brdcrt.Cluster__c=temp.Cluster;                      
                        brdcrt.Media_Type__c=temp.MediaType;
                        brdcrt.Type__c=temp.MediaChild;
                        brdcrt.Submitted_By__c=userinfo.getUserId();   /* Added recent item */
                        brdcrt.Request_Type__c='New';
                        brdcrt.Escalated_To_Branding_Head__c=false;
                        for(Branding_Request__c r:brandaingReqlst){
                            if(r.Shop_Name__c==temp.Shop && (r.createdDate+180)> System.Today()){
                                brdcrt.Request_Type__c='Repair';
                            }
                        }

                        newBrand.add(brdcrt);
                    }

                }else{
                    Branding_Request__c brdcrt=new Branding_Request__c();
                    brdcrt.id=temp.Id;                    
                    brdcrt.Branding_Approved_Rejected__c='Submitted To RBM';                    
                    brdcrt.Submit_For_Aprroval_Date__c=System.today();
                    oldBrand.add(brdcrt);
                }
            }//BrandWrap
             if(caseId==''){
                           case  c=new case();
                           Recordtype rcdid=[SELECT SobjectType, DeveloperName, Name, Id, IsActive FROM RecordType where SobjectType='case' and DeveloperName='Branding_Request' limit 1];                                             
                           c.recordtypeid=rcdid.id;
                           c.status='Open';
                           c.subject='';
                           insert c;
                           caseId=''+c.id;
                       }
           for(Branding_Request__c r:newBrand){
               r.Branding_Request__c=caseId;
           }
           if(oldBrand.size()>0)
               update oldBrand;

           if(newBrand.size()>0)
           {
               insert newBrand;
               for(Branding_Request__c r:newBrand){
                   r.Submit_For_Aprroval_Date__c=System.today();                  
                   r.Branding_Approved_Rejected__c='Submitted To RBM';               
               }
               update newBrand;

           }
            if(delIds.size()>0){
            system.debug('*********************************************************');
                system.debug(delIds);
                database.delete([select id from Branding_Request__c where id in:delIds]);
                }

           case cas=new Case();
           cas.id=caseId;
           cas.status='In Progress';
           update cas;
        return 'success';
        }
        catch(Exception ex){ System.debug(ex);return 'failed'; return String.valueOf(ex);  }
    }

    @RemoteAction
    public static String saveReloaded(List<BrandWrap> bwlist,List<String> delIds,boolean casebol,String caseId){
        try{
            List<Branding_Request__c>newBrand= new List<Branding_Request__c>();
            DateTime d2=System.Today()-180;
            Set<String> accSet=new Set<String>();
            Set<String> clusSet=new Set<String>();
            for(BrandWrap temp:bwlist){
                accSet.add(temp.Shop);
                clusSet.add(temp.Cluster);
            }

            System.debug(accSet);
            System.debug(clusSet);
           List<Account> vendorNames=new List<Account>();
           vendorNames.addAll([select Id,Primary_Vendor__c,Vendor_Cluster__c,Name from Account where RecordType.Name = 'Branding Vendor' and Primary_Vendor__c=true AND Vendor_Cluster__c IN: clusSet]);
           System.debug('Vendorrr List'+vendorNames);
           map<String,Id> mGetVendor =new map<String,Id>();
           for(Account vid:vendorNames){
                mGetVendor.put(vid.Id,vid.Name);

            }

            List<Branding_Request__c> brandaingReqlst= [SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate  FROM  Branding_Request__c WHERE Shop_Name__c IN:accSet];
system.debug('~~~~~~~~~~~~~~~~~~~~~~~~~~~');
system.debug(brandaingReqlst);
            Integer errcnt=0;
            Boolean bool;
            String ErroMessage='';
            for(BrandWrap temp:bwlist){
                if(temp.Id==''){
                    bool=false;
                    for(Branding_Request__c r:brandaingReqlst){
                        if(r.Shop_Name__c==temp.Shop && r.Branding_Approved_Rejected__c!='Rejected by RBM'  && (r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' || r.Escalated_To_Branding_Head__c==true ||  r.Branding_Approved_Rejected__c=='Request Created')){
                        ErroMessage= ErroMessage + r.Shop_Name__r.Name+ ' is already in progress.';
                            bool=true;
                            break;
                        }
                    }
                    if(bool){
                        return ErroMessage ;
                    }else{
                        Branding_Request__c brdcrt=new Branding_Request__c();
                        if(mGetVendor.containsKey(temp.Cluster.toUpperCase())){
                           brdcrt.user1__c=mGetVendor.get(temp.Cluster.toUpperCase());
                           System.debug(mGetVendor.get(temp.Cluster.toUpperCase()));
                        }
                        brdcrt.Language__c=temp.Language;
                        brdcrt.Branding_Approved_Rejected__c='Request Created';
                        brdcrt.Shop_Name__c=temp.Shop;
                        brdcrt.Branding_Type__c=temp.BrandType;
                        brdcrt.Cluster__c=temp.Cluster;                       
                        brdcrt.Media_Type__c=temp.MediaType;
                        brdcrt.Type__c=temp.MediaChild;
                        brdcrt.Submitted_By__c=userinfo.getUserId();   /* Added recent item */
                        brdcrt.Request_Type__c='New';
                        brdcrt.Escalated_To_Branding_Head__c=false;

                        for(Branding_Request__c r:brandaingReqlst){
                            if(r.Shop_Name__c==temp.Shop && (r.createdDate+180)> System.Today()){
                                brdcrt.Request_Type__c='Repair';
                            }
                        }

                        newBrand.add(brdcrt);
                    }


                }
            }//BrandWrap
             if(caseId==''){
                           case  c=new case();
                          Recordtype rcdid=[SELECT SobjectType, DeveloperName, Name, Id, IsActive FROM RecordType where SobjectType='case' and DeveloperName='Branding_Request' limit 1];                         
                           c.recordtypeid=rcdid.id;
                           c.status='Open';
                           c.subject='';
                           insert c;
                           caseId=''+c.id;
                       }
           for(Branding_Request__c r:newBrand){
               r.Branding_Request__c=caseId;
           }
           System.debug(newBrand);
           if(newBrand.size()>0)
           {
               insert newBrand;
           }

        return 'success';
        }
        catch(Exception ex){ System.debug(ex); System.debug('zuzuzuz :'+ex.getLineNumber());return 'failed'; return String.valueOf(ex);  }
    }
        @RemoteAction
        public static boolean deleteBrandingRequest(String brandingId){
            try{
                 Id brandId =  brandingId;
                 database.delete(brandId);  
                 return true;
            }catch(Exception ex){
                 System.debug(ex);
                 return false;
            }
        }

    public class BrandWrap{
        public String Id{get;set;}
        public String Shop{get;set;}
        public String BrandType{get;set;}
        public String MediaType{get;set;}
        public String MediaChild{get;set;}
        public String Language{get;set;}
        public String Cluster{get;set;}
        public String OwnerId{get;set;}
        public Boolean mediabol{get;set;}
        public Boolean mchildbol{get;set;}
        public Boolean updbol{get;set;}
        public String error{get;set;}
    }

    public class WrapBrand{
        List<Branding_Request__c> newrequest;
        List<Branding_Request__c> oldrequest;
        List<ProcessInstance> approval;
        List<Account> vendor;
        public WrapBrand(){
            newrequest=new  List<Branding_Request__c>();
            oldrequest=new  List<Branding_Request__c>();
            approval=new List<ProcessInstance>();
            vendor=new List<Account>();

        }
    }
}
public without sharing class VendorPageController{
    
    public final static String afterFolderId='00l4C000000M6b1QAC';
    public final static String beforeFolderId='00l4C000000M6b6QAC';
    public string getShopId {get;set;}
    @RemoteAction
    public static List<Branding_Request__c> collectVendorBrand(){
     
        List<String> condition=new List<String>();
        condition.add('Vendor Assigned-Rework');
        condition.add('Vendor Assigned');
        condition.add('Request Completed and Submitted');
        
        
        List<String> profName=new List<String>();
         profName.add('Head Branding');
         profName.add('Regional Branding Manager'); 
         profName.add('System Administrator');
         profName.add('Ashirvad Partner Community User');
         String usrProfileId=userInfo.getProfileId();     
         List<Profile> proflist=[select id,name from profile where name in:profName];
         String prof='';
          System.debug(prof);
          for(Profile pf:proflist){
            if(pf.id==usrProfileId){
                prof=pf.Name;
                break;
              
            }
         }
         List<Branding_Request__c> brdLst=new List<Branding_Request__c>();
         
         if(prof=='Ashirvad Partner Community User'){

          brdLst.addAll([select id,RejectComment__c,Vendor_Submitted_Date__c,Branding_Approved_Rejected__c,Name,(select id, name,ParentId from Attachments limit 2),Branding_Type__c,media_type__c,Request_Type__c,Type__c,Shop_Name__r.Name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c,vertical_type__c from Branding_Request__c where user1__c=:userInfo.getUserId() and  Branding_Approved_Rejected__c in:condition]);
         
         
        }else if(prof=='System Administrator' || prof=='Regional Branding Manager' || prof=='Head Branding' ){

          brdLst.addAll([select id,Vendor_Fee__c,Vendor_Submitted_Date__c,Branding_Approved_Rejected__c,Name,(select id, name,ParentId from Attachments limit 2),Branding_Type__c,media_type__c,Request_Type__c,Type__c,vertical_type__c,Shop_Name__r.Name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Phone_1__c,Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c from Branding_Request__c where Branding_Approved_Rejected__c in:condition]);
        
         }          

        return(brdLst);
        
    }
    
   
    @RemoteAction
    public static List<Branding_Request__c> collectApproveBrand(){
         List<String> profName=new List<String>();
         profName.add('Regional Branding Manager'); 
         profName.add('System Administrator');
         List<Branding_Request__c> brdLst=new List<Branding_Request__c>();
         String usrProfileId=userInfo.getProfileId();     
         List<Profile> proflist=[select id,name from profile where name in:profName];
         String prof='';
          System.debug(prof);
          for(Profile pf:proflist){
            if(pf.id==usrProfileId){
                prof=pf.Name;
                break;
            }
         }
         
         if(prof=='Regional Branding Manager' || prof=='System Administrator'){
             brdLst.addAll([select id,Vendor_Fee__c,Vendor_Submitted_Date__c,Branding_Approved_Rejected__c,Name,status__c,(select id, name,ParentId from Attachments limit 2),Branding_Type__c,media_type__c,Request_Type__c,Shop_Name__r.Name,Shop_Name__r.Primary_Contact_Person_Name__c,Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Contact_Number_Phone__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c ,Vertical_type__c from Branding_Request__c where RBM__c=:userInfo.getUserId() AND Branding_Approved_Rejected__c='Request Completed and Submitted']);
      
         }
        return(brdLst);
    }
        
    @RemoteAction
   public static boolean approveRequest(List<String> vendlst,String comment){
        return (approvalProcess(vendlst,comment,'Approve'));
   }
   
   @RemoteAction
   public static boolean rejectRequest(List<String> vendlst,String comment){
        return (approvalProcess(vendlst,comment,'Reject'));
   }
    
    @RemoteAction
    public static boolean approvalProcess(List<String> venIds,String comment, String action){
        try{
           
            System.debug(venIds);
            System.debug(comment);
            System.debug(action);
            
            Set<Id> brdIdSet=new Set<Id>();
            List<Branding_Request__c> brdlst=new List<Branding_Request__c>();                               
            List<ProcessInstance> PIList=new List<ProcessInstance>();
            List<ProcessInstanceWorkitem> PIWList;
            List<Approval.ProcessWorkitemRequest> APWRList;            
            PIList.addAll([SELECT Id, Status,TargetObjectId FROM ProcessInstance WHERE TargetObjectId IN :venIds and Status = 'Pending']);
            System.debug(PIList);
            Set<Id> targetIdSet=new Set<Id>();
            for(ProcessInstance temp:PIList){
                targetIdSet.add(temp.Id);
            }
            
            
            System.debug('target'+targetIdSet);
            PIWList=new List<ProcessInstanceWorkitem>();            
            if(targetIdSet.size()>0){
                PIWList.addAll([SELECT Id,ProcessInstanceId FROM ProcessInstanceWorkitem where ProcessInstanceId IN: targetIdSet]);
                System.debug('zzz'+PIWList);
                APWRList=new List<Approval.ProcessWorkitemRequest>();
                for(ProcessInstanceWorkitem temp:PIWList){
                    Approval.ProcessWorkitemRequest appReq = new Approval.ProcessWorkitemRequest();
                    appReq.setComments(comment);
                    appReq.setAction(action);
                    appReq.setWorkitemId(temp.Id);
                    APWRList.add(appReq);   
                }
                System.debug(APWRList);
                if(APWRList.size()>0){
                    list<Approval.ProcessResult> Result=  Approval.process(APWRList);
                    System.debug(Result);
                    for(Approval.ProcessResult tempResult:Result){
                        if(tempResult.isSuccess() && tempResult.getInstanceStatus()=='Rejected' ){
                          brdIdSet.add(tempResult.getEntityId());
                        }
                    }
                    for(id tt:brdIdSet){
                      Branding_Request__c tmp=new Branding_Request__c();
                      tmp.Id=tt;
                      tmp.RejectComment__c=comment;
                      brdlst.add(tmp);
                    }
                    if(brdlst.size()>0){
                      update brdlst;
                    }
                                   
                }else{
                    return false;
                }
            }else{
                return false;
            }
            
            return true;
        }catch(Exception ex){
            System.debug(ex.getMessage());
            System.debug(ex);
            return false;
        }
    }   
   
    @RemoteAction
    public static boolean submitData(List<VenBrandWrap> venlst){
        try{
            List<Branding_Request__c> brdList=new List<Branding_Request__c>();
            for(VenBrandWrap ven:venlst){
                Branding_Request__c temp=new Branding_Request__c();
                temp.Id=ven.BrandId;
                temp.Branding_Approved_Rejected__c=ven.Status;
                temp.Vendor_Submitted_Date__c=System.today();
                brdList.add(temp);  
            }
            if(brdList.size()>0)
                update brdList;
                
            return true;
        }catch(Exception ex){
            System.debug(ex);
            return false;
        }
    }
        
    @RemoteAction 
    public static String uploadImage(VenBrandWrap ven,boolean bol){
       try{
           Attachment doc=new Attachment();
           if(bol){
               
               if(ven.beforeDocId!=''){
                  doc.id=ven.beforeDocId;
                  doc.name='Before'+ven.BrandId+''+ven.beforeDocExt;
                  doc.body=EncodingUtil.base64Decode(ven.beforeDoc.substring(ven.beforeDoc.indexOf(',')+1,ven.beforeDoc.length()));
                  update doc;
                 
               }else{
                   doc.body=EncodingUtil.base64Decode(ven.beforeDoc.substring(ven.beforeDoc.indexOf(',')+1,ven.beforeDoc.length()));
                   doc.name='Before'+ven.BrandId+''+ven.beforeDocExt;
                   doc.ParentId=ven.BrandId;
                   insert doc;
               }  
           }else{
               if(ven.afterDocId!=''){
                  doc.id=ven.afterDocId;
                  doc.name='After'+ven.BrandId+''+ven.afterDocExt;
                  doc.body=EncodingUtil.base64Decode(ven.afterDoc.substring(ven.afterDoc.indexOf(',')+1,ven.afterDoc.length()));
                  update doc;
               }else{
                   doc.body=EncodingUtil.base64Decode(ven.afterDoc.substring(ven.afterDoc.indexOf(',')+1,ven.afterDoc.length()));
                   doc.name='After'+ven.BrandId+''+ven.afterDocExt;
                   doc.ParentId=ven.BrandId;
                   insert doc;
               }  
           
           }
           return doc.Id;
       }catch(Exception ex){
           System.debug(ex);
           return 'Failed';
       }  
    } 
    
    public class VenBrandWrap{
        public String BrandId{get;set;}
        public String Status{get;set;}
        public String afterDoc{get;set;}
        public String beforeDoc{get;set;}
        public String afterDocId{get;set;}
        public String beforeDocId{get;set;}
        public String afterDocExt{get;set;}
        public String beforeDocExt{get;set;}
    }
    
 
}
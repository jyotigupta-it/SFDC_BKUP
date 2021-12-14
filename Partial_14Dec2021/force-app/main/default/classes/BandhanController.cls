public without sharing class BandhanController{
    public static Final String BrandingRequest='01230000001DRzUAAW';
    public String Ids;
    public String Vertical {get;set;}
    public Boolean paramCheck{get;set;}

    public BandhanController(){
        try{
            String accid='';
            accid=apexpages.currentpage().getparameters().get('id');
            Account acc=[select id,OwnerId,APPL_Taluk__c,APPL_Taluk__r.Name,APPL_Taluk__r.Cluster__c,PIN_Code__c,State__c,District__c,City__c,Street_Address__c,Contact_Number_Mobile__c from Account where id=:accid];

            User u=[select Vertical_Type__c from User where id=:acc.OwnerId];
            Vertical=u.Vertical_Type__c;
            paramCheck=true;
       }catch(Exception ex){
           System.debug(ex);
           paramCheck=false;
       }
    }

     @RemoteAction
public static List<Branding_Request__c> collectStoredBranding(){
    List<Branding_Request__c> brandingList=new List<Branding_Request__c>();

  /*Commented By Pooja*/
  //  brandingList.addAll([select id,Submitted_By__c,Language__c,Shop_Name__c,Cluster__c,Type__c,Media_Type__c,Branding_type__c,Branding_Request__r.CaseNumber,Shop_Name__r.Name,shop_Name__r.APPL_Taluk__c,shop_Name__r.ShippingCity,shop_Name__r.ShippingStreet,shop_Name__r.ShippingState,shop_Name__r.ShippingPostalCode,shop_Name__r.ShippingCountry from Branding_Request__c where CreatedBy.id=:userinfo.getUserId() and shop_Name__r.APPL_Taluk__c!='' and Branding_Approved_Rejected__c='Request Created' and Bhandhan_Check__c=true ]);
    /*Added By Pooja*/
     brandingList.addAll([select id,Submitted_By__c,Language__c,Shop_Name__c,Cluster__c,Type__c,Media_Type__c,Branding_type__c,Branding_Request__r.CaseNumber,Shop_Name__r.Name,shop_Name__r.APPL_Taluk__c,shop_Name__r.PIN_Code__c,shop_Name__r.State__c,shop_Name__r.District__c,shop_Name__r.City__c,shop_Name__r.Street_Address__c from Branding_Request__c where CreatedBy.id=:userinfo.getUserId() and shop_Name__r.APPL_Taluk__c!='' and Branding_Approved_Rejected__c='Request Created' and Bhandhan_Check__c=true ]);
    
    return brandingList;
}


@RemoteAction
public static Account collectAccount(String accid){
   
   /*Commented By Pooja*/
   // return([SELECT Name,OwnerId, Id, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry,APPL_Taluk__r.Cluster__c,APPL_Taluk__r.Name,APPL_Taluk__r.User__c FROM Account where id=:accid]);
    /*Added By Pooja*/
    return([SELECT Name,OwnerId, Id,PIN_Code__c,State__c,District__c,City__c,Street_Address__c ,APPL_Taluk__r.Cluster__c,APPL_Taluk__r.Name,APPL_Taluk__r.User__c FROM Account where id=:accid]);


}

/*
@RemoteAction
public static  boolean changeAddress(String id,String street,String city,String state,String country,String pin){
    try{
        Account acc=new Account();
        acc.id=id;
        acc.ShippingStreet=street;
        acc.ShippingCity=city;
        acc.ShippingState=state;
        acc.ShippingCountry=country;
        acc.ShippingPostalCode=pin;
        update acc;
        return true;
   }catch(Exception ex){
       System.debug(ex);
       return false;
   }
}
*/

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




@RemoteAction
    public static String saveReloaded(List<BrandWrap> bwlist,boolean casebol,String caseId){
        try{


            List<Branding_Request__c>newBrand= new List<Branding_Request__c>();

            DateTime d2=System.Today()-180;
            Set<String> accSet=new Set<String>();
            Set<String> clusSet=new Set<String>();
            for(BrandWrap temp:bwlist){
                accSet.add(temp.Shop);
                //Need to change for Cluster

                clusSet.add(temp.Cluster);
            }

           List<Vendor_Details__c> vendorNames=new List<Vendor_Details__c>();
           vendorNames.addAll([select Primary_Vendor__c,Vendor_Cluster__c,vendor__c from Vendor_Details__c where Primary_Vendor__c=true AND Vendor_Cluster__c IN: clusSet]);
           System.debug('Vendorrr List'+vendorNames);

           map<String,Id> mGetVendor =new map<String,Id>();
           for(Vendor_Details__c vid:vendorNames){
                mGetVendor.put(vid.Vendor_Cluster__c,vid.vendor__c);

            }

            List<Branding_Request__c> brandaingReqlst= [SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate  FROM  Branding_Request__c WHERE Shop_Name__c IN:accSet];


            Integer errcnt=0;
            Boolean bool;
            String ErroMessage='';
            for(BrandWrap temp:bwlist){
                if(temp.Id==''){
                    bool=false;
                    for(Branding_Request__c r:brandaingReqlst){
                        if(r.Shop_Name__c==temp.Shop && r.Branding_Approved_Rejected__c!='Rejected by RBM' && r.Branding_Approved_Rejected__c!='Request Created' && (r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' || r.Escalated_To_Branding_Head__c==true ||  r.Branding_Approved_Rejected__c=='Request Created')){
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
                       
                        //Commented By Pooja
                       /*  brdcrt.Cluster__c=temp.TalukName+'-'+temp.Cluster;  */
                       
                        brdcrt.Media_Type__c=temp.MediaType;
                        brdcrt.Type__c=temp.MediaChild;
                         brdcrt.Submitted_By__c=temp.OwnerId;  /* Added recent item */
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
                           /* Recordtype rcdid=[select id,name from recordtype where name=:'Branding Request' and SobjectType='Case' limit 1];
                           c.recordtypeid=rcdid.id;   */
                           c.recordtypeid=BrandingRequest;
                           c.status='Open';
                           c.subject='';
                           insert c;
                           caseId=''+c.id;
                       }
           for(Branding_Request__c r:newBrand){
               r.Branding_Request__c=caseId;
           }
           if(newBrand.size()>0)
           {
               insert newBrand;
           }


        return 'success';


        }
        catch(Exception ex){ System.debug(ex);return 'failed'; return String.valueOf(ex);  }
    }

 @RemoteAction
    public static String updateReloaded(List<BrandWrap> bwlist,boolean casebol,String caseId){
        try{
            List<Branding_Request__c> newBrand= new List<Branding_Request__c>();
            List<Branding_Request__c> oldBrand= new List<Branding_Request__c>();

            Set<String> accSet=new Set<String>();
            Set<String> clusSet=new Set<String>();
            for(BrandWrap temp:bwlist){
                accSet.add(temp.Shop);
                clusSet.add(temp.Cluster);
            }

           List<Vendor_Details__c> vendorNames=new List<Vendor_Details__c>();
           vendorNames.addAll([select Primary_Vendor__c,Vendor_Cluster__c,vendor__c from Vendor_Details__c where Primary_Vendor__c=true AND Vendor_Cluster__c IN: clusSet]);
           System.debug('Vendorrr List'+vendorNames);

           map<String,Id> mGetVendor =new map<String,Id>();
           for(Vendor_Details__c vid:vendorNames){
                mGetVendor.put(vid.Vendor_Cluster__c,vid.vendor__c);

            }

            List<Branding_Request__c> brandaingReqlst= [SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate  FROM  Branding_Request__c WHERE Shop_Name__c IN:accSet];


            Integer errcnt=0;
            Boolean bool;
            String ErroMessage='';
            for(BrandWrap temp:bwlist){
                if(temp.Id==''){
                    bool=false;
                    for(Branding_Request__c r:brandaingReqlst){
                        if(r.Shop_Name__c==temp.Shop && r.Branding_Approved_Rejected__c!='Rejected by RBM'   && (r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' ||r.Escalated_To_Branding_Head__c==true ||  r.Branding_Approved_Rejected__c=='Request Created')){
                        //if(r.Shop_Name__c==temp.Shop && r.Branding_Approved_Rejected__c=='Submitted To RBM'){
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
                     
                        //Commented By Pooja
                       /* brdcrt.Cluster__c=temp.TalukName+'-'+temp.Cluster;*/
                        
                        brdcrt.Media_Type__c=temp.MediaType;
                        brdcrt.Type__c=temp.MediaChild;
                        brdcrt.Submitted_By__c=temp.OwnerId;   /* Added recent item */
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
                    if(temp.BrandType=='Recce'){
                        brdcrt.Branding_Approved_Rejected__c='Submitted';
                    }else{
                        brdcrt.Branding_Approved_Rejected__c='Submitted To RBM';
                    }
                    brdcrt.Submit_For_Aprroval_Date__c=System.today();
                    //brdcrt.Branding_Approved_Rejected__c='Submitted To RBM';
                    oldBrand.add(brdcrt);
                }
            }//BrandWrap
             if(caseId==''){
                           case  c=new case();
                           /* Recordtype rcdid=[select id,name from recordtype where name=:'Branding Request' and SobjectType='Case' limit 1];
                           c.recordtypeid=rcdid.id;   */
                           c.recordtypeid=BrandingRequest;
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
                   if(r.Branding_Type__c=='Recce'){
                       r.Branding_Approved_Rejected__c='Submitted';
                   }else{
                       r.Branding_Approved_Rejected__c='Submitted To RBM';
                   }
               }
               update newBrand;

           }

           case cas=new Case();
           cas.id=caseId;
           cas.status='In Progress';
           update cas;


        return 'success';


        }
        catch(Exception ex){ System.debug(ex);return 'failed'; return String.valueOf(ex);  }
    }






public class BrandWrap{
    public String Id{get;set;}
    public String Shop{get;set;}
    public String BrandType{get;set;}
    public String MediaType{get;set;}
    public String MediaChild{get;set;}
    public String Language{get;set;}
    public String Cluster{get;set;}
 
 //Commented By Pooja
   /* public String TalukName{get;set;} */
   
    public String OwnerId{get;set;}
    /*boolean check*/
    public Boolean mediabol{get;set;}
    public Boolean mchildbol{get;set;}
    public Boolean updbol{get;set;}

    public String error{get;set;}
}

}
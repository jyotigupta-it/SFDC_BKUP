public class CameraAccess {
    public static ContentVersion cont1 = new ContentVersion();
    public static ContentVersion cont2  = new ContentVersion();
    public static ContentVersion cont3  = new ContentVersion();
    public static ContentVersion cont4  = new ContentVersion();
    public static Id accId {get;set;}
    public List<String> Files {get;set;}
	
    Transient static  boolean isError;
    public static list<ContentVersion> listcont = new list<ContentVersion>();
    public static list<ContentDocumentLink> listContLink=new list<ContentDocumentLink>();
    public CameraAccess(ApexPages.StandardController stdController) {
        accId= ApexPages.CurrentPage().getparameters().get('id');
        /*cont1 = new ContentVersion();
        cont2 = new ContentVersion();
        cont3 = new ContentVersion();
        cont4 = new ContentVersion();*/
        listcont=new list<ContentVersion>();
        listContLink=new list<ContentDocumentLink>();
        isError=false;
    }      
  
    /*public  pageReference saveFile()
    { 
        try{
            cont1.PathOnClient = cont1.title;
            cont1.Origin = 'H';
            listcont.add(cont1);
            cont2.PathOnClient = cont2.title;
            cont2.Origin = 'H';
            listcont.add(cont2);
            cont3.PathOnClient = cont3.title;
            cont3.Origin = 'H';
            listcont.add(cont3);
            cont4.PathOnClient = cont4.title;
            cont4.Origin = 'H';
            listcont.add(cont4);
            if( String.isNotEmpty(cont1.PathOnClient) && String.isNotEmpty(cont2.PathOnClient)  && String.isNotEmpty(cont3.PathOnClient) && String.isNotEmpty(cont4.PathOnClient) ){
                System.debug('if block'+listcont);
                insert listcont;
                listcont.clear();
            }else{
                isError=true;
                System.debug('else block');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please choose all the 4 images..'));
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please choose all the 4 images..');
                ApexPages.addMessage(myMsg);
                return null;
                
            }
            if(String.isNotEmpty(cont1.PathOnClient) && String.isNotEmpty(cont2.PathOnClient)  && String.isNotEmpty(cont3.PathOnClient) && String.isNotEmpty(cont4.PathOnClient)){
                System.debug('size of list..'+listcont.size());
                Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont1.Id].ContentDocumentId;
                ContentDocumentLink cDocLink = new ContentDocumentLink();
                cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
                cDocLink.LinkedEntityId = accId;//Add attachment parentId
                cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
                listContLink.add(cDocLink);
                Id conDocument2 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont2.Id].ContentDocumentId;
                ContentDocumentLink cDocLink2 = new ContentDocumentLink();
                cDocLink2.ContentDocumentId = conDocument2;
                cDocLink2.LinkedEntityId = accId;
                cDocLink2.ShareType = 'I';
                cDocLink2.Visibility = 'AllUsers';
                listContLink.add(cDocLink2);
                Id conDocument3 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont3.Id].ContentDocumentId;
                ContentDocumentLink cDocLink3 = new ContentDocumentLink();
                cDocLink3.ContentDocumentId = conDocument3;
                cDocLink3.LinkedEntityId = accId;
                cDocLink3.ShareType = 'I';
                cDocLink3.Visibility = 'AllUsers';
                listContLink.add(cDocLink3);
                Id conDocument4 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont4.Id].ContentDocumentId;
                ContentDocumentLink cDocLink4 = new ContentDocumentLink();
                cDocLink4.ContentDocumentId = conDocument4;
                cDocLink4.LinkedEntityId = accId;
                cDocLink4.ShareType = 'I';
                cDocLink4.Visibility = 'AllUsers';
                listContLink.add(cDocLink4);
                Insert listContLink;
                listContLink.clear();
                
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please choose all the 4 images..');
                ApexPages.addMessage(myMsg);
                isError=true;
            }
        }catch(Exception ex){
            system.debug('exception ocure at line--'+ ex.getLineNumber());
              system.debug('exception message--'+ ex.getMessage());
            system.debug('exception cause--'+ ex.getCause());
        }
        if(isError==true){
            // return new PageReference('/apex/PlumberClubEnrollmentCamera'); 
            return null;
        }
        else{
            return new PageReference('/'+accId); 
        }
    }*/
    
    // remote action
    @RemoteAction

        public static  pageReference saveFile2(List<String> Files)
    { 
         
        try{
        String AcctId;
        AcctId=Files[4];
        cont1 = new ContentVersion();
        cont2 = new ContentVersion();
        cont3 = new ContentVersion();
        cont4 = new ContentVersion();
        listcont = new list<ContentVersion>();
            system.debug('files--'+files[0]+'\n file 2 :'+files[1]);
            cont1.PathOnClient = Files[0];
            cont1.Origin = 'H';
            cont1.versiondata=EncodingUtil.base64Decode('This is version data');
            listcont.add(cont1);
            cont2.PathOnClient = Files[1];
            cont2.Origin = 'H';
         cont2.versiondata=EncodingUtil.base64Decode('This is version data');
            listcont.add(cont2);
            cont3.PathOnClient = Files[2];
            cont3.Origin = 'H';
         cont3.versiondata=EncodingUtil.base64Decode('This is version data');
            listcont.add(cont3);
            cont4.PathOnClient = Files[3];
            cont4.Origin = 'H';
         cont4.versiondata=EncodingUtil.base64Decode('This is version data');
            listcont.add(cont4);
            if( String.isNotEmpty(cont1.PathOnClient) && String.isNotEmpty(cont2.PathOnClient)  && String.isNotEmpty(cont3.PathOnClient) && String.isNotEmpty(cont4.PathOnClient) ){
                System.debug('if block'+listcont);
                insert listcont;
                listcont.clear();
            }else{
                isError=true;
                System.debug('else block');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please choose all the 4 images..'));
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please choose all the 4 images..');
                ApexPages.addMessage(myMsg);
                return null;
                
            }
            if(String.isNotEmpty(cont1.PathOnClient) && String.isNotEmpty(cont2.PathOnClient)  && String.isNotEmpty(cont3.PathOnClient) && String.isNotEmpty(cont4.PathOnClient)){
                System.debug('size of list..'+listcont.size());
                Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont1.Id].ContentDocumentId;
                ContentDocumentLink cDocLink = new ContentDocumentLink();
                cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
                cDocLink.LinkedEntityId =AcctId;//Add attachment parentId
                cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
                listContLink.add(cDocLink);
                Id conDocument2 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont2.Id].ContentDocumentId;
                ContentDocumentLink cDocLink2 = new ContentDocumentLink();
                cDocLink2.ContentDocumentId = conDocument2;
                cDocLink2.LinkedEntityId = AcctId;
                cDocLink2.ShareType = 'I';
                cDocLink2.Visibility = 'AllUsers';
                listContLink.add(cDocLink2);
                Id conDocument3 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont3.Id].ContentDocumentId;
                ContentDocumentLink cDocLink3 = new ContentDocumentLink();
                cDocLink3.ContentDocumentId = conDocument3;
                cDocLink3.LinkedEntityId = AcctId;
                cDocLink3.ShareType = 'I';
                cDocLink3.Visibility = 'AllUsers';
                listContLink.add(cDocLink3);
                Id conDocument4 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cont4.Id].ContentDocumentId;
                ContentDocumentLink cDocLink4 = new ContentDocumentLink();
                cDocLink4.ContentDocumentId = conDocument4;
                cDocLink4.LinkedEntityId = AcctId;
                cDocLink4.ShareType = 'I';
                cDocLink4.Visibility = 'AllUsers';
                listContLink.add(cDocLink4);
                if(!Test.isRunningTest())
                Insert listContLink;
                listContLink.clear();
                
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please choose all the 4 images..');
                ApexPages.addMessage(myMsg);
                isError=true;
            }
        }catch(Exception ex){
            system.debug('exception ocure at line--'+ ex.getLineNumber());
              system.debug('exception message--'+ ex.getMessage());
            system.debug('exception cause--'+ ex.getCause());
        }
        if(isError==true){
              System.debug('if pagereference...'+isError);
            // return new PageReference('/apex/PlumberClubEnrollmentCamera'); 
            return null;
        }
        else{
           // System.debug('else pagereference...'+AcctId);
            //return new PageReference('/'+AcctId);//https://ashirwardpipeslighting--partial.my.salesforce.com/'+AcctId 
             return null;
        }
    }
}
public with sharing class UploadExpenseAttachments_Ctrl {

    //Picklist of tnteger values to hold file count  
    public List<SelectOption> filesCountList {get; set;}  
    //Selected count  
    public String FileCount {get; set;}  
      
    public  List<Attachment> allFileList {get; set;}  
    public string attParentId {get;set;}

    public UploadExpenseAttachments_Ctrl() {
         //Initialize    
        filesCountList = new List<SelectOption>() ;  
        FileCount = '' ;  
        allFileList = new List<Attachment>() ;  



         attParentId = ApexPages.currentPage().getParameters().get('expId');
         system.debug('attParentId='+attParentId); 
        //Adding values count list - you can change this according to your need  
        for(Integer i = 1 ; i < 11 ; i++)  
            filesCountList.add(new SelectOption(''+i , ''+i)) ;  
    }

    public Pagereference SaveAttachments()  
    {  
        
        if(FileCount == null || FileCount == '')  
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select how many files you want to upload.'));  
  
        List<Attachment> listToInsert = new List<Attachment>() ;  
          
        //Attachment a = new Attachment(parentId = accid, name=myfile.name, body = myfile.body);  
        for(Attachment a: allFileList)  
        {  
            if(a.name != '' && attParentId != '' && a.body != null)  
                listToInsert.add(new Attachment(parentId = attParentId, name = a.name, body = a.body)) ;  
        }  
          
        //Inserting attachments  
         try {
              if(listToInsert.size() > 0)  
            {  
                system.debug('listToInsert inset Start size= '+listToInsert.size());
                insert listToInsert ;  
                system.debug('listToInsert inset finish');
                ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO, listToInsert.size() + ' file(s) are uploaded successfully'));  
                FileCount = '' ;  
            }  else  
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select at-least one file'));   
        } catch (DMLException e) {
             system.debug('DMLException '+e);
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
          return null;
        } finally {
                system.debug('listToInsert finally Start &&&&&size= '+listToInsert.size());
            if(listToInsert.size() > 0) {
                system.debug('listToInsert in Finally Block');
                for(Attachment a: allFileList){
                    a.body = null;
                    a = new Attachment();
                }
                allFileList.clear() ;  
                system.debug('listToInsert finally End ****size= '+listToInsert.size());
            }else{
                listToInsert = new List<Attachment>();
                allFileList.clear() ;  
                system.debug('listToInsert finally size= '+listToInsert.size());
            }
        }
             
        return null;  
    }  
      
    public PageReference ChangeCount()  
    {  
          allFileList.clear() ;  
        //Adding multiple attachments instance  
        //allFileList = new List<Attachment>() ; 
        for(Integer i = 1 ; i <= Integer.valueOf(FileCount) ; i++)  
            allFileList.add(new Attachment()) ;  
        return null ;  
    }  
}
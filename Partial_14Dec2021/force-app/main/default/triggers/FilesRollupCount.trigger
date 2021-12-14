/* *******************************XXX********************************************************
    Created By : Srilakshmi, KVP Business Solutions
    Description     : To calculate the number of attachments in promotion object for upload files button
**************************************XXX****************************************************** */
trigger FilesRollupCount on ContentDocumentlink (after insert) {
        
        List<ContentDocumentLink> data = trigger.isinsert?trigger.new:trigger.old;    
        
    FilesRollupCountHandler.getFileCount(data);
      FilesRollupCountHandler.getFileCountonAccount(data);
        
        
}
/********************************XXX********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 07-June-2017
Description     : To calculate the number of attachments in promotion object

**********************************XXX*******************************************************/
trigger NoOfAttachmentpromotion on Attachment (after insert,after delete,after undelete) {
    List<Attachment> data=trigger.isinsert?trigger.new:trigger.old;    
    List<id> promotionid = new List<id>();
    List<id> attid= new List<id>();
    for(Attachment att:data)
    {
        promotionid.add(att.ParentId);
        System.debug('***********'+att.ParentId +'************');
        attid.add(att.Id);
    }
    List<promotion__c> oldpromotionWithAtt = new List<promotion__c>([select id,total_no_of_attachment__c from promotion__c where id in:promotionid]);
    List<AggregateResult> totalCount= [select count(id) total from Attachment where parentid in:oldpromotionWithAtt group by parentid ];
    Integer i=0;
    List<promotion__c> ls = new List<promotion__c>();
    try{
    for(Attachment atr:data)
    {
        
     	  promotion__c pr=oldpromotionWithAtt.get(i);
        
        try{
          pr.Total_No_of_Attachment__c=Integer.valueOf(totalCount[i].get('total'));
       
        }
        catch(Exception ex)
        {
            pr.Total_no_of_attachment__c=0;
        }       
        i++;
       ls.add(pr);
    }
        update ls;
    }
        catch(exception ex1)
        {
            
        }
    
}
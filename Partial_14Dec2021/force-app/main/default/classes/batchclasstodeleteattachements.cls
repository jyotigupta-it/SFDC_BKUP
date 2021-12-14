global class batchclasstodeleteattachements implements Database.Batchable<sObject>{
   Datetime dateTm = Datetime.now().addMonths(-6);
   global database.queryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([SELECT Id, CaseNumber, createddate from case where Case.RecordType.Name = 'Branding Request' and  createdDate < :dateTm ]);
   }
   List<Branding_Request__c> brlist = new List<Branding_Request__c>();
   List<Attachment> accattachments = new List<Attachment> ();
   List<ID> caseids = new List<ID>();
   List<ID> accids = new List<ID>();
   List<Attachment> todeleteattachments = new List<Attachment>();
   global void execute(Database.BatchableContext BC,List<SObject> clist ){
      for(SObject s : clist)
      {
         caseids.add(s.Id);
      } 
      brlist = [SELECT Id,Branding_Request__c,Shop_Name__c,Shop_Name__r.Name,Branding_Request__r.CaseNumber from Branding_Request__c where Branding_Request__c IN:caseids];
      for(Branding_Request__c br : brlist)
      {
         accids.add(br.Shop_Name__c);
      }
      accattachments = [SELECT ID,Name,ParentID FROM Attachment WHERE ParentID IN: accids];
      for(Branding_Request__c b :brlist ) 
      {
         for(Attachment accatt:accattachments)
         {
            if(accatt.Name.StartsWith(b.Branding_Request__r.CaseNumber+'-'+b.Shop_Name__r.Name)) {
               todeleteattachments.add(accatt); 
            }
         }
      }
      if(!todeleteattachments.IsEmpty())
      {
        delete todeleteattachments;
      } 
   }
   global void finish(Database.BatchableContext BC){}
}
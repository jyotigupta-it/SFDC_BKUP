public with sharing class NewPromotionMemberClass {
  
    public NewPromotionMemberClass (ApexPages.StandardController controller) {
    wrappers=new List<TaskWrapper>();
    for (Integer idx=0; idx<1; idx++)
    {
    wrappers.add(new TaskWrapper(nextIdent++));
    }

    }

    public List<TaskWrapper> wrappers {get; set;}
    public static Integer toDelIdent {get; set;}
    public static Integer addCount {get; set;}
    public id dId;
    private Integer nextIdent=0;

public void delWrapper()
    {
    Integer toDelPos=-1;
        for (Integer idx=0; idx<wrappers.size(); idx++)
        {
            if (wrappers[idx].ident==toDelIdent)
            {
            toDelPos=idx;
            }
        }
    
            if (-1!=toDelPos)
            {
            wrappers.remove(toDelPos);
            }
    }

    public void addRows()
    {
        for (Integer idx=0; idx<addCount; idx++)
        {
        wrappers.add(new TaskWrapper(nextIdent++));
        }
    }
    
    public PageReference save()
    {
        List<Promotion_Member__c> tsks=new List<Promotion_Member__c>();
        for (TaskWrapper wrap : wrappers)
            {
            tsks.add(wrap.tsk);
            }
        
            insert tsks;
            
            return new PageReference('/'+ ApexPages.currentPage().getParameters().get('id'));
        }

    public PageReference cancel()
    { 
            return new PageReference('/'+ ApexPages.currentPage().getParameters().get('id'));
    }
    
    public class TaskWrapper
    {
        public Promotion_Member__c tsk {get; private set;}
        public Integer ident {get; private set;}
        
        public TaskWrapper(Integer inIdent)
        {
            ident=inIdent;
            Promotion__c pm=[select Type__c,id from  Promotion__c where id=:ApexPages.currentPage().getParameters().get('id')];
            System.debug('Id: ' + ApexPages.currentPage().getParameters().get('id'));
            tsk=new Promotion_Member__c(Promotions2__c = ApexPages.currentPage().getParameters().get('id'),Type1__c=pm.Type__c);
        }
    }
}
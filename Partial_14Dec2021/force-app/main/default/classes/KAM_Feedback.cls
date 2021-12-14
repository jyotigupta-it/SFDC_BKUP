/********************************XXX********************************************************

Copyright © 2017 Ashirvad. All rights reserved.
Created By      : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 16-Feb-2017
Description     : Controller for KAM Feedback page  (For Key Account Managers Feedback)

**********************************XXX*******************************************************/

public class KAM_Feedback {
    
    public Id accId;
    public Account acc{get;set;}
    public Boolean showexisting{get;set;}
    public Boolean showKFM{get;set;}
    public KAM_Feedback__c Kf{get;set;}
    public List<KAM_Feedback_Master__c> kfb{get;set;} 
    public List<KAM_Feedback_Master__c> AllcheckedKFm{get;set;}   
    public List<KAM_Feedback__c> CreateKFBS{get;set;}
        
    public KAM_Feedback(ApexPages.StandardController controller){
        try
        {
            AllcheckedKFm=new List<KAM_Feedback_Master__c>();
            createKFBS = new List<KAM_Feedback__c>();
            accId = ApexPages.CurrentPage().getParameters().get('id');
            acc = [Select id,Name,State__c FROM Account WHERE id=:accId LIMIT 1];
            kfb = [SELECT id, Name, Active__c, Checkbox__c, Applicable_State__c FROM KAM_Feedback_Master__c WHERE  Applicable_State__c includes (:acc.State__c)
                    AND Active__c=True];
            kf = new KAM_Feedback__c();
            showKFM = False;
        }
        catch(Exception ex)
        {
            ApexPages.addMessages(ex);
        }
    }
    
    public PageReference Add()
    {
        try
        {
            if(kf.Status__c!='Feedback Given')
            {
                kf.Account__c = accId;
                insert kf;                
            }
        }
        catch(Exception ex2)
        {
            ApexPages.addMessages(ex2);
        }
        pageReference pr = new PageReference('/'+accId);
        pr.setRedirect(true);
        return pr;
    }
    
    public void Next()
    {
        try
        {
            List<KAM_Feedback_Master__c> temp=new List<KAM_Feedback_Master__c>();
            if(kf.Status__c=='Feedback Given'){
                for(KAM_Feedback_Master__c obj:kfb)
                {
                    if(obj.Checkbox__c==true){
                        temp.add(obj);
                    }                   
                } 
                if(temp.size()==1){
                    for(KAM_Feedback_Master__c kobj:temp){
                        showKFM = true;
                        System.debug('------>>> KFM Name'+ kobj.Name);
                        KAM_Feedback__c newKFB = new KAM_Feedback__c(Account__c=accid);
                        newKFB.Name = kobj.Name;
                        newKFB.KAM_Feedback_Master__c = kobj.id;
                        newkFB.Status__c = kf.Status__c;
                        newKFB.Call_Person_Name__c = kf.Call_Person_Name__c;
                        newKFB.status_Remarks__c = kf.status_Remarks__c;
                        newKFB.Date__c = kf.Date__c;
                        CreateKFBS.add(newKFB);
                        KAM_Feedback_Master__c checkedKFM = [Select id,Name,Active__c,Applicable_State__c,Remarks__c,Checkbox__c,
                                                            (Select id,Name,Display_order__c,Question__c,Answer__c,KAM_Feedback_Master__c
                                                            from KAM_Feedback_Master_Line_Items__r ORDER By Display_Order__c ASC)
                                                            FROM KAM_Feedback_Master__c WHERE id =:kobj.id];
                        System.Debug('@@@@@------->>>LinItemsSize'+checkedKFm.KAM_Feedback_Master_Line_Items__r.Size());
                        try{
                        AllcheckedKFm.add(checkedKFm);                
                        System.Debug('------->>>Size'+AllcheckedKFm.Size());
                        }
                        catch(exception ex3){
                          System.Debug('-the error is '+ex3.getMessage()+'at line number:'+ex3.getLineNumber());  
                        }
                    }
                    insert createKFBS;
                }
                else
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Select Any 1 Questionnaire'));
                }
            }
            if(kf.status__c!='FeedBack Given')
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Other Than "Feedback Given" Feedback Line Items shouldnot be created so  click on ADD button  to create Feedbacks Only'));                
            }
        }
        catch(Exception ex4)
        {
            ApexPages.addMessages(ex4);             
        }
    }    
    
    public PageReference saveAll()
    {
        try
        {
            Set<Id> KFB_Ids = new Set<Id>();
            Map<Id,KAM_Feedback__c> MapKFBs = new Map<Id,KAM_Feedback__c>();
            for(KAM_Feedback__c kobj2:CreateKFBS)
            {
                KFB_Ids.add(kobj2.id);
            }
            List<KAM_Feedback__c> AllKFBs = [SELECT id,Name,KAM_Feedback_Master__c FROM KAM_Feedback__c WHERE id IN: KFB_Ids];
            if(!AllKFBs.isEmpty())
            {
                for(KAM_Feedback__c kobj3:CreateKFBS)
                {
                    MapKFBs.put(kobj3.KAM_Feedback_Master__c, kobj3);
                }
            }
            List<KAM_Feedback_Line_Item__c> kfli = new List<KAM_Feedback_Line_Item__c>();
            for(KAM_Feedback_Master__c m:AllcheckedKfm)
            {
                for(KAM_Feedback_Master_Line_Item__c e:m.KAM_Feedback_Master_Line_Items__r)
                {
                    if(MapKFBs.get(e.KAM_Feedback_Master__c)!=null)
                    {
                        KAM_Feedback_Line_Item__c kfd = new KAM_Feedback_Line_Item__c();
                        kfd.KAM_Feedback__c = MapKFBS.get(e.KAM_Feedback_Master__c).Id;
                        kfd.Question__c=e.Question__c;
                        kfd.Answer__c=e.Answer__c;
                        kfd.Display_Order__c=e.Display_Order__c;
                        kfli.add(kfd);
                        System.Debug('#######Size'+kfli);
                    }
                }
                System.Debug('123#######Size'+kfli.Size());
            }
            insert kfli;
            pageReference pf=new PageReference('/'+accid);
            pf.SetRedirect(true);
            return pf;       
        }
        catch(Exception ex5)
        {
            ApexPages.addMessages(ex5);
        }
        return null;
    }
    
    
    public PageReference cancel()
    {
        pageReference pe=new PageReference('/'+accid);
        pe.setRedirect(true);
        return pe;
    }
}
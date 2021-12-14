public class feedback
{
public List<Feedback_Master__c> fb{get;set;}
public List<Feedback_Master__c> AllcheckedFm{get;set;}
public Boolean showexisting{get;set;}
public Boolean showFM{get;set;}
Public Feedback__c f{get;set;}
Public Feedback__c fo{get;set;}
Public Feedback__c fcc{get;set;}
Public List<Feedback__c> CreateFBS{get;set;}
Public Id aId;
Public Account a{get;set;}

public List<Feedback_Line_Item__c> li{get;set;}
       public feedback(ApexPages.StandardController controller) 
       {
       try
       {
       CreateFBS=new List<Feedback__c>();
                 aId=ApexPages.CurrentPage().getParameters().get('id');
                  a=[Select id,Name,State__c FROM Account WHERE id=:aid LIMIT 1];
                   AllcheckedFm= new List<Feedback_Master__c>();
                   
                   fb=[SELECT id,Name,Active__c,Checkbox__c,Applicable_State__c FROM Feedback_Master__c WHERE  Applicable_State__c includes (:a.State__c)
                    AND Active__c=True order by CreatedDate desc];
                   fo=new Feedback__c();   
                 f=new Feedback__c();    
                 showFM = False;
       }
       
       catch(Exception e)
       {
       }
       }
       
       public pageReference Add()
       {
       try
       {
       if(f.status__c!='Feedback Given')
       {
       f.Account__c=aId;
       insert f;
       }
       }
       catch(Exception e)
              {
       }
       pageReference p5=new pageReference('/'+aid);
       p5.setRedirect(true);
       return p5;
       
      
       }
       
     public Void Next()
    {
    try
        {
        List<Feedback_Master__c> dummy=new List<Feedback_Master__c >();
       
        if(f.Status__c=='Feedback Given')
        {
        for(Feedback_Master__c e:fb)
        {
            if(e.Checkbox__c==true)
         {
         dummy.add(e);
         }
        }
            if(dummy.size()==1)
         {
            for(Feedback_Master__c fb1:dummy)
            {
     
             showFM = True;
        
            System.Debug('------->>>FM Name'+fb1.Name);
            
                Feedback__c newFB = new Feedback__c(Account__c=aid);
                  newFB.Name=fb1.Name;
                  newFB.Feedback_Master__c=fb1.id;
                  newFB.Status__c=f.Status__c;
                  newFB.Call_Center_Person_Name__c=f.Call_Center_Person_Name__c;
                  newFB.Status_Remarks__c=f.Status_Remarks__c;
                  newFB.Date__c=f.Date__c;
                  
                CreateFBS.add(newFB);
                Feedback_Master__c checkedFm = [SELECT id,Name,Active__c,Applicable_State__c,Remarks__c,Checkbox__c,(SELECT id,Name,Display_Order__c,Question__c,Answer__c,Feedback_Master__c FROM Feedback_Master_Line_Items__r ORDER By Display_Order__c ASC) FROM Feedback_Master__c WHERE id =:fb1.id];
                
               System.Debug('@@@@@------->>>LinItemsSize'+checkedFm.Feedback_Master_Line_Items__r.Size());
                AllcheckedFm.add(checkedFm);
                
                
                System.Debug('------->>>Size'+AllcheckedFm.Size());
            }
            insert CreateFBS;
            
        }
        else
        {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Select Any 1 Questionnaire'));
        
        }
           
        }
        if(f.Status__c!='Feedback Given')
        {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Other Than "Feedback Given" Feedback Line Items shouldnot be created so  click on ADD button  to create Feedbacks Only'));
        
        }
        
        }
        
        catch(exception e)
        {
            ApexPages.addMessages(e);
        }
    
    }
     public PageReference Saveall()
    {
    try
        {
        Set<Id> FB_Ids = new Set<Id>();
        Map<Id,Feedback__c> MapFBs = new Map<Id,Feedback__c>();
        for(Feedback__c each:CreateFBS)
        {
            FB_Ids.add(each.id);
            each.Overall_Satisfaction__c=fo.Overall_Satisfaction__c;
            update each;
        }
        List<Feedback__c> AllFBs=[SELECT id,Name,Feedback_Master__c FROM Feedback__c WHERE id IN: FB_Ids];
       
        if(!AllFBs.isEmpty())
        {
        
            for(Feedback__c each1:CreateFBS)
            {
            
                MapFBs.put(each1.Feedback_Master__c,each1);
            }
        }
        List<Feedback_Line_Item__c> fmli =new List<Feedback_Line_Item__c>();
        
        for(Feedback_Master__c m:AllcheckedFm)
        {
         for(Feedback_Master_Line_Item__c e:m.Feedback_Master_Line_Items__r)
        {
            if(MapFBs.get(e.Feedback_Master__c)!=Null)
            {
                Feedback_Line_Item__c fd=new Feedback_Line_Item__c();
                fd.Feedback__c=MapFBs.get(e.Feedback_Master__c).Id;
                fd.Question__c=e.Question__c;
                fd.Answer__c=e.Answer__c;
                fd.Display_Order__c=e.Display_Order__c;
                fmli.add(fd);
                System.Debug('#######Size'+fmli);
            }
            
        }
        System.Debug('123#######Size'+fmli.Size());
        
        }
insert fmli;
pageReference p1=new PageReference('/'+aid);
    p1.SetRedirect(true);
    return p1;      
        }
        catch(exception e)
        {
            ApexPages.addMessages(e);
        }
        return null;
    }
    public pageReference Cancel()
    {
    pageReference p2=new PageReference('/'+aid);
    p2.setRedirect(true);
    return p2;
    }
   }
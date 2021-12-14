/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :29-Dec-2014
Modified Date   :
Version         :1.0
Description     :

********************XXX***********************************/
public class MassEditProjectTracker {
	
   	public String projectId {get;set;}
    
    public List<Project_Tracker__c> projectTrackerList{get;set;}
    
    public MassEditProjectTracker(){

    	projectId = ApexPages.currentPage().getParameters().get('ProjectId');
        projectTrackerList = new List<Project_Tracker__c>();
        projectTrackerList = [SELECT Opportunity__c,Question__c,Remarks__c,Response__c,Project_Order__c,Action_Plan__c,Action_Date__c FROM Project_Tracker__c WHERE Opportunity__c = :projectId ORDER By Project_Order__c Asc];
    }
    
    
     public PageReference updateProjectTracker(){
     	
        PageReference pf = new PageReference('/'+projectId);
        try{
        	update projectTrackerList;
            return pf;
        }
        catch(exception e){

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return null;

        }
    }
    
    
    public PageReference cancel(){

        PageReference pf = new PageReference('/'+projectId);
        return pf;
    }
}
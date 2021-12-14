/*****************************************************************************************************************************************
*Created By:  Subhajit Ghosh
*company:     KVP
*Description: Display the items to be approved in the Lightning home page. It displays the Project name instead of the Unique SPR 
name. This is a quick link to go the project. 
****************************************************************************************************************************************/
public class ItemsToApproveCustomControllerCls {
public List<uniqueProjectName> uniqueProjectNameList{get;set;}
public  List<Unique_SPR__c> uniqueSprList;
public List<Id> uniqueSprId;
public List<ProcessInstanceWorkItem> ProcessInstanceWorkItemList;
public Map<Id,String> mapProjectwithID;
public Map<Id,String> mapUserNamewithID;

public ItemsToApproveCustomControllerCls(){
    
    String currentLoggedUserId=UserInfo.getUserId();// logged in user id- 
    uniqueSprId=new List<Id>();
    uniqueSprList=new List<Unique_SPR__c>();
    mapProjectwithID=new Map<Id,String>();
    mapUserNamewithID=new Map<Id,String>();
    uniqueProjectNameList=new List<uniqueProjectName>();
    uniqueSprList=[SELECT id from Unique_SPR__c WHERE Approval_Status__c=:'Pending' AND Number_of_SPR_s__c>:0];//query the pending spr's from object
    if(uniqueSprList.size() > 0){
        for(Unique_SPR__c ids : uniqueSprList){
            uniqueSprId.add(ids.id); 
        }
    }
    //to get the list of uniqueSpr that are pending 
    ProcessInstanceWorkItemList=new List<ProcessInstanceWorkItem>(); 
    ProcessInstanceWorkItemList=[SELECT ProcessInstance.TargetObjectId FROM ProcessInstanceWorkItem 
                                WHERE ProcessInstance.Status = 'Pending' AND ActorId =: currentLoggedUserId
                                AND ProcessInstance.TargetObjectId IN: uniqueSprId order by createddate desc] ;
    system.debug('ProcessInstanceWorkItemList--'+ProcessInstanceWorkItemList);
    
    if(ProcessInstanceWorkItemList.size()>0){
        uniqueSprId.clear(); 
        uniqueSprList.clear();
        
        for(ProcessInstanceWorkItem pro:ProcessInstanceWorkItemList){
            uniqueSprId.add(pro.ProcessInstance.TargetObjectId);
        }
        
        uniqueSprList=[select id,Project__c,Project__r.Name,Project__r.Owner.Name FROM Unique_SPR__c where ID IN: uniqueSprId order by createddate desc]; 
        
        for(Unique_SPR__c un : uniqueSprList){
            if(!mapProjectwithID.containsKey(un.Project__c)){
                mapProjectwithID.put(un.Project__c,un.Project__r.Name);
            } 
            if(!mapUserNamewithID.containsKey(un.Project__c)){
                mapUserNamewithID.put(un.Project__c,un.Project__r.Owner.Name);
            } 
            
        }
        
        if(mapProjectwithID.size()>0){
            for (Id ids : mapProjectwithID.keySet()){
                uniqueProjectName unInstance=new uniqueProjectName();
                unInstance.ProjectName=mapProjectwithID.get(ids);
                unInstance.recordId=ids;
                unInstance.submittedBy=mapUserNamewithID.get(ids);
                uniqueProjectNameList.add(unInstance);
            }  
            
        }
        
        
        
    }
    
    
}


public class uniqueProjectName{
    public Id recordId{get;set;}
    public String ProjectName{get;set;}
    public String submittedBy{get;set;}
}


}
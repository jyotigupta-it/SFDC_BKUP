@RestResource(urlMapping='/getProjectDetails')
global with sharing class WS_Project_Details  {
    @HttpGet
    global static Response getProjDetails() {
        Response resObj = new Response();
        List<ProjectWrap> projWrapList = new List<ProjectWrap>();
        resObj.ProjectDetails = projWrapList;
        List<Opportunity> projList = new List<Opportunity>();
        
        projList = [SELECT Id,Standard_ORC__c,Project_Number__c,Name,Project_Type__c,Project_State__c,State_Auto_Populate__c,CloseDate,Number_of_towers__c,No_of_Floors__c,No_of_Bathrooms__c,Number_of_kitchens__c,
                    (SELECT Id,Unique_Name__c,Average_Discount_Provided__c FROM Unique_SPRs__r)
                    FROM Opportunity];
        for(Opportunity oppObj : projList){
            List<SPRWrap> sprDetails = new List<SPRWrap>();
            ProjectWrap projWrapObj = new ProjectWrap();                         
            projWrapObj.projNumber = oppObj.Project_Number__c != null ? oppObj.Project_Number__c : '';
            projWrapObj.projType = oppObj.Project_Type__c != null ? oppObj.Project_Type__c : '';
            projWrapObj.projName = oppObj.Name;
            projWrapObj.projState = oppObj.State_Auto_Populate__c != null ? oppObj.State_Auto_Populate__c : '';
            projWrapObj.projCloseDate = oppObj.CloseDate != null ? oppObj.CloseDate.format() : '';
            projWrapObj.projNoOfTowers = oppObj.Number_of_towers__c != null ? oppObj.Number_of_towers__c : 0;
            projWrapObj.projNoOfFloors = oppObj.No_of_Floors__c != null ? oppObj.No_of_Floors__c : 0;
            projWrapObj.projNoOfBathrooms = oppObj.No_of_Bathrooms__c != null ? oppObj.No_of_Bathrooms__c : 0;
            projWrapObj.projNoOfKitchens = oppObj.Number_of_kitchens__c != null ? oppObj.Number_of_kitchens__c : 0;
            for(Unique_SPR__c uqSPR : oppObj.Unique_SPRs__r){
                SPRWrap sprDet = new SPRWrap();
                sprDet.distributorCode = '';//TBD
                sprDet.sprNumber = uqSPR.Unique_Name__c != null ? uqSPR.Unique_Name__c : '';
                sprDet.projNumber = oppObj.Project_Number__c != null ? oppObj.Project_Number__c : '';
                sprDet.projCode = '';//TBD
                sprDet.projGroupCode = '';//TBD
                sprDet.ProjGroupDesc = '';//TBD
                sprDet.projCatCode = '';//TBD
                sprDet.projCatDesc = '';//TBD
                sprDet.stdDiscount = 0;//TBD_1
                sprDet.sprDiscount = uqSPR.Average_Discount_Provided__c != null ? uqSPR.Average_Discount_Provided__c : 0;
                sprDet.orcPercentage = oppObj.Standard_ORC__c != null ? oppObj.Standard_ORC__c : 0;
                sprDet.validity = '';//TBD_1
                sprDetails.add(sprDet);
            }
            //projWrapObj.sprDetails = sprDetails;
            projWrapList.add(projWrapObj);
        }
        RETURN resObj;
    }
    global class Response{
        List<ProjectWrap> ProjectDetails = new List<ProjectWrap>();
    }
    global class ProjectWrap{
        String projNumber;
        String projType;
        String projName;
        String projState;
        String projCloseDate;
        Decimal projNoOfTowers;
        Decimal projNoOfFloors;
        Decimal projNoOfBathrooms;
        Decimal projNoOfKitchens;
        //List<SPRWrap> sprDetails;
    }
    global class SPRWrap{
        String distributorCode;
        String sprNumber;
        String projNumber;
        String projCode;
        String projGroupCode;
        String ProjGroupDesc;
        String projCatCode;
        String projCatDesc;
        Decimal stdDiscount;
        Decimal sprDiscount;
        Decimal orcPercentage;
        String validity;
    }
}
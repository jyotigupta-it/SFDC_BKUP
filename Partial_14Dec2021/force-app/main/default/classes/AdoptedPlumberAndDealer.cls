/***********************************************************************************************************************
Created By: Rakesh Mallya
Created Date: 18/05/2018
Description: This trigger handler class calculates Adopted Plumber Actuals and Adopted Dealer Actuals.
***********************************************************************************************************************/
public class AdoptedPlumberAndDealer{
    public static void AdoptedDealerAndPlumberMethod(List<AP_Site_Visit__c> SVtrigger){
        String partyNameDlr;
        List<ID> TgrDlrIdList = new List<ID>();
        Set<ID> TgtDlrIdSet = new Set<ID>();
        ID acntRcrdTyp;
        ID stVstRcrdTyp;
        Boolean AdptDlrChkbx = false;
        Boolean AdptPbrChkbx = false;
        List<Target__c> tgtList = new List<Target__c>();
        List<AP_Site_Visit__c> dlrCnt = new List<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> pbrCnt = new List<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> StVstList = new List<AP_Site_Visit__c>();
        List<AP_Site_Visit__c> StVstListToUpdt = new List<AP_Site_Visit__c>();
        for(AP_Site_Visit__c  apsv : SVtrigger){
            TgrDlrIdList.add(apsv.ID);
            TgtDlrIdSet.add(apsv.Target__c);            
        }
        StVstList.addAll([SELECT ID,Adopted_Dealer__c,Adopted_Plumber__c,RecordTypeID,Party_Name__c,Party_Name__r.RecordTypeID,Party_Name__r.Classification__c,Target__c,Party_RcrdType_Name__c,RecordType_Name__c,Party_Name__r.Party_Type__c,Party_Name__r.Premium_plumber__c FROM AP_Site_Visit__c WHERE Target__c IN: TgtDlrIdSet AND ID IN: TgrDlrIdList]);
        for(AP_Site_Visit__c dlrSV : StVstList){
            if(dlrSV.RecordType_Name__c == 'Visits' && dlrSV.Party_Name__c != NULL && dlrSV.Party_RcrdType_Name__c == 'Dealer' && dlrSV.Party_Name__r.Classification__c == 'Adopted'){
                dlrSV.Adopted_Dealer__c = true;
                StVstListToUpdt.add(dlrSV);
            }else if(dlrSV.RecordType_Name__c == 'Visits' && dlrSV.Party_Name__c != NULL && dlrSV.Party_RcrdType_Name__c == 'Individual Contacts' && dlrSV.Party_Name__r.Party_Type__c == 'Plumber' && dlrSV.Party_Name__r.Premium_plumber__c == 'Yes'){
                dlrSV.Adopted_Plumber__c = true;
                StVstListToUpdt.add(dlrSV);
            }
            system.debug('---------------------------dlrSV.RecordType_Name__c------------'+dlrSV.RecordType_Name__c);
            system.debug('---------------------------dlrSV.Party_Name__c------------'+dlrSV.Party_Name__c);
            system.debug('---------------------------dlrSV.Party_RcrdType_Name__c------------'+dlrSV.Party_RcrdType_Name__c);
            system.debug('---------------------------dlrSV.Party_Name__r.Classification__c------------'+dlrSV.Party_Name__r.Classification__c);    
        }
        
        update StVstListToUpdt;
        
        dlrCnt.addall([SELECT ID FROM AP_Site_Visit__c WHERE Target__c IN: TgtDlrIdSet AND Adopted_Dealer__c = true]);
        pbrCnt.addall([SELECT ID FROM AP_Site_Visit__c WHERE Target__c IN: TgtDlrIdSet AND Adopted_Plumber__c = true]);
        if(dlrCnt.size() > 0 || pbrCnt.size() > 0){
            for(Target__c tar : [SELECT ID,Adopted_Dealer_Actual_Count__c,Adopted_Plumber_Actual_Count__c FROM Target__c WHERE ID IN: TgtDlrIdSet]){
                tar.Adopted_Dealer_Actual_Count__c = dlrCnt.size();
                tar.Adopted_Plumber_Actual_Count__c = pbrCnt.size();
                tgtList.add(tar);
            }
        }
        system.debug('---------------------------tgtList------------'+tgtList);
        system.debug('---------------------------dlrCnt.size()------------'+dlrCnt.size()); 
        update tgtList;      
    }//end of AdoptedDealerAndPlumberMethod   
}//end of AdoptedPlumberAndDealsver
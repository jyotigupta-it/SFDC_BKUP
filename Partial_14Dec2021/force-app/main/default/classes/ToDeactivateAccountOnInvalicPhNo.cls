/*********************************************************************************************************************************
Name: ToDeactivateAccountOnInvalicPhNo
Description: To populate respective values in fields, which depends on Call Status.
Created By: Rakesh Mallya(KVP Business Solutions Pvt. Ltd.)
Created Date: 25/07/2018  
*********************************************************************************************************************************/
public class ToDeactivateAccountOnInvalicPhNo{
    public static void ValueAssigningMethod(List<Promotion_Member__c> proMembList){       
        for(Promotion_Member__c pro : proMembList){
            if(pro.Call_Status__c == 'Wrong/Invalid Number'){
                pro.Call_Center_Remarks__c = 'Phone number is Wrong/Invalid';
                pro.Complaints__c = 'Wrong/Invalid Number';               
            }else if(pro.Call_Status__c == 'Person not available'){
                pro.Call_Center_Remarks__c = 'Required person is not available';              
            }else if(pro.Call_Status__c == 'Busy'){
                pro.Call_Center_Remarks__c = 'Person is busy';              
            }else if(pro.Call_Status__c == 'RNR'){
                pro.Call_Center_Remarks__c = 'Ring Not Response';              
            }else if(pro.Call_Status__c == 'Not Reachable'){
                pro.Call_Center_Remarks__c = 'Not Reachable';               
            }
        } 
    }//end of DeactivatingMethod
    
    public static void InactivatingAccountMethod(List<Promotion_Member__c> proMembList){
        List<Account> accList = new List<Account>(); 
        List<Promotion_Member__c> proList = new List<Promotion_Member__c>(); 
        Set<ID> accIDSet = new Set<ID>();
        for(Promotion_Member__c pro : proMembList){
            if(pro.Call_Status__c == 'Wrong/Invalid Number'){
                accIDSet.add(pro.Account__c); 
            }
        }   
        accList = [SELECT ID,Inactive_Mobile_No__c FROM Account WHERE ID IN: accIDSet]; 
        for(Account acc : accList){
            acc.Inactive_Mobile_No__c = True;
            acc.Preference__c = '';
            acc.Status__c = 'Prospective';
        }
        update accList;
    }//end of InactivatingAccountMethod  
    
}//end of class
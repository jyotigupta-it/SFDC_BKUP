/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:test class for upload of branding images.
 ****************************************************************************************/ 
@isTest
private class ctrlMultiSelectPicklist_UT{
    static testMethod void testctrlMultiSelectPicklist() {
        ctrlMultiSelectPicklist c = new ctrlMultiSelectPicklist();
        
        c.leftOptions = new List<SelectOption>();
        c.rightOptions = new List<SelectOption>();
        
        Account []m= new LIST <Account>{
            new Account (name='material1',Contact_Number_Mobile__c='7156784489'),
            new Account (name='material2',Contact_Number_Mobile__c='7156784489'),
            new Account (name='material3',Contact_Number_Mobile__c='7156784489'),
            new Account (name='material4',Contact_Number_Mobile__c='7156784489'),
            new Account (name='material5',Contact_Number_Mobile__c='7156784489')
            }; 
        insert m; 
        c.leftOptionsHidden='';    
        for(Integer i=0;i<m.size();i++){
            if(i<(m.size()-1)){
            c.leftOptionsHidden +=m[i].name+'&';
            c.leftOptionsHidden +=m[i].name+'&';}
            else{
            c.leftOptionsHidden +=m[i].name+'&';
            c.leftOptionsHidden +=m[i].name;
           }
        }
        c.rightOptionsHidden = '';
    }
}
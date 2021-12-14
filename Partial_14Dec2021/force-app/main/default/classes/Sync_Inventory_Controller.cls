/*  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * File Name  : Sync_Inventory_Controller
 * Description: Batch Apex for syncing values of opening and closing stock for object 'inventory'.
 * Author     : Renjay Surendran
 * Modification Log 
 * ===================================================================== 
 * Ver   Date        Author                         Modification 
 * ---------------------------------------------------------------------
 * 1.0   16-Jul-2015   Renjay Surendran            Initial Code 
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/ 
global class Sync_Inventory_Controller implements Database.Batchable<sObject>{

    global String query ='select ID, Name, Closing_Stocks__c, opening_stock__c, Dispatch_Size__c, Owner_Account__c, Threshold__c, Used_Stock__c from inventory__c';

    global  database.QueryLocator start(Database.BatchableContext BC)
    {
        // Initiate the Batch context
       return Database.getQueryLocator(query);
       //return null;      
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
       execbatch((list<inventory__c>) scope);
    }
    
    public void execbatch(list<inventory__c> inventList)
    {             
        for(inventory__c val : inventList)
        {
           val.opening_stock__c=val.Closing_Stocks__c;  
        }        
        
        List<Database.SaveResult> uResults = Database.update(inventList,false);
        
        for(Database.SaveResult ResList: uResults)
        {
                if (ResList.isSuccess()) 
                {
                System.debug('Successfully Upserted Record: ' + ResList.getId());
                }
                else
                {
                    for(Database.Error err : ResList.getErrors())
                    {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Record fields that affected this error: ' + err.getFields());
                    }
                }
        }

    }   
    global void finish(Database.BatchableContext BC)
    {
       
    }     
    
}
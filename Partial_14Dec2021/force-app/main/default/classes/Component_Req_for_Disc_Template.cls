Public Class Component_Req_for_Disc_Template
{
    Public Id ThisAccId{get;set;}
    Public Account Acc;
    
    Public Account getCurrentAcc()
    {
        String FiedNames = '';
        List<String> objFields = new List<String>();
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
             Schema.DescribeSObjectResult ob = Account.sObjectType.getDescribe();
             Map<String , Schema.SObjectField> mapFieldList = ob.fields.getMap();  

             for(Schema.SObjectField field : mapFieldList.values())  
             {  
                Schema.DescribeFieldResult fieldResult = field.getDescribe();  
                if(fieldResult.isAccessible())  
                {  
                    objFields.add(fieldResult.getName());
                    FiedNames+= field +',';
                }  
             }
             if(FiedNames.endsWith(','))
             {
                FiedNames= FiedNames.removeEnd(',');
             }
        String query = 'SELECT '+FiedNames+' FROM Account WHERE Id=\''+ThisAccId+'\'';
        Account A = DataBase.Query(query);
        return A;
    }
    
    Public List<Order__c> getLineItems()
    {
        String FiedNames = '';
        List<String> objFields = new List<String>();
        Acc = [SELECT Id,Name FROM Account 
               WHERE Id =: ThisAccId];
        
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
             Schema.DescribeSObjectResult ob = Order__c.sObjectType.getDescribe();
             Map<String , Schema.SObjectField> mapFieldList = ob.fields.getMap();  

             for(Schema.SObjectField field : mapFieldList.values())  
             {  
                Schema.DescribeFieldResult fieldResult = field.getDescribe();  
                if(fieldResult.isAccessible())  
                {  
                    objFields.add(fieldResult.getName());
                    FiedNames+= field +',';
                }  
             }
             if(FiedNames.endsWith(','))
             {
                FiedNames= FiedNames.removeEnd(',');
             }
        
        List<Order__c > AllOrders = new List<Order__c >();
        String query = 'SELECT '+FiedNames+' FROM Order__c WHERE Projects__c =\''+ThisAccId+'\'';
        
        for(Order__c each2 : DataBase.Query(query))
        {
            AllOrders.add(each2);
        }
        return AllOrders;
    }
}
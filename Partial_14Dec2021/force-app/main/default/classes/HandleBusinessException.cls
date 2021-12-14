/* 
* Name      : HandleBusinessException
* Purpose   : This class is used to capture exception occured while apex code execution.
* Company   : DGenX Technologies
* Author    : Dushyant
* Note		: This class/method should not be used if try/catch is inside a loop, as insert in not bulkyfied in insertError method.
*/
public class HandleBusinessException extends Exception {
    
    public static void captureError(String className, String methodName, Exception ex){
        Exception_Log__c errorLogObj = createError(className, methodName, ex);
        insertError(errorLogObj);          
    }
    
    private static Exception_Log__c createError(String className, String methodName, Exception ex){
        Exception_Log__c errorLogObj 		= new Exception_Log__c();
        errorLogObj.Class_Name__c 			= className;
        errorLogObj.Method_Name__c 			= methodName;
        errorLogObj.Exception_Message__c 	= ex.getMessage();
        errorLogObj.Exception_Stack_Trace__c		= ex.getStackTraceString();
        errorLogObj.Exception_Line_Number__c			= ex.getLineNumber();
        errorLogObj.Exception_Type__c		= ex.getTypeName();
        return errorLogObj;
    }
    
    private static void insertError(Exception_Log__c errorLogObj){
        try{
            Database.insert(errorLogObj, false);
        }
        catch(DMLException dmlError){}
    }
}
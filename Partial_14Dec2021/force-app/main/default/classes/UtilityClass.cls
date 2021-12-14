public class UtilityClass {

    public static Map<String,String> getMapOfObjectApiNameAndLabel(){
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();    
        Map<String,String> objName = new Map<String,String>();
        for(Schema.SObjectType f : gd)
        {
            
                objName.put(f.getDescribe().getName(), f.getDescribe().getLabel());
     
        }
        return objName;
    }
    public static String getQueryString(String objectName){
        Map<String, Schema.SObjectType> objMap = new Map<String, Schema.SObjectType>();
        objMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = objMap.get(objectName).getDescribe().fields.getMap();
        string queryString = 'SELECT ';
        for(Schema.SObjectField field :fieldMap.values()){
            queryString = queryString + field.getDescribe().getName() + ', ';
        }
        queryString = queryString.substring(0,queryString.length() - 2);
        return queryString;
    }
    public static String getContactNumber(String ContactNumber){
        System.debug('ContactNumber'+ContactNumber);
        
        if(ContactNumber!=null && ContactNumber.length()==10){
            String number1='+91';
           ContactNumber=number1+ContactNumber ;
            System.debug('ContactNumber'+ContactNumber);
        }
        return ContactNumber;
    }
}
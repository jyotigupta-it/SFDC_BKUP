public class CheckGST_SAP_Request {
    
    public RequestClass REQUEST;
    
    public class RequestClass {
        public String TAXNUMXL;
    }
    
    public static CheckGST_SAP_Request parse(String json) {
        return (CheckGST_SAP_Request) System.JSON.deserialize(json,CheckGST_SAP_Request.class);
    }
}
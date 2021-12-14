public class SMS {


    public class w{
        
    public String id;
        
    public String customid;
        
    public String customid1;
    
    public String customid2;

    public String mobile;
    
    public String status;
    }

    
    public String status;

    public Data data;
    
    public String message;

    
    public class Data {
        
    public Long group_id;
        
    public w w;
    }

    

    public static SMS parse(String json) {
        
    return (SMS)
    System.JSON.deserialize(json, SMS.class);
    }
    }
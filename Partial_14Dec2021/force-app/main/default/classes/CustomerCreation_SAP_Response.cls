public class CustomerCreation_SAP_Response {
    public MT_CustomrMaster_Response MT_CustomrMaster_Response;

	public class MT_CustomrMaster_Response {
		public RESPONSE RESPONSE;
	}

	public class RESPONSE {
		public Integer STATUS_CODE;
		public String STATUS_MSG;
		public String CREATION_NUM;
	}

	
	public static CustomerCreation_SAP_Response parse(String json) {
		return (CustomerCreation_SAP_Response) System.JSON.deserialize(json, CustomerCreation_SAP_Response.class);
	}
}
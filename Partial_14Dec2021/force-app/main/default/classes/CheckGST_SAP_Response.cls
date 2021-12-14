public class CheckGST_SAP_Response {
    
    public  MT_GSTValidation_Response_Class MT_GSTValidation_Response;

    public class MT_GSTValidation_Response_Class {
		public RESPONSE_Class RESPONSE;
	}

    public class RESPONSE_Class {
		public Integer STATUS_MSG;
		public String PARTNER_ROLE;
		public String CREATION_GRO;
		public String CREATION_NUM;
		public String TITLE_MEDI;
		public String NAME_ORG1;
		public String SORT1_TXT;
		public String STREET;
		public String STR_SUPPL1;
		public String CITY2;
		public String POST_CODE1;
		public String CITY1;
		public String COUNTRY;
		public Integer REGION;
		public String LANGU;
		public String MOB_NUMBER;
		public String TEL_NUMBER;
		public String SMTP_ADDR;
		public String VALID_FROM;
		public Integer VALID_TO;
		public String TAXTYPE;
		public String TAXNUMXL;
		public String BUKRS;
		public String KNB1_AKONT;
		public String J_1IPANNO;
		public List<Data> data;
	}

	public class Data {
		public String VKORG;
		public Integer VTWEG;
		public Integer SPART;
		public String BZIRK;
		public Integer VKBUR;
		public String VKGRP;
		public Integer DYNP_AWAHR;
		public String KLABC;
		public String KNVV_WAERS;
		public Integer KALKS;
		public String LPRIO;
		public String VSBED;
		public String INCO1;
		public String INCO2_L;
		public String ZTERM;
		public String KKBER;
		public String KNVV_KTGRD;
	}

	public static CheckGST_SAP_Response parse(String json) {
		return (CheckGST_SAP_Response) System.JSON.deserialize(json, CheckGST_SAP_Response.class);
	}
}
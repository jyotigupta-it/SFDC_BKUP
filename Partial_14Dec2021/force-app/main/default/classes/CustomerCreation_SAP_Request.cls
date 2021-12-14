public class CustomerCreation_SAP_Request {

    public  Request_Class CustomerCreation_SAP;

    public class Request_Class {
		public String PARTNER_ROLE;
		public String CREATION_GRO;
		public String TITLE_MEDI;
		public String NAME_ORG1;
		public String NAME_ORG2;
		public String SORT1_TXT;
		public String SORT2_TXT;
		public String UNW_REMARK;
		public String STREET;
		public String STR_SUPPL1;
		public String STR_SUPPL2;
		public String STR_SUPPL3;
		public String LOCATION;
		public String CITY2;
		public String POST_CODE1;
		public String CITY1;
		public String COUNTRY;
		public String REGION;
		public String LANGU;
		public String TEL_NUMBER;
		public String MOB_NUMBER;
		public String SMTP_ADDR;
		public String VALID_FROM;
		public String VALID_TO;
		public String LOCATION_3;
		public String TAXTYPE;
		public String TAXNUMXL;
		public String BUKRS;
		public String KNB1_AKONT;
		public String J_1IPANNO;
		public List<Data> data;
	}

	public class Data {
		public String VKORG;
		public String VTWEG;
		public String SPART;
		public String BZIRK;
		public String KDGRP;
		public String VKBUR;
		public String VKGRP;
		public String DYNP_AWAHR;
		public String KLABC;
		public String KNVV_WAERS;
		public String KURST;
		public String KONDA;
		public String KALKS;
		public String LPRIO;
		public String VWERK;
		public String VSBED;
		public String INCO1;
		public String INCO2_L;
		public String ZTERM;
		public String KKBER;
		public String KNVV_KTGRD;
		public String TC_TAXKD;
		public String TEST_TCS;
		public String KVGR4;
		public String KVGR5;
	}

	public static CustomerCreation_SAP_Request parse(String json) {
		return (CustomerCreation_SAP_Request) System.JSON.deserialize(json, CustomerCreation_SAP_Request.class);
	}
}
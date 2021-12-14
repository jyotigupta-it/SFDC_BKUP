public class GSTINValidatorParser {
    public String status {get;set;} 
    public String business {get;set;} 
    public Integer status_code {get;set;} 
    public String trade_name {get;set;} // in json: trade-name
    public String registration_date {get;set;} // in json: registration-date
    public String entity_type {get;set;} // in json: entity-type
    public String gstin {get;set;} 
    public String legal_name {get;set;} // in json: legal-name
    public Adress adress {get;set;} 
    public String pan {get;set;} 
    public String dealer_type {get;set;} // in json: dealer-type
    public String error {get;set;}
    
    public GSTINValidatorParser(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'status') {
                        status = parser.getText();
                    } else if (text == 'business') {
                        business = parser.getText();
                    } else if (text == 'status_code') {
                        status_code = parser.getIntegerValue();
                    } else if (text == 'trade-name') {
                        trade_name = parser.getText();
                    } else if (text == 'registration-date') {
                        registration_date = parser.getText();
                    } else if (text == 'entity-type') {
                        entity_type = parser.getText();
                    } else if (text == 'gstin') {
                        gstin = parser.getText();
                    } else if (text == 'legal-name') {
                        legal_name = parser.getText();
                    } else if (text == 'adress') {
                        adress = new Adress(parser);
                    } else if (text == 'pan') {
                        pan = parser.getText();
                    } else if (text == 'dealer-type') {
                        dealer_type = parser.getText();
                    } else if (text == 'error') {
                        error = parser.getText();
                    } else {
                        System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
                    }
                }
            }
        }
    }
    
    public class Adress {
        public String lg {get;set;} 
        public String bname {get;set;} 
        public String street {get;set;} 
        public String bno {get;set;} 
        public String location {get;set;} 
        public String lt {get;set;} 
        public String floor {get;set;} 
        public String city {get;set;} 
        public String state {get;set;} 
        public String pincode {get;set;} 
        
        public Adress(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'lg') {
                            lg = parser.getText();
                        } else if (text == 'bname') {
                            bname = parser.getText();
                        } else if (text == 'street') {
                            street = parser.getText();
                        } else if (text == 'bno') {
                            bno = parser.getText();
                        } else if (text == 'location') {
                            location = parser.getText();
                        } else if (text == 'lt') {
                            lt = parser.getText();
                        } else if (text == 'floor') {
                            floor = parser.getText();
                        } else if (text == 'city') {
                            city = parser.getText();
                        } else if (text == 'state') {
                            state = parser.getText();
                        } else if (text == 'pincode') {
                            pincode = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Adress consuming unrecognized property: '+text);
                        }
                    }
                }
            }
        }
    }
    
    
    public static GSTINValidatorParser parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new GSTINValidatorParser(parser);
    }

}
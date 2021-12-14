public with sharing class QRCodeScannerController {
    
    public Double currentLongitude 	{get; set;}
    public Double currentLatitude  	{get; set;}
    public Boolean isOutOfRange    	{get; private set;}
    public Account accountRecordMain{get; set;}
    public String message {get; set;}
    private static Decimal currentRange;
    private static Decimal specifiedRange = 30;
    
    /** Contructor **/
    public QRCodeScannerController(ApexPages.StandardController controller) {
        this.isOutOfRange = false;
        if(!Test.isRunningTest()) {
            controller.addFields(new List<String>{'Geolocation__Latitude__s', 'Geolocation__Longitude__s', 'Party_Type__c', 'QR_Code__c'});  
        }
        this.accountRecordMain = (Account)controller.getRecord();
    }
    
    /**
    * @Method       : calculateAccountRange
    * @Invoke       : From VF Page.
    * @Description  : After getting current geo location from the VF, calculate the distance
    *                 between the Account location and Current user location. If distance is with
    *                 in the specified range allow QR scanning, else show message.
    * @Return       : PageReference
    * @Params       : N/A
    **/
    public PageReference calculateAccountRange() {
        this.isOutOfRange = calculateRange(currentLongitude, currentLatitude);
        return null;
    }
    
    /**
    * @Method       : calculateRange
    * @Invoke       : From calculateRange method.
    * @Description  : After getting curent geo location from the VF, calculate the distance
    *                 between the Account location and Current user location. If distance is with
    *                 in the specified range allow QR scanning, else show message.
    * @Return       : Boolean isOutOfRange
    * @Params       : double currentLongitude, double currentLatitude
    **/
    public Boolean calculateRange(double currentLongitude, double currentLatitude) {
        Boolean isOutOfRange = false;
        Location accountLocation, currentLocation;
        currentRange = null;
		this.message = '';     
        try{
            if(accountRecordMain != null){
                Account accountRecord = [SELECT Id, Geolocation__Latitude__s, Geolocation__Longitude__s
                                         FROM Account WHERE Id =: accountRecordMain.Id];
                if(accountRecord.Geolocation__Latitude__s == null){
                    return isOutOfRange;
                }
                
                accountLocation = Location.newInstance(accountRecord.Geolocation__Latitude__s,
                                                       accountRecord.Geolocation__Longitude__s);
            }
            
            currentLocation = Location.newInstance(currentLatitude, currentLongitude);
            Double locationDifference = Location.getDistance(accountLocation, currentLocation, 'km');
            
            System.debug('======currentLatitude===='+currentLatitude);
            System.debug('======currentLongitude===='+currentLongitude);
            System.debug('======currentLocation===='+currentLocation);
            System.debug('======accountLocation===='+accountLocation);
            System.debug('======locationDifference===='+locationDifference);
            
            if(locationDifference != null){
                currentRange = (locationDifference*1000).round();
                if(currentRange > specifiedRange){
                    isOutOfRange = true;
                }
            }
        }catch(Exception E){
            message = E.getMessage();
            System.debug('Error:'+E);
        }
        return isOutOfRange;
    }
    
    /**
    * @Method       : saveQRCode
    * @Invoke       : From VF page.
    * @Description  : Update the QR code passed from VF page
    * @Return       : PageReference
    * @Params       : N/A
    **/
    public PageReference saveQRCode(){
        this.message = '';
        this.isOutOfRange = false;
        try{
            update accountRecordMain;
            return (new ApexPages.StandardController (new Account(Id = accountRecordMain.Id))).view();
        }catch(Exception E){
            message = E.getMessage();
            System.debug('Error:'+E);
        }
        return null;
    }
    
}
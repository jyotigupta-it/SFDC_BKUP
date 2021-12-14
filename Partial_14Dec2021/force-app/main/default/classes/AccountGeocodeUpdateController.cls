/*********************************************************************************      
* Name: AccountGeocodeUpdateController
* Description: Class for handling Account geo location operations (update) 
* Created By: Ashim Kumar Sahoo
* Created Date: 20/08/2018 
*
**********************************************************************************/
public with sharing class AccountGeocodeUpdateController {
      
    public Account acct{get;set;}
    public Id accountId;
    
    /*
    * AccountGeocodeUpdateController: Constructor method for initialiing object
    * @Returns: NULL
    * @Arguments: ApexPages.StandardController controller                 
    */
    public AccountGeocodeUpdateController(ApexPages.StandardController controller) {
        
        acct = (Account) controller.getRecord();
        accountId = ApexPages.currentPage().getParameters().get('id');
        system.debug('Account::'+acct);
    }
    
    /*
    * updateAccountGeoDetails: This method updates account geo location details based on the account ID received
    * @Returns: Boolean
    * @Arguments: 
    *               √ Id acctId: Account ID
    *               √ String geoDetails: JSON string containing geo location details             
    */
    @RemoteAction
    public static Boolean updateAccountGeoDetails(Id acctId, String geoDetails) {
        system.debug('The mallya is:'+geoDetails);
        Map<String, String> geoDetailMap = (Map<String, String>)System.JSON.deserialize(geoDetails, Map<String, String>.class);
        system.debug('geoDetailMap:'+geoDetailMap);

        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :acctId];
        if(accounts.size() > 0) {
            
            accounts[0].Geolocation__Latitude__s = Decimal.valueOf(geoDetailMap.get('LATITUDE'));
            accounts[0].Geolocation__Longitude__s = Decimal.valueOf(geoDetailMap.get('LONGITUDE'));
            accounts[0].BillingStreet = geoDetailMap.get('STREET');
            accounts[0].BillingCity = geoDetailMap.get('CITY');
            accounts[0].BillingState = geoDetailMap.get('STATE');
            accounts[0].BillingCountry = geoDetailMap.get('COUNTRY');
            accounts[0].BillingPostalCode = geoDetailMap.get('POSTAL_CODE');
            update accounts;
            
            return true;
        }
        return false;        
    }
}
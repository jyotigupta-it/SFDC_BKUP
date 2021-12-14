/* 
* Name      : PlumberClaimPageController
* Purpose   : This class is used as controller for PlumberClaimPage page and component.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public without sharing class PlumberClaimPageController {
    public Boolean formFlag_1{ get; set;}
    public Boolean formFlag_2{ get; set;}
    public Boolean formFlag_3{ get; set;}
    String plumberId{ get; set;}
    String sessionId{ get; set;}
    public Boolean checkActiveSession{ get; set;}
    public String selectedScheme {set;get;}
    public String selectedCapacity{set;get;}
    public List<String> schemeList{set;get;}
    public List<String> capacityList{set;get;}
    public String dealerName {set;get;}
    public String pinCode {set;get;}
    public String cityName {set;get;}
    public Date purchaseDate {set;get;}
    public Integer quantity {set;get;}
    public Decimal billAmount {set;get;}
    public String billBody{get;set;}
    public String billName{get;set;}
    public List<String> qrCodeList{get;set;}
    public String qrCodeScanned{ get; set;}
    public List<String> repeatValue{ get; set;}
    public Boolean inputValidateFlag{ get; set;}
    public String inputValidateMessage{ get; set;}
    public Boolean claimCheckFlag{ get; set;}
    public String claimId{ get; set;}
    public Boolean successFlag{ get; set;}
    public String errorMessage{ get; set;}
    public Integer qrCodeScannedCount {set;get;}
    public List<String> capListFetched{get;set;}
    public Integer rowCountCapacity {set;get;}
    public Attachment attachment {
        get {
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    public PlumberClaimPageController(){
        checkActiveSession = true;
        formFlag_1 = true;
        formFlag_2 = false;
        formFlag_3 = false;
        inputValidateFlag = false;
        successFlag = false;
        plumberId = System.currentPageReference().getParameters().get('pId');//plumberId=0012100000u8sFmAAI
        sessionId = System.currentPageReference().getParameters().get('sId');
        List<MessagingSession> sessionList = new List<MessagingSession>();
        List<Sales_scheme__c> schemeListFetched = new List<Sales_scheme__c>();
        schemeList = new List<String>();
        qrCodeList = new List<String>();
        capListFetched = new List<String>();
        capacityList = new List<String>{'--Select Capacity--','500L','700L','1000L','1500L','2000L'};
            sessionList = [SELECT Id,Status,Claim_Page_Access_Time__c FROM MessagingSession WHERE Id =:sessionId];
        if(sessionList.size() > 0){
            if(sessionList[0].Status != 'Ended'){
                if(sessionList[0].Claim_Page_Access_Time__c != null)
                    checkActiveSession = false;
            }
            else
                checkActiveSession = false;
        }
        else
            checkActiveSession = false;
        //To Remove
        //checkActiveSession = true;
        
        
        schemeListFetched = [SELECT Id,Name FROM Sales_scheme__c WHERE Name = 'Plumber Special – Silver Dhamaka'];
        for(Sales_scheme__c schemeObj : schemeListFetched){
            schemeList.add(schemeObj.Name);   
        }
    }
    public PageReference next_1(){
        System.debug(dealerName);
        System.debug(pinCode);
        System.debug(cityName);
        System.debug(plumberId);
        System.debug(sessionId);
        formFlag_1 = false;
        formFlag_2 = true;
        formFlag_3 = false;
        inputValidateMessage = '';
        repeatValue = new List<String>();
        for(Integer i = 1;i<=quantity;i++){
            repeatValue.add(String.valueOf(i));
        }
        if(pinCode == null || pinCode == '')
            inputValidateMessage += 'Pin code,';
        if(cityName == null || cityName == '')
            inputValidateMessage += 'City Name,';
        if(purchaseDate == null)
            inputValidateMessage += 'Date Of Purchase,';
        if(quantity == null || quantity == 0)
            inputValidateMessage += 'Quantity,';
        if(billAmount == null || billAmount == 0)
            inputValidateMessage += 'Bill Amount,';
        inputValidateMessage = inputValidateMessage.removeEnd(',');
        if(inputValidateMessage == '')
            inputValidateFlag = false;
        else{
            inputValidateMessage = 'Please Fill: '+inputValidateMessage;
            inputValidateFlag = true;
            formFlag_1 = true;
            formFlag_2 = false;
            //To Remove
            //inputValidateFlag = false;
        }
        
        RETURN null;
    }
    public PageReference prev_2(){
        formFlag_1 = true;
        formFlag_2 = false;
        formFlag_3 = false;
        RETURN null;
    }
    public PageReference next_2(){
        formFlag_1 = false;
        formFlag_2 = false;
        formFlag_3 = true;
        qrCodeList = new List<String>();
        capListFetched = new List<String>();
        RETURN null;
    }
    public PageReference prev_3(){
        formFlag_1 = false;
        formFlag_2 = true;
        formFlag_3 = false;
        RETURN null;
    }
    public PageReference saveClaim(){
        successFlag = false;
        claimCheckFlag = false;
        List<Claim_Line_Item__c> cliCheckListList = new List<Claim_Line_Item__c>();
        List<Warranty_Master__c> warrantyMasterList = new List<Warranty_Master__c>();
        List<String> qrCodeCheckList = new List<String>();
        for(String qrObj : qrCodeList){
            if(qrObj != '')
                qrCodeCheckList.add(qrObj.trim());
        }
        System.debug(qrCodeCheckList);
        if(qrCodeCheckList.size() == quantity){
            cliCheckListList = [SELECT Id FROM Claim_Line_Item__c WHERE QR_Code_Reference_Number__c IN :qrCodeCheckList];
            warrantyMasterList = [SELECT Id,Serial_Number__c,Product_Code__c FROM Warranty_Master__c WHERE Serial_Number__c IN:qrCodeCheckList];
            if(cliCheckListList.size() > 0){
                claimCheckFlag = true;
                errorMessage = 'Scanned QR code(s) is/are already being claimed!';
            }
            else if(warrantyMasterList.size() == 0 || warrantyMasterList.size() != qrCodeCheckList.size()){
                claimCheckFlag = true;
                errorMessage = 'Scanned QR code(s) is/are Invalid!';
            }
            else{
                List<Account> accList = new List<Account>();
                List<Plumber_Scheme_Relation__c> plumberSchemeJuncList = new List<Plumber_Scheme_Relation__c>();
                List<Plumber_Scheme_Relation__c> plumberSchemeJuncUpdateList = new List<Plumber_Scheme_Relation__c>();
                List<Claim__c> claimList = new List<Claim__c>();
                Attachment attObj = new Attachment();
                List<String> prodCodeList = new List<String>();
                List<Product2> prodList = new List<Product2>();
                Map<String,Id> prodCodeIdMap = new Map<String,Id>();
                Map<String,String> warrentyMasterMap = new Map<String,String>();
                List<Claim_Line_Item__c> cliList = new List<Claim_Line_Item__c>();
                String schemeName = 'Plumber Special – Silver Dhamaka';
                if(plumberId != null && plumberId != '')
                    accList = [SELECT Id,Total_Purchased_Capacity__c FROM Account WHERE Id =:plumberId];
                plumberSchemeJuncList = [SELECT Id,Scheme__r.Point_per_product__c FROM Plumber_Scheme_Relation__c WHERE Plumber__c =:plumberId AND Scheme__r.Name =:schemeName ORDER BY CreatedDate DESC];
                Claim__c claimObj = new Claim__c();
                if(plumberSchemeJuncList.size() > 0)
                    claimObj.Plumber_Scheme__c = plumberSchemeJuncList[0].Id;
                claimObj.Dealer_Name__c = dealerName;
                claimObj.Purchase_Date__c = purchaseDate;
                claimObj.Quantity__c = quantity;
                claimObj.Bill_Amount__c = billAmount;
                claimObj.City_Name__c = cityName;
                claimObj.Pin_Code__c =pinCode;
                claimObj.Capacity__c = getCapacitySum(capListFetched);
                claimList.add(claimObj);
                if(claimList.size() > 0){
                    INSERT claimList;
                    for(Warranty_Master__c wmObj : warrantyMasterList){
                        if(wmObj.Product_Code__c != null)
                            prodCodeList.add(wmObj.Product_Code__c);
                        warrentyMasterMap.put(wmObj.Serial_Number__c,wmObj.Product_Code__c);
                    }
                    prodList = [SELECT Id,ProductCode FROM Product2 WHERE ProductCode IN :prodCodeList];
                    for(Product2 prodObj : prodList){
                        prodCodeIdMap.put(prodObj.ProductCode,prodObj.Id);
                    }
                    for(Integer i=1; i<=quantity; i++){
                        Claim_Line_Item__c cliObj = new Claim_Line_Item__c();
                        cliObj.Claim__c = claimList[0].Id;
                        cliObj.QR_Code_Reference_Number__c = qrCodeList[i-1];
                        cliObj.Capacity__c = capListFetched[i-1];
                        if(warrentyMasterMap.get(qrCodeList[i-1]) != null && prodCodeIdMap.get(warrentyMasterMap.get(qrCodeList[i-1])) != null)
                            cliObj.Product__c = prodCodeIdMap.get(warrentyMasterMap.get(qrCodeList[i-1]));
                        cliList.add(cliObj);
                    }
                    attObj.parentId = claimList[0].Id;
                    attObj.Name = billName;
                    attObj.Body = Blob.valueOf(billBody);
                    attObj.Description = 'Claim_Bill_WhatsApp_BOT';
                    INSERT attObj;
                }
                if(cliList.size() > 0)
                    INSERT cliList;
                plumberSchemeJuncUpdateList = [SELECT id,Capacity__c,(SELECT Id,Capacity__c FROM Claims__r) FROM Plumber_Scheme_Relation__c WHERE Plumber__c =:plumberId AND Scheme__r.Name =:schemeName];
                List<String> capPSList = new List<String>();
                for(Plumber_Scheme_Relation__c plumberSchemeJuncObj : plumberSchemeJuncUpdateList){
                    capPSList = new List<String>();
                    for(Claim__c claimObj_1 : plumberSchemeJuncObj.Claims__r){
                        if(claimObj_1.Capacity__c != null && claimObj_1.Capacity__c != '')
                            capPSList.add(claimObj_1.Capacity__c);
                    }
                    if(capPSList.size() > 0)
                        plumberSchemeJuncObj.Capacity__c = getCapacitySum(capPSList);
                }
                UPDATE plumberSchemeJuncUpdateList;
                if(sessionId != null && sessionId != '')
                    UPDATE new MessagingSession(Id = sessionId,Claim_Registered__c = System.now(),Claim_Page_Access_Time__c = System.now());
                if(accList.size() > 0 && capPSList.size() > 0){
                    if(accList[0].Total_Purchased_Capacity__c != null)
                        capPSList.add(accList[0].Total_Purchased_Capacity__c);
                    accList[0].Total_Purchased_Capacity__c = getCapacitySum(capPSList);
                    //accList[0].Remaining_Purchased_Capacity__c = accList[0].Total_Purchased_Capacity__c;
                    UPDATE accList;
                }
                successFlag = true;
                claimId = claimList[0].Name;
            }
        }
        else{
            claimCheckFlag = true;
            errorMessage = 'Please upload all QR codes!';
        }
        RETURN null;
    }
    public List<SelectOption> getSchemes(){
        List<SelectOption> optns = new List<Selectoption>();
        for(String schemeName : schemeList){
            optns.add(new selectOption(schemeName,schemeName));   
        }
        RETURN optns;
    }
    public List<SelectOption> getCapacity(){
        List<SelectOption> optns = new List<Selectoption>();
        for(String capObj : capacityList){
            optns.add(new selectOption(capObj,capObj));   
        }
        RETURN optns;
    }
    public void saveQRCode(){
        if(qrCodeList.size() == 0){
            for(Integer i = 1;i<=quantity;i++){
                qrCodeList.add('');
            }
        }
        qrCodeList.set(qrCodeScannedCount-1,qrCodeScanned);
    }
    public void saveCapacty(){
        if(capListFetched.size() == 0){
            for(Integer i = 1;i<=quantity;i++){
                capListFetched.add('');
            }
        }
        capListFetched.set(rowCountCapacity-1,selectedCapacity);
    }
    public PageReference navigateToWhatsApp(){
        PageReference pg = new PageReference('https://api.whatsapp.com/send?phone='+System.Label.WhatsApp_number);
        RETURN pg.setRedirect(true);
    }
    public String getCapacitySum(List<String> capValueList){
        String totalCapText = '';
        Decimal totalCapDecimal = 0;
        for(String capValue : capValueList){
            if(capValue != null && capValue != '')
                totalCapDecimal += Decimal.valueOf(capValue.removeEnd('L'));
        }
        totalCapText = totalCapDecimal+'L';
        RETURN totalCapText;
    }
    public void fetchCityName(){
        System.debug(pinCode);
        List<Pincode__c> pinCodeList = [SELECT Id,City__c,City__r.Name FROM Pincode__c WHERE Name =:pinCode];
        if(pinCodeList.size() > 0 && pinCodeList[0].City__c != null){
            cityName = pinCodeList[0].City__r.Name;
        }
        else
            cityName = 'City not Found';
    }
}
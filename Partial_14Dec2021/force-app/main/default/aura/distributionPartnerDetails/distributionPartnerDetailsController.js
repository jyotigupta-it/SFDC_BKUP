({
    AddNewRow : function(component, event, helper){
       // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").setParams({
           "whichPartner":'distributionPartnerDetails'
       }).fire();     
    },
    
    removeRow : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("DeleteRowEvt").setParams({
           "indexVar" : component.get("v.rowIndex"),
           "whichPartner":'distributionPartnerDetails'
       }).fire();
    }, 
    eventInpValidation : function(component, event){
        debugger;
        var isValidate = true;
        
        //var districtInp = component.find('District__c');
        //var districtVal= component.find('District__c').get('v.value');
        
        var DealersInp = component.find('No_of_Dealers__c');
        var DealersVal= component.find('No_of_Dealers__c').get('v.value');
        
        /*if($A.util.isUndefinedOrNull(districtVal) || $A.util.isUndefined(districtVal) || $A.util.isEmpty(districtVal)){
            districtInp.setCustomValidity("District field is required");
            isValidate = false;
        }else{
            districtInp.setCustomValidity("");
        } 
        districtInp.reportValidity(); */
        
        if($A.util.isUndefinedOrNull(DealersVal) || $A.util.isUndefined(DealersVal) || $A.util.isEmpty(DealersVal)){
            DealersInp.setCustomValidity("No of Dealers field is required");
            isValidate = false;
        }else{
            DealersInp.setCustomValidity("");
        }
        DealersInp.reportValidity(); 

        if(isValidate==false){
            component.getEvent("returnFormValidation").setParams({
                "hasError":true
            }).fire();     
        }else{
            component.getEvent("returnFormValidation").setParams({
                "hasError":false
            }).fire();
        }
    },
    
    eventInpValidationHide : function(component, event){
        var el = component.find('No_of_Dealers__c');
        $A.util.removeClass(el, "slds-has-error"); // remove red border
        $A.util.addClass(el, "hide-error-message"); // hide error message
        el.setCustomValidity("");
        el.reportValidity(); 
    }
    
})
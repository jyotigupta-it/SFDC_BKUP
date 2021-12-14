({
    AddNewRow : function(component, event, helper){
        // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").setParams({
            "whichPartner":'projectPartnerDetails'
        }).fire();     
    },
    
    removeRow : function(component, event, helper){
        // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
        component.getEvent("DeleteRowEvt").setParams({
            "indexVar" : component.get("v.rowIndex"),
            "whichPartner":'projectPartnerDetails'
        }).fire();
    }, 
    
    eventInpValidation : function(component, event){
        debugger;
        var isValidate = true;
        
        // var allValid = component.find('validfield').reduce(function (validSoFar, inputCmp) {
        //     inputCmp.reportValidity();
        //     return validSoFar && inputCmp.checkValidity();
        // }, true);

        var NameOfProjectInt = component.find('Name_of_the_Project_Handled__c');
        var NameOfProjectVal= component.find('Name_of_the_Project_Handled__c').get('v.value');

        if($A.util.isUndefinedOrNull(NameOfProjectVal) || $A.util.isUndefined(NameOfProjectVal) || $A.util.isEmpty(NameOfProjectVal)){
            NameOfProjectInt.setCustomValidity("No of Dealers field is required");
            isValidate = false;
        }else{
            NameOfProjectInt.setCustomValidity("");
        }
        NameOfProjectInt.reportValidity(); 

        var ValueInt = component.find('Value__c');
        var ValueVal= component.find('Value__c').get('v.value');

        if($A.util.isUndefinedOrNull(ValueVal) || $A.util.isUndefined(ValueVal) || $A.util.isEmpty(ValueVal)){
            ValueInt.setCustomValidity("No of Dealers field is required");
            isValidate = false;
        }else{
            ValueInt.setCustomValidity("");
        }
        ValueInt.reportValidity(); 

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
        var NameOfProjectInt = component.find('Name_of_the_Project_Handled__c');
        $A.util.removeClass(NameOfProjectInt, "slds-has-error"); // remove red border
        $A.util.addClass(NameOfProjectInt, "hide-error-message"); // hide error message
        NameOfProjectInt.setCustomValidity("");
        NameOfProjectInt.reportValidity(); 

        var ValueInt = component.find('Value__c');
        $A.util.removeClass(ValueInt, "slds-has-error"); // remove red border
        $A.util.addClass(ValueInt, "hide-error-message"); // hide error message
        ValueInt.setCustomValidity("");
        ValueInt.reportValidity(); 
    }
    
})
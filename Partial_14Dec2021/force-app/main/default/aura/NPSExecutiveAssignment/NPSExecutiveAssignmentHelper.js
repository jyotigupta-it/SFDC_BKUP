({
	showMessage : function(msg, msgtype, display_mode, duration){
        
        if(!duration) {            
            duration = 5000;
        }
        //display_mode: dismissible, pester, sticky 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            message: msg,
            messageTemplate: msg,
            duration:duration,
            key: 'info_alt',
            type: msgtype,
            mode: display_mode
        });
        toastEvent.fire();
    },

    npsValidation : function(component, event, helper){
        // call apex method which will create NPS records
        var action = component.get('c.createNPSRecords');
        action.setParams({'recordTypeName' : component.get('v.selectPartyType'), 'executiveName' : component.get('v.selectedExecutiveName'), 'selectedAccount' : JSON.stringify(component.get('v.selectedAccountChild'))});
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                console.log('success **** ');
                helper.showMessage('NPS Record Created', 'success', 'dismissible', 5000);
            } else if(response.getState() == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        console.log('errorMessage saveAssignment: ' + errorMessage);
                        if(errorMessage.includes("first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, ")) {
                            errorMessage = errorMessage.substring(errorMessage.indexOf("N,") + 2, errorMessage.lastIndexOf(": ["));
                            console.log('coming in saveAssignment: ' + errorMessage);
                        }
                        helper.showMessage(errorMessage, 'error', 'pester', 5000);
                        return false;
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})
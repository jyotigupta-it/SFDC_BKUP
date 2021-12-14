({
	doInit : function(component, event, helper) {
		console.log('namecon is 1 ' + component.get("v.selectPartyType"));
        console.log('namecon is 2 ' + component.get("v.selectedAccountChild"));
        // fetch Executive name
        var action = component.get("c.getExecutiveNameList");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var executiveName = response.getReturnValue();
                component.set("v.executiveName", executiveName);
                console.log('executiveName **** ' + JSON.stringify(executiveName));
            }else if(response.getState() == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        console.log('errorMessage doInit 123 ' + errorMessage);
                        helper.showMessage(errorMessage, 'error', 'pester', 5000);
                        return false;
                    }
                } else {
                    console.log("Unknown error doInit 456");
                }
            }
        });
        $A.enqueueAction(action);
	},
    
    saveAssignment : function(component, event, helper) {
        // null check for executive value
        var executiveName = component.get('v.selectedExecutiveName');
        var noneAttribute = component.get("v.noneAttribute");

        console.log('executiveName 123 ' + executiveName); 
        if(executiveName == noneAttribute || executiveName == null || executiveName == undefined || executiveName == '') {
            helper.showMessage('Please Select Executive', 'warning', 'dismissible', 5000);
            return false;
        }
        
        // validation logic : for 1 particular day 1 NPS can not be tagged to more than one Account.
        let mapData = {};
        var action = component.get('c.npsAssignmentValidation');
        action.setParams({'selectedAccount' : JSON.stringify(component.get('v.selectedAccountChild'))});
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                mapData = response.getReturnValue()
                console.log('success in npsValidation**** ' + JSON.stringify(mapData));
                for (const key in mapData) {
                    if (mapData.hasOwnProperty(key)) {
                        console.log('element 456 ' + mapData[key]);
                        if (mapData[key] >= 1) {
                            let userName = key.substring(key.indexOf('@') + 1);
                            helper.showMessage('You have already tagged NPS for ' + userName + '.', 'warning', 'dismissible', 5000);
                            return;
                        }
                    }
                }

                // call helper method which will call apex method to create NPS records
                helper.npsValidation(component, event, helper);
                
            } else if(response.getState() == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        
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
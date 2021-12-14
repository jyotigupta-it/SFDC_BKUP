({
    //This helper method is to execute server call and validates GSTIN.
    doInit: function(component, event, helper) {
        component.set("v.showSpinner", true);
        var action = component.get("c.validateGSTIN");
        action.setParams({ recordId :  component.get("v.recordId")});
        action.setCallback(this, function(response) {
            component.set("v.showSpinner", false);
            var state = response.getState();
            if (state === "SUCCESS"){ 
                component.set("v.successMessage", $A.get("$Label.c.GSTIN_Success"));
                $A.get('e.force:refreshView').fire();
            }
            else if (state === "INCOMPLETE") {
                component.set("v.errorMessage", $A.get("$Label.c.GSTIN_Server_Error"));
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                var message = $A.get("$Label.c.GSTIN_Unknown_Error");
                var controllermessage = '';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    for (var i = 0; i < errors.length; i++) {
                        controllermessage = controllermessage +' Error '+ (i+1) + ' : ' + errors[i].message;
                    }
                }
                if(!$A.util.isEmpty(controllermessage)){
                    message = controllermessage;
                }
                component.set("v.errorMessage", message);
            }
        });
        $A.enqueueAction(action);
    },
    //This helper method is to close the modal.
    cancelModel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
        component.destroy();
    },

});
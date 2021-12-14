({
    showToast : function(component, event, helper, title, toastMessage, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title" : title,
            "message" : toastMessage,
            "type" : type
        });
        toastEvent.fire();
    }
})
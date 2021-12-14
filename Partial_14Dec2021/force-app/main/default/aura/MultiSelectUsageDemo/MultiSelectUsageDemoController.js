({
    /*	doInit : function(component, event, helper) {
        const options=[{'Id':1,'Name':'Jaipur'},
                       {'Id':2,'Name':'Pune'},
                       {'Id':3,'Name':'Delhi'},];
        component.set("v.options", options);
	}, */
    
    doInit : function(component,event,helper) {
        helper.getMeetingTypeMonth(component,event);
        
        var action = component.get("c.fetchAccounts");
        action.setParams({ 
            "recordId" :component.get("v.recordId"), 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();	
                component.set('v.options',result);
            }else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
})
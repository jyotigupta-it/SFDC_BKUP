({
	getServiceCharges : function(component) {
		var action = component.get("c.getServiceCharges");
        action.setCallback(this, function(response){
            console.log('1');
            if(response.getState() == "SUCCESS"){
                console.log('2');
                console.log('test:',response.getReturnValue());
                component.set("v.serviceChargeList",response.getReturnValue());
            }else{
            	alert('Something went wrong. Please contact your system administrator');
            }
        });
        $A.enqueueAction(action);
	},
    // function automatic called by aura:waiting event  
    showSpinner: function(component) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
    }
})
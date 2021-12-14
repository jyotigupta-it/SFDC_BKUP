({
		
	doInit : function(component,event,helper) {
        $A.get('e.force:refreshView').fire();
        var evt = $A.get("e.force:navigateToComponent");     
        evt.setParams({         
            componentDef : "c:PreSigned",         
            componentAttributes: {
            	recordId : component.get("v.recordId") 
            } 
            });
        evt.fire();
       
    },
})
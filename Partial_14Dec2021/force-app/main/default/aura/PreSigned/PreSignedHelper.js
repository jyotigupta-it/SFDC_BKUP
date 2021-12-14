({
	getSignedURL : function(component,event,billImage) {
        console.log('### Reached in helper of presignedcontroller');
        var action = component.get("c.getSignedURL");
        action.setParams({ 
            "file" :billImage, 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();	
                console.log('### Result URL: ',result);
                window.open(result,"_blank");
                history.back();
                
            }else{
                var errors = response.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                   var message = errors[0].message;
                   console.log('Errors: ',message);
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
	}
})
({
	doInit : function(component, event, helper) {
        console.log('### Reached in doinit of presignedcontroller');
   
        var billImage;
        var action = component.get("c.fetchBillImage");
        action.setParams({ 
            "recordId" :component.get("v.recordId"), 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                billImage = response.getReturnValue();	
                console.log('#### billImage: ',billImage);
                component.set('v.billImage',billImage);
                 if(billImage != null){
         		   helper.getSignedURL(component,event,billImage);
                 }else{
                     alert('Bill image file not found !');
                     history.back();
                 }
            }else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
        
       
	}
})
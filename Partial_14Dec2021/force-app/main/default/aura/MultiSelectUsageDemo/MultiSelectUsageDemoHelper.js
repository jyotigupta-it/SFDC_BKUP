({
    getMeetingTypeMonth : function(component,event) {
        console.log('@@@ Reached here in getData');
        var action = component.get("c.fetchMeetingTypeMonth");
        action.setParams({ 
            "recordId" :component.get("v.recordId"), 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();	
                var typeMonth = result.split(":");
                var meetingType = typeMonth[0];
                var month = typeMonth[1];
                component.set('v.meetingType',meetingType);
                component.set('v.month',month);
            }else{
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
        
    }
})
/******************************************
 * Created By  : Ajeet Singh Shekhawat
 * Created On  : 03 Sep 2018
 * Modified By : 
 * Modified On : 03 Sep 2018
 * Description : 
				
******************************************/ 

({
	promotionHelper : function(component, event, helper) {
        
        var promotionId;
        var action = component.get("c.fetchPromotionRecord");         
		promotionId = component.get("v.recordId");
        // set current record Id in parameters
        action.setParams({'accountId' : component.get("v.recordId")});

        action.setCallback(this,function(response) {

            var state = response.getState();
            var difference;
            difference = response.getReturnValue();
			
            // if difference between today date and date field is greater than 150 days then show error else ridirect to given url
            if(difference >= 150){

                component.set("v.message", "Error : Promotion Members Entry has to be made within 15 days from the date of promotion activity conducted.");
                component.set("v.msgcolor","red");
                
            } else {
                component.set("v.message", "Info : Redirecting.......");
                component.set("v.msgcolor","green");
                window.location.href = 'https://c.na1.visual.force.com/apex/searchMobileNumber?id='+promotionId;	
            }
        });       
        $A.enqueueAction(action);	
	}
})
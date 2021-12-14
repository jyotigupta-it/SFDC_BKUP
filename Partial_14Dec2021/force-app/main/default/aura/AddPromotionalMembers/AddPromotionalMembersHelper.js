/******************************************
 * Created By  : Sudha M
 * Created On  : 04 Sep 2018
 * Modified By : 
 * Modified On : 04 Sep 2018
 * Description : Lightning component creation for replacing Js button
				
******************************************/ 
({
	addpromotionhelper : function(component, event, helper) {
	var promotionId;
        var action = component.get("c.addmember");         
		promotionId = component.get("v.recordId");
        action.setParams({'PromotionId' : component.get("v.recordId")});

        action.setCallback(this,function(response) {

            var promoID=[];
            var differnce,type;
            promoID = response.getReturnValue();
            //alert('test1    '+promoID);
			differnce = promoID[0];
            type= promoID[1];
            
            if(differnce >= 15){
               console.log('Promotion Members Entry has to be made within 15 days from the date of promotion activity conducted'); 
               component.set("v.message", "Error : Promotion Members Entry has to be made within 15 days from the date of promotion activity conducted");
               component.set("v.msgcolor","red");
              /*  var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: 'Error :\n\n Promotion Members Entry has to be made within 15 days from the date of promotion activity conducted',
                    messageTemplate: 'Error :\n\n Promotion Members Entry has to be made within 15 days from the date of promotion activity conducted',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();*/
              
            }
            else if(type=='Group Activity'){
                     console.log('Members cannot be added to'+type); 
                     component.set("v.message", "Error : Members cannot be added to "+type);
                     component.set("v.msgcolor","red");
                 /*var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: 'Error :\n\n Members cannot be added to'+type,
                    messageTemplate: 'Error :\n\n Members cannot be added to'+type,
                    key: 'info_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();*/
            }
            else {
                  console.log('URL-');
                  component.set("v.message", "Info : Redirecting to APPL_ADD_MEMBERS_DETAIL_PAGE");
                  component.set("v.msgcolor","green");
                  window.location.href = '/apex/APPL_ADD_MEMBERS_DETAIL_PAGE?id='+promotionId,'_self';	
            }
        });       
        $A.enqueueAction(action);	
	}
})
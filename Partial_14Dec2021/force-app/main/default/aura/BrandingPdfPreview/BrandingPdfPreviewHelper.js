/******************************************
 * Created By  : Sudha M
 * Created On  : 04 Sep 2018
 * Modified By : 
 * Modified On : 04 Sep 2018
 * Description :   
				
******************************************/ 
({
	Pdfhelper: function(component, event, helper) {
	 var PromotionId = component.get("v.recordId");
      
   		var deviceType = $A.get("$Browser.formFactor");
        console.log('You need  ' + deviceType); 
        var action = component.get("c.promotionrec");         
		//promotionId = component.get("v.recordId");
        action.setParams({'accountId' : component.get("v.recordId")});

        action.setCallback(this,function(response) {

            var state = response.getState();
            var percent;
            percent = response.getReturnValue();//return list of values
             //if difference is more than 70% then go to PDF VF page else throw error mesage
            if(percent>70){
                console.log('URL-');
                component.set("v.message", "Info : Redirecting to New Promotion PDF Page.");
                component.set("v.msgcolor","green");
                if(deviceType == 'DESKTOP') {
                    window.location.href ='/apex/New_Promotion_PDF?id='+PromotionId;
                } else {
                    window.location.href ='/apex/New_Promotion_PDF_Mobile?id='+PromotionId;
                }
               // window.location.href ='/apex/New_Promotion_PDF?id='+PromotionId;
       
                     
            } else {
                     console.log('You need more than 70% of Attendees'); 
                     component.set("v.message", "Error : You need more than 70% of Attendees");
                     component.set("v.msgcolor","red");
                 /*var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    message: 'Error :\n\n You need more than 70% of Attendees',
                    messageTemplate: 'Error :\n\n You need more than 70% of Attendees',duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();*/
            }
        });       
        $A.enqueueAction(action);	

	}
})
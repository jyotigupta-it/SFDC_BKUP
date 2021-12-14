/******************************************
 * Created By  : Sudha M
 * Created On  : 03 Sep 2018
 * Modified By : 
 * Modified On : 03 Sep 2018
 * Description : Lightning component for action button to redirect to Branding Request 
				
******************************************/ 
({
	helperMethod : function(component, event, helper) {
	 var accountId = component.get("v.recordId");
         console.log('URL-');
         component.set("v.message", "Info : Redirecting to Create Branding Request Page.");
         component.set("v.msgcolor","green");
         window.location.href = '/apex/BrandingCreation?id='+accountId;	
	}
})
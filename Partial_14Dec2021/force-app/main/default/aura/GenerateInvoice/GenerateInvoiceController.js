({
	init : function(component, event, helper) {
		helper.getServiceCharges(component);
	},
    makeTrue : function(component, event, helper){
      	var myName = event.getSource().get("v.name");
        console.log('Event.'+myName);
		var scList = component.get("v.serviceChargeList");
        
        for(var i=0 ;i<scList.length;i++){
            if(scList[i].id == myName){
                if(scList[i].check){
                    scList[i].check = false;
                }else{
                	scList[i].check = true;
                }
                break;
            }
        }
        component.set("v.serviceChargeList",scList);
    },
    selectAll : function(component, event, helper){
        var scList = component.get("v.serviceChargeList");
        for(var i=0 ;i<scList.length;i++){
            scList[i].check = true;
        }
        component.set("v.serviceChargeList",scList);
    },
    clearList : function(component, event, helper){
        var scList = component.get("v.serviceChargeList");
        var newList = [];
        for(var i=0 ;i<scList.length;i++){
            if(scList[i].check){
                scList[i].check = false;
            }
            newList.push(scList[i]);
        }
        component.set("v.serviceChargeList", newList);
        component.set("v.selectedList",null);
    },
    handleSelected : function(component, event, helper){
        var scList = component.get("v.serviceChargeList");
        var newList = [];
        for(var i=0 ;i<scList.length;i++){
            if(scList[i].check){
                newList.push(scList[i].sc.Id);
            }
        }
        console.log('scList : ',newList);
        if( newList.length < 1){
            //component.set('v.ifNotSelected',true);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'No records Selected',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        } else{
            helper.showSpinner(component);
            console.log('newList: '+newList);
            console.log('newList size: '+newList.length);
        	component.set("v.selectedList",newList);
            component.set("v.showSCList",false);
            component.set("v.showInvoice",true);
            //Create Dynamic Component
        
            $A.createComponent(
            "c:LCMP_CreateInvoice",
            {
                "listofServiceChargesids": newList
                
            },
            function(invoiceComponent, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(invoiceComponent);
                    component.set("v.body", body);
                    helper.hideSpinner(component);
                    console.log('component created 2');
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.");
                    helper.hideSpinner(component);
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    helper.hideSpinner(component);
                    // Show error message
                }
            }
        );
            
        }
    }
})
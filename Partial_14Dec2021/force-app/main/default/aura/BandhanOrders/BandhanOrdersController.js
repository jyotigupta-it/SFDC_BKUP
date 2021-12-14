({
	doInit : function(component, event, helper) {
      
	   var accountId = component.get("v.recordId");
       //alert('--id--'+accountId);
       
       
        var action = component.get("c.getBandhanOrdRec");         
        // set current record Id in parameters
        action.setParams({'recordId' : accountId});
        action.setCallback(this,function(response) {
            var state= response.getState();
            if (state === "SUCCESS") {
                var result;
                var cuscall;
                var records;
                var msgcolor;
                result = response.getReturnValue();
                cuscall = result['ORDERS'];
                records = result['ACCOUNT'][0];
                //alert('sucess-'+result['ACCOUNT'][0].Name+'='+cuscall.length);
                
                var today = new Date(); 
                var mnth = today.getMonth()+1; 
                var yr = today.getFullYear();
                var sz = cuscall.length;
                if(cuscall!="" && sz>0){ 
                    var dty = Math.trunc(cuscall[0].Year_of_CreatedDate__c); 
                    var dtm = Math.trunc(cuscall[0].Month_of_CreatedDate__c); 
                    var cstatus = cuscall[sz-1].Cart_Status__c; 
                }else{ 
                    var dty = 0; 
                    var dtm = 0; 
                    var cstatus = ''; 
                } 
                if(dty == yr && dtm == mnth &&(cstatus == 'Order Given' || cstatus == 'No order given' || cstatus == 'Not dealing with ashirvad')){ 
                    console.log('Feedback Exists-'+cstatus);
                    
                    component.set("v.message", "Error : Feedback already collected for the current month.");
                    component.set("v.msgcolor","red");
                    /*var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            message: 'Error : Feedback already collected for the current month.',
                            messageTemplate: 'Error : Feedback already collected for the current month.',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'error',
                            mode: 'sticky'
                        });
                        toastEvent.fire();*/
                    
                }else{ 
                    var db = result['ACCOUNT'][0].Parent.Status__c; 
                    if(db == 'Existing'){ 
                        console.log('URL-');
                        component.set("v.message", "Info : Redirecting to Create Bandhan Order Page.");
                        component.set("v.msgcolor","green");
                        window.location.href = '/apex/Bandhan_Orders?pid='+accountId; 
                        
                    }else{ 
                        console.log('Please update existing distributor'); 
                        component.set("v.message", "Error : Please update existing distributor!!");
                        component.set("v.msgcolor","red");
                        /*var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            message: 'Error : Please update existing distributor!!',
                            messageTemplate: 'Error : Please update existing distributor!!',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'error',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();*/
                    } 
                } 
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
            
        }); 
        $A.enqueueAction(action);
                
	}
    
})
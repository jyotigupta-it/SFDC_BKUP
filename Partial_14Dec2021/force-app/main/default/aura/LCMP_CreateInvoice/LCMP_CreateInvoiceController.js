({
    doint: function(cmp, evt, helper) {
        //Debugger;
        console.log('new component');
        /*var myPageRef = cmp.get("v.pageReference");
        if(myPageRef!=undefined && myPageRef!=null){
            var accs = myPageRef.state.c__listofServiceChargesids;
            console.log('listofServiceChargesids',JSON.stringify(accs));
            cmp.set("v.listofServiceChargesids",accs);
        }        //split the account ids by comma and continue logic*/
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'Link'},
            {label: 'Status', fieldName: 'Status__c', type: 'text'},
            {label: 'Serice Charge Amount', fieldName: 'Service_Charge_Amount__c', type: 'currency', typeAttributes: { currencyCode: 'INR', maximumSignificantDigits: 5}}
        ]);
        
        var action=cmp.get("c.getsreciveCharges");
        //alert( cmp.get("v.listofServiceChargesids")[0])
        action.setParams({ 
            scids : JSON.stringify(cmp.get("v.listofServiceChargesids"))
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + JSON.stringify(response.getReturnValue()));
                cmp.set("v.listofServiceCharges",response.getReturnValue().sclist);
                cmp.set("v.totalamt",response.getReturnValue().total);
                cmp.set("v.Servicetotalamt",response.getReturnValue().totalserviceCharges);
                cmp.set("v.Fixesamt",response.getReturnValue().FixedCharges);
                cmp.set("v.accountid",response.getReturnValue().accountid);
                cmp.set("v.showcmp","True");
                console.log("from server 2");
            } else if (state === "INCOMPLETE") {
                alert("INCOMPLETE");
            } else if (state === "ERROR") {
            	var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleClick :  function(cmp, evt, helper) {
        /*var navService = cmp.find("navService");
        // Uses the pageReference definition in the init handler
        var pageReference = {    
            "type": "standard__objectPage",
            "attributes": {
                "objectApiName": "Service_Charge__c",
                "actionName": "list"
            },
            "state": {
                "filterName": "All_created"
            }
        }
        //event.preventDefault();
        // alert(pageReference);
        cmp.set("v.showcmp","False");
        navService.navigate(pageReference);*/
        $A.get('e.force:refreshView').fire(); 
    },
    
    success :  function(cmp, event, helper) {
        var payload = event.getParams().response;
        var recordId = payload.id;
        var action=cmp.get("c.updatesreciveCharges");
        //alert( cmp.get("v.listofServiceChargesids")[0])
        action.setParams({ 
            invid : recordId,
            sclist : cmp.get("v.listofServiceCharges")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                var respo=response.getReturnValue();
                console.log('id is'+respo);
                //var navService = cmp.find("navService");
               // Uses the pageReference definition in the init handler
                
              /* var pageReference = {    
                    "type": "standard__recordPage",
                    "attributes": {
                        "recordId": respo,
                        "objectApiName": "Invoice__c",
                        "actionName": "view"
                    }
                }*/
               /* var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type" : "Success",
                    "title": "Success!",
                    "message": "Invoice Created successfully."
                });
                toastEvent.fire();*/
                cmp.set("v.showcmp","False");
                var navEvt = $A.get("e.force:navigateToSObject");
               navEvt.setParams({
               "recordId": respo
               });
               navEvt.fire();
                navService.navigate(pageReference);
                $A.get('e.force:refreshView').fire(); 
            } 
            else if (state === "INCOMPLETE") {
                alert("INCOMPLETE");
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            alert("Error message: " + 
                                  errors[0].message);
                        }
                        
                    } else {
                        alert("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);                   
    }
})
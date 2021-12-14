({
    doInit : function(component, event, helper) {
        component.set('v.loaded1',true);
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        var now = new Date();
        var d = new Date();
        var n = d.getDate()
        var lst = new Date(now.getFullYear(), now.getMonth()+1, 0).getDate();
        var lastDateOfMOnth= $A.localizationService.formatDate(new Date().setDate(new Date().getDate()+(lst-n)), "YYYY-MM-DD");
        var thisMonth= $A.localizationService.formatDate(new Date().setMonth(new Date().getMonth()), "YYYY-MM-DD");
        component.set('v.minDate',today);
        component.set('v.maxDate',lastDateOfMOnth);
        var action = component.get("c.fetchBeats");
        let button = component.find('beatSelect');
        button.set('v.disabled',true);
        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned 
                // from the server
                console.log("From server: " + response.getReturnValue());
                var beats=response.getReturnValue();
                component.set('v.beatData',beats) ;
                component.set('v.loaded1',false);
                
                
                
                // You would typically fire a event here to trigger 
                // client-side notification that the server-side 
                // action is complete
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        // optionally set storable, abortable, background flag here
        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);  
    },
    onSelectOfDate : function(component, event, helper) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        component.set('v.loaded1',true);
        
        if(component.get("v.selDate") != '' && component.get("v.selDate") >= component.get('v.minDate') && component.get("v.selDate") <= component.get('v.maxDate')){
            component.set("v.dateValidationError" , false);
            var action = component.get("c.fetchSelectedDateBeat");
            
            action.setParams({ selectedDate : component.get("v.selDate") });
            
            // Create a callback that is executed after 
            // the server-side action returns
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    // Alert the user with the value returned 
                    // from the server
                    console.log("From server: " + response.getReturnValue());
                    var beatData=response.getReturnValue();
                    console.log("From Var: " + JSON.stringify(beatData));
                    
                    if(beatData=='List has no rows for assignment to SObject'){
                        component.set('v.popUp','No Planned Beat For the Selected Date');
                        let button = component.find('beatSelect');
                        button.set('v.disabled',true);
                        component.set('v.btnDisable',true);
                    }else if(beatData=='Selected Tour Plan is already in pending stage'){
                        component.set('v.popUp','Selected Tour Plan is already in pending stage');
                        let button = component.find('beatSelect');
                        button.set('v.disabled',true);
                        component.set('v.btnDisable',true);
                    }else{
                        component.set('v.btnDisable',false);
                        component.set('v.popUp',beatData.Beat__r.Name);
                        component.set('v.tourPlanIds', beatData.Id);
                        var beats =component.get('v.beatData');
                        var opt = [];
                        opt.push({id : '-None-',label : '-None-'}); 
                        for(var i=0;i<beats.length;i++){
                            if(beats[i].Id != beatData.Beat__c){
                                opt.push({id : beats[i].Id,label : beats[i].Name}); 
                                
                            }
                        }
                        component.set('v.options',[]);
                        component.set('v.options',opt);
                        let button = component.find('beatSelect');
                        button.set('v.disabled',false);
                    }
                    component.set('v.loaded1',false);
                    
                    // You would typically fire a event here to trigger 
                    // client-side notification that the server-side 
                    // action is complete
                }
                else if (state === "INCOMPLETE") {
                    // do something
                }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " + 
                                            errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
            });
            
            // optionally set storable, abortable, background flag here
            
            // A client-side action could cause multiple events, 
            // which could trigger other events and 
            // other server-side action calls.
            // $A.enqueueAction adds the server-side action to the queue.
            $A.enqueueAction(action);
            
        }else{
            component.set("v.dateValidationError" , true);
            component.set('v.popUp','Please Select valid date');
            
            let button = component.find('beatSelect');
            button.set('v.disabled',true);
            component.set('v.loaded1',false);
            component.set('v.btnDisable',true);
            component.set('v.loaded1',false);  
        }   
    },
    onCancel : function(component, event, helper) {
        location.reload();
    },
    
    handleClick : function(component, event, helper) {
        component.set('v.loaded1',true);
        var bea= component.get('v.options');
        var index = bea.findIndex(item => item.id == component.get('v.selectedValue'));
        var beatNm = index >= 0? bea[index].label: null;
        var beatId = component.get('v.selectedValue');
        var tourId = component.get('v.tourPlanIds');
        if(beatNm!= null && beatNm!= '-None-' && beatNm!= ''  && beatNm!= 'No Planned Beat For the Selected Date' && beatNm!= undefined && beatNm!= '' && beatNm!= 'Selected Tour Plan is already in pending stage'){
            var r = confirm("‘Do you want to change the beat from "+component.get('v.popUp')+" to "+ beatNm);
            if (r == true) {
                var action = component.get("c.saveChanges");
                action.setParams({ tourPlanId : tourId,
                                  changedToBeat : beatId
                                 });
                // Create a callback that is executed after 
                // the server-side action returns
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        // Alert the user with the value returned 
                        // from the server
                        component.set('v.popUp','Change Beat Approval has been sent to Manager.');
                        console.log("From server: " + response.getReturnValue());
                        window.setTimeout(
                            $A.getCallback(function() {
                                location.reload();
                                component.set('v.loaded1',false);
                            }), 5000
                        ); 
                        // You would typically fire a event here to trigger 
                        // client-side notification that the server-side 
                        // action is complete
                    }
                    else if (state === "INCOMPLETE") {
                        // do something
                    }
                        else if (state === "ERROR") {
                            var errors = response.getError();
                            if (errors) {
                                if (errors[0] && errors[0].message) {
                                    console.log("Error message: " + 
                                                errors[0].message);
                                }
                            } else {
                                console.log("Unknown error");
                            }
                        }
                });
                // optionally set storable, abortable, background flag here
                // A client-side action could cause multiple events, 
                // which could trigger other events and 
                // other server-side action calls.
                // $A.enqueueAction adds the server-side action to the queue.
                $A.enqueueAction(action);
            } else {
                console.log("You pressed Cancel!");
                component.set('v.loaded1',false);
            }
        }  else{
            alert('Please select Beat');
            component.set('v.loaded1',false);
        }
    }  
})
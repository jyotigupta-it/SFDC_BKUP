({
    /**
     * This function will be called on component initialization
     * Attaching a document listner to detect clicks on the page
     * 1. Handle logic when click on dropdown/picklist button itself
     * 2. Handle logic when picklist option is clicked
     * 3. Handle logic when anywhere within picklist is clicked
     * 4. Handle logic if clicked anywhere else
     * */
    onRender : function(component, event, helper) {
        if(!component.get("v.initializationCompleted")){
            //Attaching document listener to detect clicks
            component.getElement().addEventListener("click", function(event){
                //handle click component
                helper.handleClick(component, event, 'component');
            });
            //Document listner to detect click outside multi select component
            document.addEventListener("click", function(event){
                helper.handleClick(component, event, 'document');
            });
            //Marking initializationCompleted property true
            component.set("v.initializationCompleted", true);
            //Set picklist name
            helper.setPickListName(component, component.get("v.selectedOptions"));
        }
        
    },
    
    /**
     * This function will be called when input box value change
     * */
    onInputChange : function(component, event, helper) {
        //get input box's value
        var inputText = event.target.value;
        //Filter options
        helper.filterDropDownValues(component, inputText);
    },
    SelectAll: function(component, event, helper) {
        component.set("v.selectedOptions",component.get('v.msoptions'));
        helper.setPickListName(component, component.get("v.selectedOptions"));
        var selectedOptions=component.get("v.selectedOptions");
        for(var i=0;i<selectedOptions.length;i++){
            var element = document.getElementById(selectedOptions[i].Id);
            var parentNode=element.parentNode;
            parentNode.classList.add('slds-is-selected');  
        }
        
    },
    /**
     * This function will be called when refresh button is clicked
     * This will clear all selections from picklist and rebuild a fresh picklist
     * */
    onRefreshClick : function(component, event, helper) {
        //clear selected options
        component.set("v.selectedOptions", []);
        //Clear check mark from drop down items
        helper.rebuildPicklist(component);
        //Set picklist name
        helper.setPickListName(component, component.get("v.selectedOptions"));
    },
    
    /**
     * This function will be called when clear button is clicked
     * This will clear any current filters in place
     * */
    onClearClick : function(component, event, helper) {
        //clear filter input box
        component.getElement().querySelector('#ms-filter-input').value = '';
        //reset filter
        helper.resetAllFilters(component);
    },
    
    /**
     * This function will save selected accounts into Meeting_attendee object
     */ 
    saveAccounts : function(component, event, helper) {
        var recordId = component.get("v.recordId");
        var selectedAccounts = component.get("v.selectedOptions");
        console.log("Meeting recordId: ",recordId);
        console.log('Total accounts selected: ',selectedAccounts.length);
        
        if(selectedAccounts.length == 0){
            alert('Select atleast one account');
        }else{
            for(var i=0; i<selectedAccounts.length; i++){
                console.log('###Id ', selectedAccounts[i].Id,' Name: '+ selectedAccounts[i].Name);
            }
            var action = component.get("c.addAccountsToMeetingAttendee");
            action.setParams({ 
                "recordId" :recordId, 
                "accountList" :selectedAccounts,
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS"){
                    var navEvt = $A.get("e.force:navigateToRelatedList");
                    navEvt.setParams({
                        "relatedListId": "Meeting_Attendees__r",
                        "parentRecordId": recordId,
                    });
                    navEvt.fire();
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'Accounts added...',
                        duration:' 3000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }else{
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(action);
            
            
        }
    }
})
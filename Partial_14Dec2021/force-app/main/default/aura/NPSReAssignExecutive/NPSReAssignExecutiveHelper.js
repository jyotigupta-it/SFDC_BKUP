({
    fetchExecutiveNameList: function (component, event, helper) {
        // fetch Executive name for re-assignment
        var action = component.get("c.getExecutiveNameList");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var executiveName = response.getReturnValue();
                component.set("v.executiveReAssignList", executiveName);
                console.log('executiveReAssignList **** ' + JSON.stringify(executiveName));
            }else if(response.getState() == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        console.log('errorMessage fetchExecutiveNameList 123 ' + errorMessage);
                        this.showMessage(errorMessage, 'error', 'pester', 5000);
                        return false;
                    }
                } else {
                    console.log("Unknown error fetchExecutiveNameList");
                }
            }
        });
        $A.enqueueAction(action);
    },

    // Get tagged Account records
    fetchTaggedAccountData: function (component, event, helper, buttonName) {
        var action, state, accountList;
        
        var pageSize = component.get("v.pageSize").toString();
        var pageNumber = component.get("v.pageNumber").toString();

        console.log('pageSize is ' + pageSize + ' pageNumber is ' + pageNumber);
        
        var executiveName = component.get('v.selectedExecutiveName');
        console.log('buttonName fetchTaggedAccountData ' + buttonName);
        console.log('executiveName fetchTaggedAccountData ' + executiveName); 

        if (buttonName == 'SearchTaggedAccount') {
            action = component.get('c.getTaggedAccount');
            action.setParams({
                'executiveName': executiveName,
                'pageSize': pageSize,
                'pageNumber': 1,
            });
            action.setCallback(this, function (response) {
                state = response.getState();
                accountList = response.getReturnValue();
                if (state == 'SUCCESS') {

                    // Setting pagination attribute again, if user again select filters after clicking of next button multiple time.
                    component.set('v.pageSize', pageSize);
                    component.set('v.pageNumber', 1);
                    component.set('v.dataSize', 0);

                    if (accountList.length > 0) {
                        component.set('v.data', accountList);
                        component.set('v.tableDisplay', true);
                    } else {
                        component.set('v.tableDisplay', false);
                        this.showMessage('No NPS Tagged account records found', 'info', 'dismissible', 5000);
                    }

                    if (accountList.length < component.get("v.pageSize")) {
                        component.set("v.isLastPage", true);
                    } else {
                        component.set("v.isLastPage", false);
                    }
                    component.set("v.dataSize", accountList.length);
                    component.set("v.data", accountList); // if 2nd time list return no account then override old list of account to null list

                } else if (state == 'ERROR') {
                    var errors = response.getError();
                    var errorMessage = '';
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            errorMessage = errors[0].message;
                            console.log('errorMessage fetchAccountData if : ' + errorMessage);
                            this.showMessage(errorMessage, 'error', 'pester', 5000);
                            return false;
                        }
                    } else {
                        console.log("Unknown error in fetchAccountData");
                    }
                }
            });
            $A.enqueueAction(action);
        } else {
            action = component.get('c.getTaggedAccount');
            action.setParams({
                'executiveName': executiveName,
                'pageSize': pageSize,
                'pageNumber': pageNumber,
            });
            action.setCallback(this, function (response) {
                state = response.getState();
                accountList = response.getReturnValue();
                if (state == 'SUCCESS') {
                    if (accountList.length > 0) {
                        component.set('v.data', accountList);
                        component.set('v.tableDisplay', true);
                    } else {
                        component.set('v.tableDisplay', false);
                        this.showMessage('No NPS Tagged account records found', 'info', 'dismissible', 5000);
                    }

                    if (accountList.length < component.get("v.pageSize")) {
                        component.set("v.isLastPage", true);
                    } else {
                        component.set("v.isLastPage", false);
                    }
                    component.set("v.dataSize", accountList.length);
                    component.set("v.data", accountList); // if 2nd time list return no account then override old list of account to null list

                } else if (state == 'ERROR') {
                    var errors = response.getError();
                    var errorMessage = '';
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            errorMessage = errors[0].message;
                            console.log('errorMessage fetchAccountData else : ' + errorMessage);
                            this.showMessage(errorMessage, 'error', 'pester', 5000);
                            return false;
                        }
                    } else {
                        console.log("Unknown error in fetchAccountData");
                    }
                }
            });
            $A.enqueueAction(action);
        }
        
    },

    AssignToNewExecutiveHelper: function (component, event, helper) {
        var selectedNewExecutive = component.get("v.selectedExecutiveReAssign");
        var selectedTaggedAccount = component.get("v.selectedAccount");

        var action = component.get('c.assignNewExecutive');
            action.setParams({
                'selectedNewExecutive': selectedNewExecutive,
                'selectedTaggedAccount': JSON.stringify(selectedTaggedAccount)
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state == 'SUCCESS') {
                    this.showMessage('New Executive Successfully Re-Assigned', 'success', 'pester', 5000);
                } else if (state == 'ERROR') {
                    var errors = response.getError();
                    var errorMessage = '';
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            errorMessage = errors[0].message;
                            console.log('errorMessage AssignToNewExecutiveHelper : ' + errorMessage);
                            this.showMessage(errorMessage, 'error', 'pester', 5000);
                            return false;
                        }
                    } else {
                        console.log("Unknown error in fetchAccountData");
                    }
                }
            });
            $A.enqueueAction(action);
    },

    showMessage : function(msg, msgtype, display_mode, duration){
        
        if(!duration) {            
            duration = 5000;
        }
        //display_mode: dismissible, pester, sticky 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            message: msg,
            messageTemplate: msg,
            duration:duration,
            key: 'info_alt',
            type: msgtype,
            mode: display_mode
        });
        toastEvent.fire();
    },
})
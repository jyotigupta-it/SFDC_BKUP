({
    fetchPicklistValues: function (component, objDetails, controllerField, dependentField) {
        var noneAttribute = component.get("v.noneAttribute");
        // call the server side function  
        var action = component.get("c.getDependentMap");
        // pass paramerters [object definition , contrller field name ,dependent field name] -
        // to server side function 
        action.setParams({
            'objDetail': objDetails,
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField
        });
        //set callback   
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                //store the return response from server (map<string,List<string>>)  
                var StoreResponse = response.getReturnValue();

                // once set #StoreResponse to depnedentFieldMap attribute 
                component.set("v.depnedentFieldMap", StoreResponse);

                // create a empty array for store map keys(@@--->which is controller picklist values) 
                var listOfkeys = []; // for store all map keys (controller picklist values)
                var ControllerField = []; // for store controller picklist value to set on lightning:select. 

                // play a for loop on Return map 
                // and fill the all map key on listOfkeys variable.
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }

                //set the controller field value for lightning:select
                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push(noneAttribute);
                }

                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push(listOfkeys[i]);
                }
                // set the ControllerField variable values to country(controller picklist field)
                component.set("v.listControllingValues", ControllerField);
            } else {
                alert('Something went wrong..');
            }
        });
        $A.enqueueAction(action);

        // fetch party type name from custom setting
        var actionParty = component.get("c.getPartyType");
        actionParty.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var partyNameResponse = response.getReturnValue();
                component.set("v.partyTypeList", partyNameResponse);
                console.log('partyNameResponse **** ' + JSON.stringify(partyNameResponse));
            } else {
                alert('Something went wrong while fetching party type');
            }
        });
        $A.enqueueAction(actionParty);

        // fetch Status from Account
        var actionStatus = component.get("c.getStatus");
        actionStatus.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var actionStatusResponse = response.getReturnValue();
                component.set("v.statusList", actionStatusResponse);
                console.log('actionStatusResponse **** ' + JSON.stringify(actionStatusResponse));
            } else {
                alert('Something went wrong while fetching Status');
            }
        });
        $A.enqueueAction(actionStatus);
    },

    fetchDepValues: function (component, ListOfDependentFields) {
        var noneAttribute = component.get("v.noneAttribute");
        // create a empty array var for store dependent picklist values for controller field  
        var dependentFields = [];
        dependentFields.push(noneAttribute);
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        // set the dependentFields variable values to store(dependent picklist field) on lightning:select
        component.set("v.listDependingValues", dependentFields);

    },

    // Get Account records based on filtered entered by user and display in data table
    fetchAccountData: function (component, event, helper, buttonName) {
        var action, state, accountList, stateName, districtName, toDate, fromDate, partyType, selectedTalukId, status, noneAttribute;
        stateName = component.get("v.objDetail.State__c");
        districtName = component.get("v.objDetail.District__c");
        toDate = component.get("v.toDate");
        fromDate = component.get("v.fromDate");
        partyType = component.get("v.selectedPartyType");
        selectedTalukId = component.get("v.selectedtalukName");
        status = component.get("v.selectedStatus");
        noneAttribute = component.get("v.noneAttribute");

        var noneAttribute = component.get("v.noneAttribute");
        var pageSize = component.get("v.pageSize").toString();
        var pageNumber = component.get("v.pageNumber").toString();

        // validation to enter all mandatory fields to search accounts
        if (stateName == '' || stateName == noneAttribute || stateName == undefined) {
            this.showMessage('Please Select State', 'warning', 'dismissible', 5000);
            return;
        }
        if (districtName == '' || districtName == noneAttribute || districtName == undefined) {
            this.showMessage('Please Select District', 'warning', 'dismissible', 5000);
            return;
        }
        if (partyType == '' || partyType == noneAttribute || partyType == undefined) {
            this.showMessage('Please Select Party Type', 'warning', 'dismissible', 5000);
            return;
        }

        if (fromDate > toDate) {
            this.showMessage('Please Select Correct Date Range', 'warning', 'dismissible', 5000);
            return;
        }

        if (fromDate != null && toDate == null) {
            this.showMessage('Please Select To Date Field', 'warning', 'dismissible', 5000);
            return;
        }

        if (fromDate == null && toDate != null) {
            this.showMessage('Please Select From Date Field', 'warning', 'dismissible', 5000);
            return;
        }
        
        if (buttonName == 'SearchAccount') {
            action = component.get('c.getFilteredAccount');
            action.setParams({
                'stateName': stateName,
                'districtName': districtName,
                'toDate': toDate,
                'fromDate': fromDate,
                'partyType': partyType,
                'selectedTalukId' : selectedTalukId,
                'pageSize': pageSize,
                'pageNumber': '1',
                'status' : status
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
                        this.showMessage('No matching account records found', 'info', 'dismissible', 5000);
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
                            console.log('errorMessage fetchAccountData : ' + errorMessage);
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
            action = component.get('c.getFilteredAccount');
            action.setParams({
                'stateName': stateName,
                'districtName': districtName,
                'toDate': toDate,
                'fromDate': fromDate,
                'partyType': partyType,
                'selectedTalukId' : selectedTalukId,
                'pageSize': pageSize,
                'pageNumber': pageNumber,
                'status' : status
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
                        this.showMessage('No matching account records found', 'info', 'dismissible', 5000);
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
                            console.log('errorMessage fetchAccountData : ' + errorMessage);
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

    showMessage: function (msg, msgtype, display_mode, duration) {

        if (!duration) {
            duration = 5000;
        }
        //display_mode: dismissible, pester, sticky 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            message: msg,
            messageTemplate: msg,
            duration: duration,
            key: 'info_alt',
            type: msgtype,
            mode: display_mode
        });
        toastEvent.fire();
    }
})
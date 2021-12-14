({
    doInit: function (component, event, helper) {
        // get the fields API name and pass it to helper function  
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var objDetails = component.get("v.objDetail");

        // let maxDate = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        // component.set("v.maxDate", maxDate);

        // call the helper function
        helper.fetchPicklistValues(component, objDetails, controllingFieldAPI, dependingFieldAPI);
    },

    onControllerFieldChange: function (component, event, helper) {
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        var noneAttribute = component.get("v.noneAttribute");

        if (controllerValueKey != noneAttribute) {
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];

            if (ListOfDependentFields.length > 0) {
                component.set("v.bDisabledDependentFld", false);
                helper.fetchDepValues(component, ListOfDependentFields);
            } else {
                component.set("v.bDisabledDependentFld", true);
                component.set("v.listDependingValues", ['--None--']);
            }

        } else {
            component.set("v.listDependingValues", ['--None--']);
            component.set("v.bDisabledDependentFld", true);
        }
    },

    findAccount: function (component, event, helper) {
        // Setting data table header
        component.set('v.columns', [
            { label: 'Account Name', fieldName: 'Name', type: 'text', editable: false, sortable: true },
            { label: 'State Name', fieldName: 'State__c', type: 'text', editable: false, sortable: true },
            { label: 'District Name', fieldName: 'District__c', type: 'text', editable: false, sortable: true },
            { label: 'Party Type', fieldName: 'Party_Type__c', type: 'text', editable: false, sortable: true }
        ]);
        
        // get button name
        var buttonName = event.getSource().get("v.name");
        helper.fetchAccountData(component, event, helper, buttonName);
    },

    getSelectedName: function (component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        var selectedAccount = [];
        console.log('selectedRows is ' + JSON.stringify(selectedRows));
        // Store account Id of the selected rows
        for (var i = 0; i < selectedRows.length; i++) {
            selectedAccount[i] = selectedRows[i].Id;
        }

        component.set("v.selectedAccount", selectedAccount);
        console.log('namecon in getSelectedName ' + component.get("v.selectedAccount"));

        // displaying executive assignment page on row selection or if selected account is atleast one
        var accountList = component.get("v.selectedAccount");
        if (accountList.length > 0) {
            component.set("v.executivePage", true);
        } else {
            component.set("v.executivePage", false);
        }

    },

    handleNext: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber + 1);
        helper.fetchAccountData(component, helper);

    },

    handlePrev: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber - 1);
        helper.fetchAccountData(component, helper);
    },

    processTalukList: function (component, event, helper) {
        var districtName = component.get("v.objDetail.District__c");
        var noneAttribute = component.get("v.noneAttribute");
        if (districtName == '' || districtName == noneAttribute || districtName == undefined) {
            component.set("v.talukDisplay", true);
        } else {
            var talukObjData, stateName, districtName, key;
            component.set("v.talukDisplay", false);
            
            stateName = component.get("v.objDetail.State__c");
            districtName = component.get("v.objDetail.District__c");

            // fetch Taluk name
            var actiontaluk = component.get("c.fetchTalukList");
            actiontaluk.setParams({
                'stateName': stateName,
                'districtName': districtName
            });
            actiontaluk.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var talukResponse = response.getReturnValue();
                    component.set("v.talukTypeList", talukResponse);
                    console.log('talukResponse **** ' + JSON.stringify(talukResponse));
                } else {
                    alert('Something went wrong while fetching taluk');
                }
            });
            $A.enqueueAction(actiontaluk);
        }
    }
})
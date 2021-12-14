({
    doInit: function (component, event, helper) {
        // call the helper function
        helper.fetchExecutiveNameList(component, event, helper);
    },

    SearchTaggedAccount : function(component, event, helper) {

        // Setting data table header
        component.set('v.columns', [
            { label: 'Account Name', fieldName: 'Name', type: 'text', editable: false, sortable: true },
            { label: 'State Name', fieldName: 'State__c', type: 'text', editable: false, sortable: true },
            { label: 'District Name', fieldName: 'District__c', type: 'text', editable: false, sortable: true },
            { label: 'Party Type', fieldName: 'Party_Type__c', type: 'text', editable: false, sortable: true }
        ]);

        // null check for executive value
        var executiveName = component.get('v.selectedExecutiveName');
        var noneAttribute = component.get("v.noneAttribute");
        console.log('executiveName SearchTaggedAccount ' + executiveName); 
        if(executiveName == noneAttribute || executiveName == null || executiveName == undefined || executiveName == '') {
            helper.showMessage('Please Select Executive', 'warning', 'dismissible', 5000);
            return false;
        }
        // get button name
        var buttonName = event.getSource().get("v.name");
        helper.fetchTaggedAccountData(component, event, helper, buttonName);
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
        console.log('namecon in getSelectedName *** ' + component.get("v.selectedAccount"));

        // displaying executive assignment page on row selection or if selected account is atleast one
        var accountList = component.get("v.selectedAccount");
        if (accountList.length > 0) {
            component.set("v.executivePage", true);
        } else {
            component.set("v.executivePage", false);
        }
    },
    
    AssignToNewExecutive: function (component, event, helper) {
        // null check for executive value
        var executiveName = component.get('v.selectedExecutiveReAssign');
        var noneAttribute = component.get("v.noneAttribute");
        console.log('executiveName AssignToNewExecutive ' + executiveName); 
        if(executiveName == noneAttribute || executiveName == null || executiveName == undefined || executiveName == '') {
            helper.showMessage('Please Select New Executive', 'warning', 'dismissible', 5000);
            return false;
        }
        helper.AssignToNewExecutiveHelper(component, helper);
    },

    handleNext: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber + 1);
        helper.fetchTaggedAccountData(component, event, helper);

    },

    handlePrev: function (component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber - 1);
        helper.fetchTaggedAccountData(component, event, helper);
    },
})
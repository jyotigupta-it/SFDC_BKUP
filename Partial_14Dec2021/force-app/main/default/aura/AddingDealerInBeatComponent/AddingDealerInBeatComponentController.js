({
    doInit: function(component, event, helper) {
        helper.doInitHelper(component, event,helper);
    },
    
    /* javaScript function for pagination */
    navigation: function(component, event, helper) {
        component.set('v.loaded',true);
        var mainList = component.get("v.listOfAllAccounts");
        // alert('mainList'+mainList.length);
        var filterList = component.get("v.filterlist");
        //alert('filterlist'+filterList.length);
        if(filterList.length==mainList.length){
            var sObjectList = component.get("v.listOfAllAccounts");
            var end = component.get("v.endPage");
            var start = component.get("v.startPage");
            var pageSize = component.get("v.pageSize");
            var whichBtn = event.getSource().get("v.name");
            // check if whichBtn value is 'next' then call 'next' helper method
            if (whichBtn == 'next') {
                component.set("v.currentPage", component.get("v.currentPage") + 1);
                helper.next(component, event, sObjectList, end, start, pageSize);
            }
            // check if whichBtn value is 'previous' then call 'previous' helper method
            else if (whichBtn == 'previous') {
                component.set("v.currentPage", component.get("v.currentPage") - 1);
                helper.previous(component, event, sObjectList, end, start, pageSize);
            }
        }else{
            var sObjectList = component.get("v.filterlist");
            var end = component.get("v.endPage");
            var start = component.get("v.startPage");
            var pageSize = component.get("v.pageSize");
            var whichBtn = event.getSource().get("v.name");
            // check if whichBtn value is 'next' then call 'next' helper method
            if (whichBtn == 'next') {
                component.set("v.currentPage", component.get("v.currentPage") + 1);
                helper.next(component, event, sObjectList, end, start, pageSize);
            }
            // check if whichBtn value is 'previous' then call 'previous' helper method
            else if (whichBtn == 'previous') {
                component.set("v.currentPage", component.get("v.currentPage") - 1);
                helper.previous(component, event, sObjectList, end, start, pageSize);
            }
        }
        component.set('v.loaded',false);
        
        
    },
    
    selectAllCheckbox: function(component, event, helper) {
        component.set('v.loaded',true);
        
        var mainList = component.get("v.listOfAllAccounts");
        //alert('mainList'+mainList.length);
        console.log('selectedCount'+  component.get("v.selectedCount"));
        
        
        var filterList = component.get("v.filterlist");
        //alert('filterlist'+filterList.length);
        if(filterList.length==mainList.length){
            console.log('First');
            var selectedHeaderCheck = event.getSource().get("v.value");
            var updatedAllRecords = [];
            var updatedPaginationList = [];
            var listOfAllAccounts = component.get("v.filterlist");
            var PaginationList = component.get("v.PaginationList");
            // play a for loop on all records list 
            for (var i = 0; i < listOfAllAccounts.length; i++) {
                // check if header checkbox is 'true' then update all checkbox with true and update selected records count
                // else update all records with false and set selectedCount with 0  
                if (selectedHeaderCheck == true) {
                    listOfAllAccounts[i].isChecked = true;
                    component.set("v.selectedCount", listOfAllAccounts.length);
                } else {
                    listOfAllAccounts[i].isChecked = false;
                    component.set("v.selectedCount", 0);
                }
                updatedAllRecords.push(listOfAllAccounts[i]);
            }
            // update the checkbox for 'PaginationList' based on header checbox 
            for (var i = 0; i < PaginationList.length; i++) {
                if (selectedHeaderCheck == true) {
                    PaginationList[i].isChecked = true;
                } else {
                    PaginationList[i].isChecked = false;
                }
                updatedPaginationList.push(PaginationList[i]);
            }
            component.set("v.listOfAllAccounts", updatedAllRecords);
            component.set("v.PaginationList", updatedPaginationList);
        }else{
            var selectedHeaderCheck = event.getSource().get("v.value");
            var updatedAllRecords = [];
            var updatedPaginationList = [];
            var listOfAllAccounts = component.get("v.filterlist");
            var PaginationList = component.get("v.PaginationList");
            // play a for loop on all records list 
            var tempSel=0;
            for (var i = 0; i < listOfAllAccounts.length; i++) {
                // check if header checkbox is 'true' then update all checkbox with true and update selected records count
                // else update all records with false and set selectedCount with 0  
                if (selectedHeaderCheck == true) {
                    listOfAllAccounts[i].isChecked = true;
                    tempSel++;
                } else {
                    listOfAllAccounts[i].isChecked = false;
                    tempSel--;
                    // component.set("v.selectedCount", 0);
                }
                updatedAllRecords.push(listOfAllAccounts[i]);
            }
            
            // update the checkbox for 'PaginationList' based on header checbox 
            for (var i = 0; i < PaginationList.length; i++) {
                if (selectedHeaderCheck == true) {
                    PaginationList[i].isChecked = true;
                } else {
                    PaginationList[i].isChecked = false;
                }
                updatedPaginationList.push(PaginationList[i]);
            }
            component.set("v.filterList", updatedAllRecords);
            component.set("v.PaginationList", updatedPaginationList);
            var allRecords = component.get("v.filterlist");
            var selectedRecords = [];
            for (var i = 0; i < mainList.length; i++) {
                if (mainList[i].isChecked) {
                    selectedRecords.push(mainList[i].objAccount.Id);
                }
            }
            component.set("v.selectedCount",selectedRecords.length);
            
        }
        component.set('v.loaded',false);
        
        
    },
    
    checkboxSelect: function(component, event, helper) {
        
        // on each checkbox selection update the selected record count 
        var selectedRec = event.getSource().get("v.value");
        var getSelectedNumber = component.get("v.selectedCount");
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
            component.find("selectAllId").set("v.value", false);
        }
        component.set("v.selectedCount", getSelectedNumber);
        // if all checkboxes are checked then set header checkbox with true   
        if (getSelectedNumber == component.get("v.totalRecordsCount")) {
            component.find("selectAllId").set("v.value", true);
        }
        
    },
    
    getSelectedRecords: function(component, event, helper) {
        var allRecords = component.get("v.listOfAllAccounts");
        var selectedRecords = [];
        for (var i = 0; i < allRecords.length; i++) {
            if (allRecords[i].isChecked) {
                selectedRecords.push(allRecords[i].objAccount);
            }
        }
        //alert(JSON.stringify(selectedRecords));
    },
    searchTable: function(component, event, helper) {
        console.log('Coming');
        helper.onSearch1(component, event);
        
    },
    
    openModel: function(component, event, helper) {
        component.set('v.loaded',true);
        
        // Set isModalOpen attribute to true
        
        console.log(component.get('v.selectedCount'));
        var allRecords = component.get("v.listOfAllAccounts");
        var selectedRecords = [];
        for (var i = 0; i < allRecords.length; i++) {
            if (allRecords[i].isChecked) {
                selectedRecords.push(allRecords[i].objAccount.Id);
            }
        }
        console.log('selectedRecords'+selectedRecords.length);
        if(selectedRecords.length!=0){
            component.set("v.isModalOpen", true);
            var childComp = component.find("childComp");
            var tempString=JSON.stringify(selectedRecords);
            console.log('tempString'+tempString);
            childComp.callChild(selectedRecords);
        }else{
            helper.showToast(component, event, helper,'Warning!','Please select atleast one dealer','error'); 
        }
        component.set('v.loaded',false);
    },
    
    closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
    
    submitDetails: function(component, event, helper) {
        // Set isModalOpen attribute to false
        //Add your code to call apex method or do some processing
        var childComp = component.find("childComp");
        childComp.sveBeat();
        // component.set("v.isModalOpen", false);
    },
})
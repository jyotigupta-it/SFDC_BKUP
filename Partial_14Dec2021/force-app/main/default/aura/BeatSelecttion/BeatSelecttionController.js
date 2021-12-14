({
    init: function (cmp, event, helper) {
        cmp.set('v.loaded1',true);
        
        cmp.set('v.columns', [
            { label: 'Beat Name', fieldName: 'beatName', type: 'text' },
            { label: 'No. fo Dealers', fieldName: 'noOfDealers', type: 'number', cellAttributes: { alignment: 'left' }
            }
        ]);
        var action = cmp.get("c.fetchBeats");
        action.setCallback(this, function(response){
            console.log('response.getReturnValue()'+response.getReturnValue());
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.data", response.getReturnValue());
                cmp.set("v.filteredData", response.getReturnValue());
                if(response.getReturnValue().length>0){
                    cmp.set("v.NoRecordsFound" , true);
                }else{
                    cmp.set("v.NoRecordsFound" , false);
                    
                }
                cmp.set('v.loaded1',false);
                
            }
        });
        $A.enqueueAction(action);
    },
    
    searchTable : function(cmp,event,helper) {
        var allRecords = cmp.get("v.data");
        var searchFilter = event.getSource().get("v.value").toUpperCase();
        var tempArray = [];
        var i;
        // cmp.set("v.filteredData",[]);
        
        
        for(i=0; i < allRecords.length; i++){
            if(allRecords[i].beatName && allRecords[i].beatName.toUpperCase().indexOf(searchFilter) != -1)
            {
                tempArray.push(allRecords[i]);
            }
        }
        console.log('cmp.find("accountDataTable")'+cmp.find("accountDataTable"));
        console.log('cmp.get("v.selection")'+cmp.get("v.selection"));
        var i =cmp.get("v.selection");
        cmp.set("v.filteredData",tempArray);
        cmp.find("accountDataTable").set("v.selectedRows",i);
        
    },
    
    handleSelect : function(component, event, helper) {
        
        var selectedRows = event.getParam('selectedRows'); 
        console.log('selectedRows'+selectedRows);
        var setRows = [];
        for ( var i = 0; i < selectedRows.length; i++ ) {
            
            setRows.push(selectedRows[i].beatId);
            
        }
        component.set("v.selectedAccts", setRows);
        component.set("v.selection", setRows);
        
        
    },
    
    callChildMethod : function(component, event, helper) {
        component.set('v.loaded1',true);
        
        //alert("mehtod called from parent");
        var params = event.getParam('arguments');
        //alert(JSON.stringify(params));
        if (params) {
            var param1 = params.param1;
            console.log('param1'+param1);
            component.set('v.selectedDealers',param1)
            // add your code here
            component.set('v.loaded1',false);
            
        }
    },
    
    saveBeat : function(component, event, helper) {
        component.set('v.loaded1',true);
        
        var selectedTempBeat = component.get('v.selectedAccts');
        //alert(JSON.stringify(selectedTempBeat));
        //alert(component.get('v.selectedDealers'));
        if(selectedTempBeat[0] == undefined){
            helper.showToast(component, event, helper,'Warning!','Please select Beat','error'); 
        }else{
            var action = component.get('c.addDealerInBeat');
            // alert('action'+action);
            // alert('selectedTempBeat[0]'+selectedTempBeat[0]);
            
            
            
            action.setParams({
                selectedBeat1 : selectedTempBeat[0],
                selectedDealersToSave1 : component.get('v.selectedDealers')
                
            })
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    if(response.getReturnValue()=='Success'){
                        helper.showToast(component, event, helper,'Success!','Dealer Added Successfully','success'); 
                        $A.get('e.force:refreshView').fire();
                    }else
                    {
                        helper.showToast(component, event, helper,'Failed!',response.getReturnValue(),'Error'); 
                        $A.get('e.force:refreshView').fire();
                        
                    }
                    component.set('v.loaded1',false);
                    
                    
                }else if (state === "INCOMPLETE") {
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
            $A.enqueueAction(action);   
        }
        
        
    }
    
})
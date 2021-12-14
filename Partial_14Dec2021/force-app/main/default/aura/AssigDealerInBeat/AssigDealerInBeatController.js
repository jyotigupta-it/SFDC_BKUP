({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            { label: 'Beat Name', fieldName: 'beatName', type: 'text' },
            { label: 'No. fo Dealers', fieldName: 'noOfDealers', type: 'number', cellAttributes: { alignment: 'left' }
            }
        ]);
        var action = cmp.get("c.fetchBeats");
        action.setParams({
            'accId1' : cmp.get('v.recordId'),
        })
        action.setCallback(this, function(response){
            console.log('response.getReturnValue()'+response.getReturnValue());
            var state = response.getState();
            if (state === "SUCCESS") {
                
                if(response.getReturnValue() =='beatAssigned'){
                    helper.showToast(cmp, event, helper,'Warning!','Dealer is already in a Beat','warning'); 
                    $A.get("e.force:closeQuickAction").fire() 
                }else
                {
                    cmp.set("v.data", response.getReturnValue());
                    cmp.set("v.filteredData", response.getReturnValue());
                    if(response.getReturnValue().length>0){
                        cmp.set("v.NoRecordsFound" , true);
                    }else{
                        cmp.set("v.NoRecordsFound" , false);
                    }
                    cmp.set("v.truthy", true);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    searchTable : function(cmp,event,helper) {
        var allRecords = cmp.get("v.data");
        var searchFilter = event.getSource().get("v.value").toUpperCase();
        var tempArray = [];
        var i;
        
        
        for(i=0; i < allRecords.length; i++){
            if(allRecords[i].beatName && allRecords[i].beatName.toUpperCase().indexOf(searchFilter) != -1)
            {
                tempArray.push(allRecords[i]);
            }
        }
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
    
    onCancel :  function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire()
    },
    
    addToBeat :  function(component, event, helper) {
        var selectedTempBeat = component.get('v.selectedAccts');
        
        if(selectedTempBeat[0] == undefined){
            helper.showToast(component, event, helper,'Warning!','Please select Beat','error'); 
        }else{
            var action = component.get("c.addingInBeat");
            action.setParams({
                accId : component.get('v.recordId'),
                beatId : selectedTempBeat[0]
            })
            action.setCallback(this, function(response){
                console.log('response.getReturnValue()'+response.getReturnValue());
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log(response.getReturnValue());
                    helper.showToast(component, event, helper,'Success!','Dealer Added to '+ response.getReturnValue() + ' Beat Successfully','success'); 
                    $A.get("e.force:closeQuickAction").fire() 
                }
            });
            $A.enqueueAction(action);
        }
    }
    
})
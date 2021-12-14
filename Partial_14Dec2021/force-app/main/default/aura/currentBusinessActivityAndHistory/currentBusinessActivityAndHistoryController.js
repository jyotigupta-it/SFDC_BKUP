({
    AddNewRow : function(component, event, helper){
       // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").setParams({
           "whichPartner":'businessActivityHistory'
       }).fire();     
    },
    
    removeRow : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("DeleteRowEvt").setParams({
           "indexVar" : component.get("v.rowIndex"),
           "whichPartner":'businessActivityHistory'
       }).fire();
    }, 
  
})
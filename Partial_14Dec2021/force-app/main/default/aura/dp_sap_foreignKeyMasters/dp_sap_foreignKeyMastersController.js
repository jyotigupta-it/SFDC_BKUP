({
    AddNewRow : function(component, event){
        debugger;
       // fire the AddNewRowEvt Lightning Event 
       var compo = event.getSource().getLocalId();
       //var buttonLabel = event.getSource().get("v.label");
        component.getEvent("AddRowEvt").setParams({
           "whichPartner": compo
       }).fire();     
    },
    
    removeRow : function(component, event){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
     var compo =event.currentTarget.id;
     //var buttonLabel = event.getSource().get("v.label");
       component.getEvent("DeleteRowEvt").setParams({
           "indexVar" : component.get("v.rowIndex"),
           "whichPartner": compo
       }).fire();
    }, 
})
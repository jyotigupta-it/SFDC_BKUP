({
    AddNewRow : function(component, event, helper){
        debugger;
       // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").setParams({
           "whichPartner":'selfAndFamily'
       }).fire();     
    },
    
    removeRow : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("DeleteRowEvt").setParams({
           "indexVar" : component.get("v.rowIndex"),
           "whichPartner":'selfAndFamily'
       }).fire();
    }, 

    handleCheck1: function(component){
        debugger;
        var isChecked = component.find("check1").get("v.checked");
        component.set("v.upload_One_passport_Size", isChecked);
    }
  
})
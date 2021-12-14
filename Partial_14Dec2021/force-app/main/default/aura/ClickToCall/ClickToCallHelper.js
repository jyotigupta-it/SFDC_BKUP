({
    doInit : function(component, event){
        var recordId=component.get("v.recordId");
        var action = component.get("c.clickToCall");
        action.setParams({
            'recordId': recordId,
        });
        action.setCallback(this, function(response){
            console.log('State: '+response.getState())
            var state=response.getState();
            
            if(state==="SUCCESS"){
                console.log('SUCCESS Line 1');
                var wap=response.getReturnValue();
                console.log('wap is'+wap);
                if(wap.includes("missing")){
                    component.set("v.isError",true);
                    component.set("v.errorMessage",wap);
                }else{
                	component.set("v.taskId",wap);
                }
                //var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		//dismissActionPanel.fire();
            }
        });
        $A.enqueueAction(action);
    },
    saveDisposition : function(component, event){
        debugger;
        var taskid=component.get("v.taskId");
        console.log('taksid is'+taskid);
        var action = component.get("c.saveCallResult");
        action.setParams({
            'taskId': component.get("v.taskId") ,
            'disposition': component.get("v.selectedDisposition"),
            'comments': component.get("v.comments")
        });
        action.setCallback(this, function(response){
            console.log('State: '+response.getState());
            var state=response.getState();
            if(state==="SUCCESS"){
               console.log('SUCCESS Line 1');
                
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
        		dismissActionPanel.fire();
                
            }
        });
        $A.enqueueAction(action);
    },
    openModalCASEclosure : function(component, event) {
        console.log('Calll22');
        var modal = component.find('modal');
        $A.util.addClass(modal, 'slds-fade-in-open');
        var backdrop = component.find('backdrop');
        $A.util.addClass(backdrop, 'slds-backdrop--open');
    },
    closeModelCASEclosure : function(component, event) {
        var modal = component.find('modal');
        $A.util.removeClass(modal, 'slds-fade-in-open');
        var backdrop = component.find('backdrop');
        $A.util.removeClass(backdrop, 'slds-backdrop--open');
        console.log('close the model');
        
    },
    showErrorToast:function(component,event,str,typ,tit) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type":typ,
            "title": tit,
            "message": str
            
        });
        toastEvent.fire();
    },
})
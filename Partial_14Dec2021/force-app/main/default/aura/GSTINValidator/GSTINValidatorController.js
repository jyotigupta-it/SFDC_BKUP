({
    //This controller method is to call helper method
    doInit: function(component, event, helper) {
        console.log('recordId'+ component.get('v.recordId'));
        helper.doInit(component, event, helper);
    },
    //This controller method is close model
    cancelModel: function(component, event, helper) {
        helper.cancelModel(component, event, helper);
    },
});
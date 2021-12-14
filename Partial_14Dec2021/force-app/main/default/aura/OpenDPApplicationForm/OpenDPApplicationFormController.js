({
    doInit : function(component, event, helper) {
        debugger;
        /*var navService = component.find("navService");
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c:dpAppointmentApplicationForm'
            },
            state : {
                c__recordId : component.get('v.recordId')
            }
        };
        component.set("v.pageReference", pageReference);
        var defaultUrl = "#";
        navService.generateUrl(pageReference)
        .then($A.getCallback(function(url) {
            component.set("v.url", url ? url : defaultUrl);
        }), $A.getCallback(function(error) {
            component.set("v.url", defaultUrl);
        }));
        navService.navigate(pageReference);
        $A.get("e.force:closeQuickAction").fire();*/
        
        /*navService.generateUrl(pageReference).then($A.getCallback(function(url) {
        window.open(url,'_blank'); // This will open in new tab with pageReference with state/URL params you sent while creating instance of pageReference
        } 
        ))//
    }*/
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef: "c:dpAppointmentApplicationFormLightning",
            componentAttributes :{ 
                recordId : component.get('v.recordId')
            }
        });
        
        evt.fire();
    }
})
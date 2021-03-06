({
    
    showReplies : function(component, event, helper) {
        
        helper.handleReplyHelper(component, event);
    },
    createComment : function(component, event, helper){
        helper.createCommentHelper(component, event);
    },
    ideadelete : function(component,event,helper){
        helper.deleteIdea(component, event);
    },
    ideasTab : function(component,event,helper){
        //component.set('v.ideaId','');
        var navService = component.find("navService");
        var pageReference = {    
            "type": "standard__component",
            "attributes": {
                "componentName": "c__ViewIdea"    
            }
        }
        //navService.navigate(pageReference);
    },
    deletecomment : function(component,event,helper){
        var idx = event.target.id;
        helper.deleteCommenthelper(component,event);
    },
    closeModal: function(component, event){    
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack, 'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
    },
    openModal: function(component, event) {
       /* var eventTarget = event.getSource().getLocalId();
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); */
        alert(component.get('v.CommentId'));
    },
    openModalComment: function(component, event) {
        var idx = event.target.id;
        component.set('v.ideaCommentId',idx);
        component.set('v.isOpenModalComment',true);
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop1');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
    closeModalComment: function(component, event){    
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop1');
        $A.util.removeClass(cmpBack, 'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        $A.get('e.force:refreshView').fire();
    },
    openModalReplyComment: function(component, event) {
        var idx = event.target.id;
        component.set('v.ideaCommentId',idx);
        component.set('v.isOpenModalReplyComment',true);
        var cmpTarget = component.find('Modalbox2');
        var cmpBack = component.find('Modalbackdrop2');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
    closeModalReplyComment: function(component, event){    
        var cmpTarget = component.find('Modalbox2');
        var cmpBack = component.find('Modalbackdrop2');
        $A.util.removeClass(cmpBack, 'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        $A.get('e.force:refreshView').fire();
    },
	
})
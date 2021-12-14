({
	doInit : function(component, event, helper) {
        helper.checkActiveSession(component, event, helper);
	},
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    navigateToWhatsApp : function(component, event, helper) {
        window.open("https://api.whatsapp.com/send?phone=+918061341881");
    },
    closeFileUploadMessageModal : function(component, event, helper) {
        component.set("v.fileUploadStatus", false);
    }
})
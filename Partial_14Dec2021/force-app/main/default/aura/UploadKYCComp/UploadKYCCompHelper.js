({
    MAX_FILE_SIZE: 5242880, //Max file size 5 MB
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
    checkActiveSession : function(component, event, helper) {
        //debugger;
        var device = $A.get("$Browser.formFactor");
        
        var messagingSessionID = component.get("v.messagingSessionID");
        var endUserId = component.get("v.contextUserID");
        var action = component.get("c.checkActiveSession");
        action.setParams({"messagingSessionID":messagingSessionID,
                         "endUserId":endUserId});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var res = response.getReturnValue();
                component.set("v.activeMessageSession",res.status);
                if(res.status==false){
					component.set("v.deActiveMessageSession",true);                    
                }
                component.set("v.parentId",res.accId);
                component.set("v.userName",res.userName);
                component.set("v.endMin",res.endMin);
                component.set("v.endSec",res.endSec);
                helper.startTimer(component, event, helper);
            }
            else{
                component.set("v.deActiveMessageSession",true);
                
            }
        });
        $A.enqueueAction(action);
        //helper.startTimer(component, event, helper);
    },
    setTimeOut: function(component, event, helper) {
        var timer = setTimeout(function() {
            alert('Hello');
        }, 3000);
    },
    startTimer : function(component, event, helper) {
        //debugger;
        var endMin = component.get("v.endMin");
        var endSec = component.get("v.endSec");
        var timer = setInterval(function() {
            endSec = endSec-1;
            if(endSec < 0){
                endMin = endMin-1;
                endSec = 59;
            }
            if(endSec == 0 && endMin == 0){
                clearInterval(timer);
                component.set("v.deActiveMessageSession",true);
            }
            var timeLeft =  endMin + "m " + endSec + "s ";
            component.set("v.timeLeft", timeLeft);
        }, 1000);
    },
    uploadHelper: function(component, event) {
        component.set("v.spinnerFlag", true);
        var fileInput = component.find("fileId").get("v.files");
        var file = fileInput[0];
        var self = this;
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.spinnerFlag", false);
            component.set("v.fileName", 'Alert : File size cannot exceed 5MB.\n' + ' Selected file size is: ' +(file.size / (1024*1024)).toFixed(2) + 'MB');
            return;
        }
        var objFileReader = new FileReader();
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess(component, file, fileContents);
        });
 
        objFileReader.readAsDataURL(file);
    },
    uploadProcess: function(component, file, fileContents) {
        var startPosition = 0;
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
    },
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId) {
        //debugger;
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: component.get("v.parentId"),
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
 
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    var messagingSessionID = component.get("v.messagingSessionID");
                    var endUserId = component.get("v.contextUserID");
                    var action = component.get("c.updateFileUploadStatus");
                    action.setParams({"messagingSessionID":messagingSessionID,
                                      "endUserId":endUserId});
                    action.setCallback(this,function(response){
                        var state = response.getState();
                        if(state === "SUCCESS"){
                            component.set("v.fileUploadStatus", true);
                            component.set("v.spinnerFlag", false);    
                        }
                        else if (state === "ERROR") {
                            var errors = response.getError();
                            if (errors) {
                                if (errors[0] && errors[0].message) {
                                    console.log("Error message: " + errors[0].message);
                                }
                            } else {
                                console.log("Unknown error");
                            }
                        }
                    });
                    $A.enqueueAction(action);
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                alert("From server: " + response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    }
})
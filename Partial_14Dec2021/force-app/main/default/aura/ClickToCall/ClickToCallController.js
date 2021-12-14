({	
	doInit : function(component, event, helper){
        console.log('test');
        var str = component.get("v.recordId");
		var res = str.substring(0, 3);
        if(res == "500"){
            component.set("v.showCaseFeedback", true);
        }else{
            component.set("v.showWorkOrderFeedback", true);    
        }
        var arrObj = [];
        arrObj.push({label: 'No Response',value: 'No Response'});
        arrObj.push({label: 'Not Connected',value: 'Not Connected'});
        arrObj.push({label: 'Connected',value: 'Connected'});
        component.set("v.callDispList", arrObj);
        var arr= [];
        arr.push({label: 'YES',value: 'YES'});
        arr.push({label: 'NO',value: 'NO'});
        component.set("v.caseClosureList", arr);
        helper.doInit(component, event);
    },
    handleClick : function(component, event, helper){
       // debugger;
        console.log('saving');
        console.log(component.get("v.selectedDisposition"));
        console.log(component.get("v.comments"));
        helper.saveDisposition(component, event);
    },
    closeModal: function(component, event, helper) {
      helper.closeModelCASEclosure(component, event);
   	},
    handleChange: function(component, event, helper){
        console.log('handle change');
        var caseclose=component.get("v.caseclose");
        if(caseclose=='YES'){
           helper.openModalCASEclosure(component,event,helper); 
        }
    },
    onSubmit: function(component, event, helper){
        debugger;
        console.log('on submit');
        console.log('recordid'+component.get("v.recordId"));
        var validreason=component.find("reason").get("v.value");
        var iscomaplint=component.find("iscomplaint").get("v.value");
        var rate=component.find("rate").get("v.value");
        var behavior=component.find("behavior").get("v.value");
       var closeresaon=component.find("closeresaon").get("v.value");
       var status=component.find("status").get("v.value");
        console.log('validreason'+validreason);
        if(status==='Closed'){
        if(closeresaon==='' || closeresaon===undefined || closeresaon==='--None--'){
            helper.showErrorToast(component,event,'Please fill the valid reason','Error','Error!');
            return;
        }else if(iscomaplint==='' || iscomaplint===undefined){
            helper.showErrorToast(component,event,'Please fill is your compalint resolved','Error','Error!');
            return;
        }else if(rate==='' || rate===undefined){
            helper.showErrorToast(component,event,'Please fill rating','Error','Error!');
            return;
        }else if(behavior==='' || behavior===undefined){
            helper.showErrorToast(component,event,'Please fill  behavior of our expert','Error','Error!');
            return;
        }else if(closeresaon==='' || closeresaon===undefined){
            helper.showErrorToast(component,event,'Please fill the valid case clousre reason','Error','Error!');
            return;
        }else if(iscomaplint ==='No'){
           helper.showErrorToast(component,event,'You cannot select No when the status is closed ','Error','Error!');
            return; 
        }
        }
        if(status==='Open'){
            if(iscomaplint ==='Yes'){
           helper.showErrorToast(component,event,'You cannot select Yes when the status is Open ','Error','Error!');
            return; 
        }
        }
    },
    onSuccess:function(component, event, helper){
        debugger;
        console.log('on success');
        helper.closeModelCASEclosure(component,event,helper);
    }
})
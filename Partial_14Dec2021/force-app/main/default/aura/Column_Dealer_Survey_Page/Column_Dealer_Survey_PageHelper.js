({
    fetchPicklistValues: function(component,objDetails,controllerField, dependentField) {
        var action = component.get("c.getDependentMap");
        action.setParams({
            'objDetail' : objDetails,
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField 
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                debugger;
                var StoreResponse = response.getReturnValue();
                var a = [];
                var objectDetails= {};
                objectDetails['sobjectType'] = 'Column_dealer_Survey__c';
                component.set("v.depnedentFieldMap",StoreResponse);
                var listOfkeys = []; 
                var ControllerField = [];
                var i=0;
                for (var singlekey in StoreResponse) {
                    var objectDetails= {};
                    objectDetails['sobjectType'] = 'Column_dealer_Survey__c';
                    var tempList = StoreResponse[singlekey];
                    var res = {};
                    res['index'] = i;
                    res['objDetail'] = objectDetails;
                    res['objDetail']['Product_sold_by_dealer__c'] = singlekey;
                    res['controllinglFieldValues'] = [singlekey,'Not applicable'];
                    res['showInput'] = false;
                    var itemsList = [];
                    for(var x in tempList){
                        var item= {
                            'label' : tempList[x],
                            'value' : tempList[x]
                        };
                        itemsList.push(item);
                    }
                    res['objDetail']['depFieldValues'] = itemsList;
                    a.push(res);
                    listOfkeys.push(singlekey);
                    i=i+1;
                }
                /*if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push('--- None ---');
                }
                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push(listOfkeys[i]);
                } 
                var a = [];
                var objectDetails= {};
                objectDetails['sobjectType'] = 'Column_dealer_Survey__c';
                //objectDetails['Product_sold_by_dealer__c'] = 
                for(var i = 0; i< listOfkeys.length; i++){
                    var res = {};
                    res['index'] = i;
                    res['objDetail'] = objectDetails;
                    res['objDetail']['Product_sold_by_dealer__c'] = listOfkeys[i];
                    var temp = StoreResponse[listOfkeys[i]];
                    var itemsList = [];
                    for(var x in temp){
                        var item= {
                            'label' : temp[x],
                            'value' : temp[x]
                        };
                        itemsList.push(item);
                    }
                    res['objDetail']['depFieldValues'] = itemsList;
                    res['controllinglFieldValues'] = [listOfkeys[i],'Not applicable'];
                    a.push(res);
                }*/
                
                component.set('v.prodList',a);
                component.set("v.listControllingValues", ControllerField);
            }else{
                alert('Something went wrong..');
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchDepValues: function(component,event,ListOfDependentFields) {
        debugger;
        var dependentFields = [];
        var res = component.get('v.prodList');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push({
                label : ListOfDependentFields[i], 
                value : ListOfDependentFields[i]
            });
        }
        res[event.getSource().get('v.name')]['objDetail']['depFieldValues'] = dependentFields ;
        component.set('v.prodList',res);
        console.log('dependentFields *** ' + dependentFields);
        component.set("v.listDependingValues", dependentFields);
    },
    
    getFieldLabelWithApiHelper : function(component, event, helper) {
        var action = component.get("c.getFieldLabelNameAndApi");
        action.setCallback(this, function(response) {
            var state = response.getState();
            var serverResponse = response.getReturnValue();
            if (state == 'SUCCESS') {
                console.log('serverResponse ' + JSON.stringify(serverResponse));
                component.set("v.fieldLabelApiMap", serverResponse);
            } else if (state == 'ERROR') {
                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                // Display the message
                console.error('message is ' + message);
                console.log('coming error message ' + message);
            }
        });
        $A.enqueueAction(action);
    },
    
    getFieldLabelWithApiHelper1 : function(component, event, helper) {
        var action = component.get("c.abc");
        action.setCallback(this, function(response) {
            var state = response.getState();
            var serverResponse = response.getReturnValue();
            
            if (state == 'SUCCESS') {
                console.log('serverResponse ' + JSON.stringify(serverResponse));
                component.set("v.fieldLabelApiMap", serverResponse);
            } else if (state == 'ERROR') {
                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                console.error('message is ' + message);
                console.log('coming error message ' + message);
            }
            component.set('v.Spinner',false);
        });
        $A.enqueueAction(action);
    },
    getOtherPicklistValues : function(component,event,helper,fieldName){
        var action = component.get('c.getOtherPickListValues');
        action.setParams({
            'fieldName' : fieldName 
        });
        console.log(fieldName);
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var res = [];
                var result = response.getReturnValue();
                res.push({'label' : '--None--','value' :'--None--'});
                for(var x in result){
                    var options = {
                        "label": result[x],
                        "value": result[x] 
                    }
                    res.push(options);
                }
                console.log('result...'+ result);
                if(fieldName == 'Conversion_Time_From_GI_to_Column__c'){
                    component.set('v.conversionTimeOptions',res);
                }
                
                else if(fieldName == 'Credit_Facility_given_to_dealer_by_Pipe__c'){
                    component.set('v.creditFacilityOptions',res);
                }
                    else if(fieldName == 'Electricity_connection__c'){
                        component.set('v.electricityConnectonOptions',res);
                    }
                        else if(fieldName == 'Hdpe_fast_moving_Size_Inch__c'){
                            res.shift();
                            component.set('v.hdpeOptions',res);
                        }
                            else if(fieldName == 'Type_of_Influencers_of_Dealer__c'){
                                res.shift();
                                component.set('v.typeOfInfluenceOptions',res);
                            }
                                else if(fieldName == 'Fast_Moving_Size__c'){
                                res.shift();
                    
                               component.set('v.fastMovingSize',res);
                            }
                                  else if(fieldName == 'Color_of_tank__c'){
                                res.shift();
                    
                               component.set('v.tankColor',res);
                            }
                
                                else if(fieldName == 'Column_fast_moving_Size_Inch__c'){
                                res.shift();
                    
                               component.set('v.columnOptions',res);
                            }
                
                                else if(fieldName == 'Casting_fast_moving_Size_Inch__c'){
                                res.shift();
                    
                               component.set('v.casingOptions',res);
                            }
                
                                else if(fieldName == 'Agri_fast_moving_Size_Inch__c'){
                                res.shift();
                    
                               component.set('v.agriOptions',res);
                            }
            }
        });
        $A.enqueueAction(action);
    },
    surveySaveHelper : function(component,event,helper){
        var action = component.get("c.saveColumnRecords");
        var action1 = component.get("v.fastMovingSize");
        var action2 = component.get("v.tankColor");
        var obj = [];
        component.set('v.Spinner',true);
        var otherFiedls = component.get('v.otherFields');
        var accId =  component.get('v.recordId');
        var res = component.get('v.prodList');
        debugger;
        for(var x in res){
            if(res[x]['objDetail']['Product_sold_by_dealer__c'] != 'Not applicable' && res[x]['objDetail']['Name_of_Brands__c']!= undefined){
                var object = {};
                object['sObjectType'] = 'Column_dealer_Survey__c';
                object['Account__c'] = accId;
                object['Product_sold_by_dealer__c'] = res[x]['objDetail']['Product_sold_by_dealer__c'];
                //object['Fast_Moving_Size__c'] =action1;
                //object['Color_of_tank__c'] =action2;
                object['Name_of_Brands__c'] = (res[x]['objDetail']['Name_of_Brands__c']!= undefined)?res[x]['objDetail']['Name_of_Brands__c'].join(';'):null;
                var temp = res[x].surveyListToInsert;
                for(var y in temp){
                    if(temp[y]['value'] != undefined)
                        object[temp[y]['field']] = temp[y]['value'];
                }
                var tempVar = Object.keys(otherFiedls);
                for(var a in tempVar){
                    if(otherFiedls[tempVar[a]] != undefined){
                        if(tempVar[a] == 'Type_of_Influencers_of_Dealer__c'){
                            object[tempVar[a]] = (otherFiedls['Type_of_Influencers_of_Dealer__c'] != undefined)?otherFiedls['Type_of_Influencers_of_Dealer__c'].join(';'):'';
                        }
                        else{
                            object[tempVar[a]] = otherFiedls[tempVar[a]];
                        }
                        
                    }
                    
                }
                tempVar = component.get('v.influencerList');
                for(var x in tempVar){
                    object[tempVar[x]['apiName']] = tempVar[x]['value'];
                }
                tempVar= component.get('v.Fast_Moving_Size__c');
                 for(var z in tempVar){
                     
                    object[tempVar[z]['apiName']] = tempVar[z]['value'];
                }
               tempVar= component.get('v.Color_of_tank__c');
                 for(var z in tempVar){
                     
                    object[tempVar[z]['apiName']] = tempVar[z]['value'];
                }
                tempVar= component.get('v.Casting_fast_moving_Size_Inch__c');
                 for(var z in tempVar){
                     
                    object[tempVar[z]['apiName']] = tempVar[z]['value'];
                }
                tempVar= component.get('v.Agri_fast_moving_Size_Inch__c');
                 for(var z in tempVar){
                     
                    object[tempVar[z]['apiName']] = tempVar[z]['value'];
                }
                tempVar= component.get('v.Column_fast_moving_Size_Inch__c');
                 for(var z in tempVar){
                     
                    object[tempVar[z]['apiName']] = tempVar[z]['value'];
                }
                    
                    
                     //object['Fast_Moving_Size__c'] = action1;
                     //object['Color_of_tank__c'] = action2;
                
                /*object['Conversion_Time_From_GI_to_Column__c'] = otherFiedls['Conversion_Time_From_GI_to_Column__c'];
            object['Credit_Facility_given_to_dealer_by_Pipe__c'] = otherFiedls['Credit_Facility_given_to_dealer_by_Pipe__c'];
            object['Depth_of_Borewell_max_in_ft__c'] = otherFiedls['Depth_of_Borewell_max_in_ft__c'];
            object['Depth_of_Borewell_min_in_ft__c'] = otherFiedls['Depth_of_Borewell_min_in_ft__c'];
            object['Electricity_connection__c'] = otherFiedls['Electricity_connection__c'];
            object['Hdpe_fast_moving_Size_Inch__c'] = otherFiedls['Hdpe_fast_moving_Size_Inch__c'];
            object['Type_of_Influencers_of_Dealer__c'] = otherFiedls['Type_of_Influencers_of_Dealer__c'];
             object['Hdpe_average_sale_price_mtr__c'] = otherFiedls['Hdpe_average_sale_price_mtr__c'];*/
                obj.push(object);
            }
        }
        debugger;
        
        console.log(JSON.stringify(obj));
        action.setParams({
            'columnDealerSurvey' : obj
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var serverResponse = response.getReturnValue();
            
            if (state == 'SUCCESS') {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type" : "success",
                    "title": "Success!",
                    "message": "The record has been saved successfully."
                });
                toastEvent.fire();
                $A.get("e.force:closeQuickAction").fire();
            } else if (state == 'ERROR') {
                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                // Display the message
                console.error('message is ' + message);
                console.log('coming error message ' + message);
            }
            component.set('v.Spinner',false);
        });
        if(obj.length > 0){
            $A.enqueueAction(action);
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type" : "information",
                "title": "Note!",
                "message": "No product seleted to save."
            });
            toastEvent.fire();
            component.set('v.Spinner',false);
        }
    },
    showToast : function(component,event,helper,msg,type){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            'type' : type,
            "message": msg
        });
        toastEvent.fire();
    }
    
})
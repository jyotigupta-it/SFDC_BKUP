({
    doInit : function(component, event, helper) { 
        
        var otherFieldValues = {};
        otherFieldValues['Conversion_Time_From_GI_to_Column__c'] = '';
        otherFieldValues['Credit_Facility_given_to_dealer_by_Pipe__c'] = '';
        otherFieldValues['Depth_of_Borewell_max_in_ft__c'] = 0;
        otherFieldValues['Depth_of_Borewell_min_in_ft__c'] = 0;
        otherFieldValues['Electricity_connection__c'] = '';
        otherFieldValues['Hdpe_fast_moving_Size_Inch__c'] = '';
        otherFieldValues['Total_shop_turnover_of_all_the_items_in__c'] = '';
        otherFieldValues['Fast_Moving_Size__c'] = '';
        otherFieldValues['Color_of_tank__c'] = '';
        otherFieldValues['Agri_fast_moving_Size_Inch__c'] = '';
        otherFieldValues['Casting_fast_moving_Size_Inch__c'] = '';
        otherFieldValues['Column_fast_moving_Size_Inch__c'] = '';
       // otherFieldValues['Fast_Moving_Size__c'] = '';
        //otherFieldValues['Type_of_Influencers_of_Dealer__c'] = undefined;
        otherFieldValues['Hdpe_average_sale_price_mtr__c'] = '';
        component.set('v.otherFields',otherFieldValues);
        component.set('v.Spinner',true);
        // get the fields API name and pass it to helper function  
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var objDetails = {'sobjectType' : 'Column_dealer_Survey__c'};//component.get("v.objDetail"); 
        // call the helper function
        helper.fetchPicklistValues(component,objDetails,controllingFieldAPI, dependingFieldAPI);
        helper.getOtherPicklistValues(component,event,helper,'Conversion_Time_From_GI_to_Column__c');
        helper.getOtherPicklistValues(component,event,helper,'Credit_Facility_given_to_dealer_by_Pipe__c');
        helper.getOtherPicklistValues(component,event,helper,'Electricity_connection__c');
        helper.getOtherPicklistValues(component,event,helper,'Hdpe_fast_moving_Size_Inch__c');
        helper.getOtherPicklistValues(component,event,helper,'Type_of_Influencers_of_Dealer__c');
        helper.getOtherPicklistValues(component,event,helper,'Agri_fast_moving_Size_Inch__c');
        helper.getOtherPicklistValues(component,event,helper,'Casting_fast_moving_Size_Inch__c');
        helper.getOtherPicklistValues(component,event,helper,'Column_fast_moving_Size_Inch__c');
        helper.getOtherPicklistValues(component,event,helper,'Fast_Moving_Size__c');
       // helper.getOtherPicklistValues(component,event,helper,'Fast_Moving_Size__c');
        helper.getOtherPicklistValues(component,event,helper,'Color_of_tank__c');
        
        helper.getFieldLabelWithApiHelper1(component, event, helper);
    },
    
    onControllerFieldChange: function(component, event, helper) {   
        debugger;
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        var res = component.get('v.prodList');
        //alert(event.getSource().get('v.name'));
        if (controllerValueKey != '--- None ---') {
            var prodList = component.get('v.prodList');
            var repeatedValue = 0;
            for(var x in prodList){
                if(prodList[x].objDetail.Product_sold_by_dealer__c == controllerValueKey){
                    repeatedValue += 1;
                }
            }
            if(repeatedValue < -1){
                alert(controllerValueKey + ' already selected, please select other values!...')
            }
            else{
                var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
                
                if(ListOfDependentFields.length > 0){
                    component.set("v.bDisabledDependentFld" , false);  
                    helper.fetchDepValues(component,event, ListOfDependentFields);    
                }else{
                    component.set("v.bDisabledDependentFld" , true); 
                    component.set("v.listDependingValues", [{ label: '--- None ---', value: '--- None ---' }]);
                    res[event.getSource().get('v.name')]['objDetail']['depFieldValues'] =  [{ label: '--- None ---', value: '--- None ---' }];
                    component.set('v.prodList',res);
                }  
            }
            
            
        } else {
            res[event.getSource().get('v.name')]['objDetail']['depFieldValues'] =  [{ label: '--- None ---', value: '--- None ---' }];
            component.set('v.prodList',res);
            component.set("v.listDependingValues", [{ label: '--- None ---', value: '--- None ---' }]);
            component.set("v.bDisabledDependentFld" , true);
        }
    },
    handleInfluencerChange : function(component,event,helper){
        var selectedOptionValue = event.getParam("value");
        var apiMap = [];
        var selectBrandList = component.get("v.selectedBrandNameList");
        var fieldMap = component.get("v.fieldLabelApiMap");
        var result = [];
        for (var key in selectedOptionValue) {
            var survey = {};
            for (var fieldMapKey in fieldMap) {
                let apiNameFromMap = fieldMap[fieldMapKey];               
                if (apiNameFromMap.includes(selectedOptionValue[key].split(' ')[0])) {
                    survey['apiName'] = apiNameFromMap;
                    survey['label'] = 'Influencer count - '+selectedOptionValue[key]+' in(num)';
                    survey['value'] = 0;
                    result.push(survey);
                    break;
                }
            }
        }
        component.set('v.influencerList',result);
    },
    
    handleValueChange : function(component, event, helper) { 
        debugger;
        // This will contain an array of the "value" attribute of the selected options
        var selectedOptionValue = event.getParam("value");
        debugger;
        //Update the Selected Values  selectedbrandashirvad
        component.set("v.selectedBrandNameList", selectedOptionValue);
        //component.set("v.selectedbrandashirvad", selectedOptionValue);
        console.log('selectedOptionValue ---- ' + selectedOptionValue);
        console.log('selectedBrandNameList ---- ' + component.get("v.selectedBrandNameList"));
        component.set("v.displayChildCmp", true);
        console.log('surveyListToInsert@@@@@@ ' + JSON.stringify(component.get("v.surveyListToInsert")));
        
        var apiMap = [];
        var selectBrandList = component.get("v.selectedBrandNameList");
        var fieldMap = component.get("v.fieldLabelApiMap");
        console.log('fieldMap****bbbbbbb**** *** ' + JSON.stringify(Object.keys(fieldMap)));
        let i = 0;
        
        var result = [];
        
        for (var key in selectBrandList) {
            var survey = {};
            survey['sobjectType'] = 'Column_dealer_Survey__c';
            console.log('selectBrandList *** ' + selectBrandList[key]);
            let selectBrandName = selectBrandList[key];
            
        if(selectBrandName == 'Vectus'){
             component.set("v.selectedbrandVectus", true);
        }
        if(selectBrandName == 'Supreme'){
             component.set("v.selectedbrandSupreme", true);
        }
        if(selectBrandName == 'Sintex'){
             component.set("v.selectedbrandSintex", true);
        }
        if(selectBrandName == 'Prince'){
             component.set("v.selectedbrandPrince", true);
        }
        if(selectBrandName == 'Plasto'){
             component.set("v.selectedbrandPlasto", true);
        }
         if(selectBrandName == 'Sudhakar'){
             component.set("v.selectedbrandSudhakar", true);
        }
         if(selectBrandName == 'Kaveri'){
             component.set("v.selectedbrandKaveri", true);
        }
         if(selectBrandName == 'Aquatech'){
             component.set("v.selectedbrandAquatech", true);
        }
            for (var fieldMapKey in fieldMap) {
                //  console.log('fieldMap****fieldMapKey**** *** ' + fieldMapKey);
                let apiNameFromMap = fieldMap[fieldMapKey];               
                if (apiNameFromMap.includes(selectBrandName.split(' ')[0])) {
                    survey[apiNameFromMap] = 0;
                    survey['fieldLabel'] =(selectBrandList[key] == 'Others')?'If-Others': 'Annual sales value-'+selectBrandList[key]+' in(LAKHS)';
                    survey['field'] =apiNameFromMap;
                    survey['Value'] = 0;
                    survey['value'] = (selectBrandList[key] == 'Others')?'': 0;
                    result.push(survey);
                    //    apiMap.push({key : selectBrandName, value : apiNameFromMap});
                    apiMap[i] = apiNameFromMap;
                    i++;
                    break;
                }
            }
        }
        console.log('result **** ' + JSON.stringify(result));
        console.log('apiMap **** ' + JSON.stringify(apiMap));
        var res = component.get('v.prodList');
        if(selectedOptionValue.length > 0){
            res[event.getSource().get('v.name')]['showInput'] = true;
        }
        else{
            res[event.getSource().get('v.name')]['showInput'] = false;
        }
        res[event.getSource().get('v.name')]['surveyListToInsert'] = result;
        component.set('v.prodList',res);
        component.set("v.surveyListToInsert",result);
        component.set("v.selectedBrandNameInputList", apiMap);
        //  component.set("v.brandSelectedValueApiMap", apiMap);
        component.set("v.displayChildCmp", true);
    },
    
    surveySaveMethod : function(component, event, helper) {
        var objectfields= component.get('v.prodList');
        debugger;
        var fieldMandatoryError = false;
        var fieldMandatoryValueError = false;
        for(var obj in objectfields){
            var fieldNames = '';
            if(objectfields[obj]['objDetail']['Product_sold_by_dealer__c'] !='Not applicable'){
                if(objectfields[obj]['surveyListToInsert'] == undefined  ){
                    fieldMandatoryError = true;
                }
            }
            else if(objectfields[obj]['surveyListToInsert'] != undefined){
                for(var x in objectfields[obj]['surveyListToInsert']){
                    for(var y in objectfields[obj]['surveyListToInsert'][x]){
                        if(y != 'sobjectType'){
                            if(y == 'If_Others__c' && (objectfields[obj]['surveyListToInsert'][x]['value'] == '' || objectfields[obj]['surveyListToInsert'][x]['value'] == undefined) ){
                                fieldMandatoryValueError = true;
                            }
                            if(objectfields[obj]['surveyListToInsert'][x]['value'] <= 0){
                                fieldMandatoryValueError = true;
                            }
                        }
                    }
                }
            }
        }
        var otherFields = component.get('v.otherFields');
        debugger;
        var error = false;
        var fieldNames = '';
        
        if(otherFields['Credit_Facility_given_to_dealer_by_Pipe__c'] == undefined || otherFields['Credit_Facility_given_to_dealer_by_Pipe__c'] == '' || otherFields['Credit_Facility_given_to_dealer_by_Pipe__c'] == 0 || otherFields['Credit_Facility_given_to_dealer_by_Pipe__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Credit_Facility_given_to_dealer_by_Pipe__c';
            else
                fieldNames += ','+'Credit_Facility_given_to_dealer_by_Pipe__c';
            
        }
        if(otherFields['Depth_of_Borewell_min_in_ft__c'] == undefined || otherFields['Depth_of_Borewell_min_in_ft__c'] == '' || otherFields['Depth_of_Borewell_min_in_ft__c'] == 0 || otherFields['Depth_of_Borewell_min_in_ft__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Depth_of_Borewell_min_in_ft__c';
            else
                fieldNames += ','+'Depth_of_Borewell_min_in_ft__c';
            
        }
        if(otherFields['Depth_of_Borewell_max_in_ft__c'] == undefined || otherFields['Depth_of_Borewell_max_in_ft__c'] == '' || otherFields['Depth_of_Borewell_max_in_ft__c'] == 0 || otherFields['Depth_of_Borewell_max_in_ft__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Depth_of_Borewell_max_in_ft__c';
            else
                fieldNames += ','+'Depth_of_Borewell_max_in_ft__c';
            
        }
        if(otherFields['Electricity_connection__c'] == undefined || otherFields['Electricity_connection__c'] == '' || otherFields['Electricity_connection__c'] == 0 || otherFields['Electricity_connection__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Electricity_connection__c';
            else
                fieldNames += ','+'Electricity_connection__c';
            
        }
        if(otherFields['Total_shop_turnover_of_all_the_items_in__c'] == undefined || otherFields['Total_shop_turnover_of_all_the_items_in__c'] == '' || otherFields['Total_shop_turnover_of_all_the_items_in__c'] == 0 || otherFields['Total_shop_turnover_of_all_the_items_in__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Total_shop_turnover_of_all_the_items_in__c';
            else
                fieldNames += ','+'Total_shop_turnover_of_all_the_items_in__c';
            
        }
        if(otherFields['Type_of_Influencers_of_Dealer__c'] == undefined || otherFields['Type_of_Influencers_of_Dealer__c'] == '' || otherFields['Type_of_Influencers_of_Dealer__c'] == 0 || otherFields['Type_of_Influencers_of_Dealer__c'] == '--None--'){
            error = true;
            if(fieldNames == '')
                fieldNames = 'Type_of_Influencers_of_Dealer__c';
            else
                fieldNames += ','+'Type_of_Influencers_of_Dealer__c';
            
        }
        
        if(fieldMandatoryError)
            helper.showToast(component,event,helper,'Please select Name Of Brands for 7 section','error');
        else if(fieldMandatoryValueError)
            helper.showToast(component,event,helper,'Please enter annual sales value greater than 0','error');
            else if(error == true)
                helper.showToast(component,event,helper,'Please fill all mandatory fields ','error');
                else
                    helper.surveySaveHelper(component,event,helper);
        
    },
    addProducts : function(component,event,helper){
        var temp = component.get('v.prodList');
        var res = {};
        res['index'] = temp.length;
        res['controllinglFieldValues'] = component.get("v.listControllingValues");
        temp.push(res);
        component.set('v.prodList',temp);
    },
    removeProducts :  function(component,event,helper){
        debugger;
        var temp = component.get('v.prodList');
        temp.splice(event.getSource().get('v.name'));
        component.set('v.prodList',temp);
    },
    cancel : function(){
        $A.get("e.force:closeQuickAction").fire();
    },
   onChangeOfProduct : function(component,event,helper){
        if(event.getSource().get('v.value')=='Water tank'){
            component.set('v.truthy',true);
            
        }else{
            component.set('v.truthy',false);
            
        }
    },
     /* onChangeOfPipes : function(component,event,helper){
        if(event.getSource().get('v.value')!='Water tank'){
            component.set('v.truthy1',true);
            
        }else{
            component.set('v.truthy1',false);
            
        }
    },*/
})
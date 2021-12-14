({
    saveMasterQuestionHelper: function (component, event, helper) {

        let feedbackStatus;
        var surveyDetailListToInsert = [];
        let masterQuestionList = component.get("v.masterQuestionList");
        

        /* Logic to mandate status fields, starts from here */
        for (let index = 0; index < masterQuestionList.length; index++) {
            // checking questionOrder here to validate mandatory because this is the last question, cannot can on click of next button.
            if (masterQuestionList[index].mandatory && masterQuestionList[index].questionOrder == 6 && masterQuestionList[index].Response == '') {
                this.showMessage('Please select status', 'warning', 'pester', 5000);
                return false;
            }
        }
        /* Logic to mandate status fields, ends here */

        for (let index = 0; index < masterQuestionList.length; index++) {
            let tempSurveyObject = { 'sobjectType': 'Survey_Details__c' };
            tempSurveyObject['Master_Questions__c'] = masterQuestionList[index].recordId;
            tempSurveyObject['Account__c'] = component.get("v.recordId");
            tempSurveyObject['NPS__c'] = component.get("v.npsId");

            if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '001' &&
                masterQuestionList[index].lookupEntry.length > 0) {

                var concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].lookupEntry.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].lookupEntry[innerLoopIndex].value.Name);
                }
                tempSurveyObject['Response__c'] = concatLookupValue.join('\n');
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '002' &&
                masterQuestionList[index].secondQuesResponseStore.length > 0) {
                // Second question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].secondQuesResponseStore.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].secondQuesResponseStore[innerLoopIndex].value);
                }
                tempSurveyObject['Response__c'] = concatLookupValue.join('\n');
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '003' &&
                masterQuestionList[index].subQuestionList.length > 0) {
                // 4th question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].subQuestionList.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].subQuestionList[innerLoopIndex].label
                        + ':' + masterQuestionList[index].subQuestionList[innerLoopIndex].subQuesRating);
                }
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].subQuestionList.length; innerLoopIndex++) {
                    let labelName = masterQuestionList[index].subQuestionList[innerLoopIndex].label;
                    concatLookupValue.push(labelName + '(Top Brand)'
                        + ':' + masterQuestionList[index].subQuestionList[innerLoopIndex].subQuesTopBrandRating); 
                }
                tempSurveyObject['Response__c'] = concatLookupValue.join('\n');
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '004' &&
                masterQuestionList[index].thirdQuesResponseStore.length > 0) {
                // Third question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].thirdQuesResponseStore.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].thirdQuesResponseStore[innerLoopIndex].value);
                }
                tempSurveyObject['Response__c'] = concatLookupValue.join('\n');
            } else {
                tempSurveyObject['Response__c'] = masterQuestionList[index].Response;
                if (masterQuestionList[index].Response == 'Open' || masterQuestionList[index].Response == 'Onhold'
                    || masterQuestionList[index].Response == 'Closed') {
                    feedbackStatus = masterQuestionList[index].Response;
                }
            }
            surveyDetailListToInsert.push(tempSurveyObject);
        }
        console.log('surveyDetailListToInsert55555555 ' + JSON.stringify(surveyDetailListToInsert));
        console.log('surveyDetailListToInsert66666666 ' + JSON.stringify(component.get("v.masterQuestionList")));      

        // Logic to extract data and prepare data to insert Survey Detail child record(In Answer Options Object)
        var surveyDetailChildListToInsert = [];
        for (let index = 0; index < masterQuestionList.length; index++) {

            let tempSurveyChildObject = {
                'Master_Questions__c': '',
                'Options': '', 'Type': '',
                'Response__c': ''
            };
            tempSurveyChildObject['Master_Questions__c'] = masterQuestionList[index].recordId;
            tempSurveyChildObject['Options'] = masterQuestionList[index].Options;
            tempSurveyChildObject['Type'] = masterQuestionList[index].Type;

            if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '001' &&
                masterQuestionList[index].lookupEntry.length > 0) {

                var concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].lookupEntry.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].lookupEntry[innerLoopIndex].value);
                }
                tempSurveyChildObject['Response__c'] = concatLookupValue;
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '002' &&
                masterQuestionList[index].secondQuesResponseStore.length > 0) {
                // Second question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].secondQuesResponseStore.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].secondQuesResponseStore[innerLoopIndex]);
                }
                tempSurveyChildObject['Response__c'] = concatLookupValue;
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '003' &&
                masterQuestionList[index].subQuestionList.length > 0) {
                // 4th question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].subQuestionList.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].subQuestionList[innerLoopIndex]);
                }
                tempSurveyChildObject['Response__c'] = concatLookupValue;
            } else if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '004' &&
                masterQuestionList[index].thirdQuesResponseStore.length > 0) {
                // 3rd question value extract
                let concatLookupValue = [];
                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].thirdQuesResponseStore.length; innerLoopIndex++) {
                    concatLookupValue.push(masterQuestionList[index].thirdQuesResponseStore[innerLoopIndex]);
                }
                tempSurveyChildObject['Response__c'] = concatLookupValue;
            } else {
                tempSurveyChildObject['Response__c'] = masterQuestionList[index].Response;
            }
            surveyDetailChildListToInsert.push(tempSurveyChildObject);
        }
        console.log('surveyDetailChildListToInsert after modification ', JSON.stringify(surveyDetailChildListToInsert));


        var action = component.get("c.saveSurveyDetailsMethod");
        action.setParams({
            'surveyDetailList': surveyDetailListToInsert,
            'surveyDetailChildList': JSON.stringify(surveyDetailChildListToInsert),
            'selectedTopBrandName': component.get("v.topBrandName"),
            'selectedTopBrandRating': component.get("v.ratingForTopBrand"),
            'accountId': component.get("v.recordId"),
            'selectedFeedbackStatus' : feedbackStatus,
            'lookupValueWithLabel' : JSON.stringify(component.get("v.selectedBrandLabelWithValue"))
        });
        action.setCallback(this, function (response) {
            var status = response.getState();

            if (status == 'SUCCESS') {
                this.showMessage('Survey Details was created.', 'success', 'pester', 5000);
                $A.get("e.force:closeQuickAction").fire();

            } else if (status == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        console.log('errorMessage in saveMasterQuestion ' + errorMessage);
                        this.showMessage(errorMessage, 'error', 'pester', 5000);
                        return false;
                    }
                } else {
                    console.log("Unknown error doInit npsquestion");
                }
            }
        });
        $A.enqueueAction(action);
    },


    showMessage: function (msg, msgtype, display_mode, duration) {

        if (!duration) {
            duration = 5000;
        }
        //display_mode: dismissible, pester, sticky 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            message: msg,
            messageTemplate: msg,
            duration: duration,
            key: 'info_alt',
            type: msgtype,
            mode: display_mode
        });
        toastEvent.fire();
    }
})
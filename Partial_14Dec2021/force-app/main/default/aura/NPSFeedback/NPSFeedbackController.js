({
    doInit: function (component, event, helper) {
        // Display 1st question when component loads
        component.set("v.displayNextQuestion", 1);

        /* Logic to display Rating values for 2nd question, Start from here */
        let ratingListToDisplay = [];
        for (let index = 1; index <= 10; index++) {
            let element = { 'label': index, 'value': index };
            ratingListToDisplay.push(element);
        }
        component.set("v.ratingList", ratingListToDisplay);
        /* Logic to display Rating values for 2nd question, End here */

        var action = component.get("c.fetchQuestions");
        var accId = component.get("v.recordId");

        action.setParams({ 'accountId': accId });
        action.setCallback(this, function (response) {
            var status = response.getState();

            if (status == 'SUCCESS') {
                var masterQuestionList = response.getReturnValue();

                if (!$A.util.isEmpty(masterQuestionList)) {
                    component.set("v.npsId", masterQuestionList[0].npsId);
                }

                if ($A.util.isEmpty(masterQuestionList)) {
                    helper.showMessage('Please assign NPS to this account first.', 'error', 'pester', 5000);
                }

                console.log('masterQuestionList' + JSON.stringify(masterQuestionList));

                for (let index = 0; index < masterQuestionList.length; index++) {

                    let element = masterQuestionList[index].Options;
                    if (element != undefined) {
                        var splitArray = [];
                        var pickListValueArray = [];
                        var pickListValueArrayNonCustomQues = [];
                        var secondTempArray = [];
                        var thirdQuesTempArray = [];
                        let subQuesList = [];
                        splitArray = element.split(",");
                        for (let index = 0; index < splitArray.length; index++) {
                            let tempArray = { 'label': splitArray[index], 'value': splitArray[index] };
                            pickListValueArray.push(tempArray);
                        }
                        // Add empty list in each question at each index
                        masterQuestionList[index]['OptionsVal'] = pickListValueArray;
                        masterQuestionList[index]['lookupEntry'] = pickListValueArrayNonCustomQues;
                        masterQuestionList[index]['secondQuesResponseStore'] = secondTempArray;
                        masterQuestionList[index]['thirdQuesResponseStore'] = thirdQuesTempArray;
                        masterQuestionList[index]['subQuestionList'] = subQuesList;
                    }
                    if (masterQuestionList[index].Type == 'Custom' && masterQuestionList[index].Options == '001') {
                        var pickListValueLookupArray = [];
                        for (let index = 0; index < $A.get("$Label.c.Number_Of_NPS_Lookup"); index++) {
                            let tempArrayLookup = { 'value': 0 };
                            pickListValueLookupArray.push(tempArrayLookup);
                        }
                        masterQuestionList[index]['lookupEntry'] = pickListValueLookupArray;
                    }
                    // Logic to add sub questions for 4th question
                    if (masterQuestionList[index].Type == 'Custom' && masterQuestionList[index].Options == '003') {
                        /* Logic to initialize subquestions of 4th question, starts from here  */
                        let subQuesList = [{ 'label': 'Brand awareness among customers', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Availability at retail shops', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Quality', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Value for money', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Products easy to install', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Company service and support', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Why ashirvad is not considered in top three brands?', 'subQuesRating': '', 'subQuesTopBrandRating': '' },
                        { 'label': 'Why Rating less than 8', 'subQuesRating': '', 'subQuesTopBrandRating': '' } // this should be last question to display mandatory error message on click of 'Save' button
                        ];
                        /* Logic to initialize subquestions of 4th question, end here  */

                        masterQuestionList[index]['subQuestionList'] = subQuesList;
                    }

                }
                component.set("v.masterQuestionList", masterQuestionList);

            } else if (status == 'ERROR') {
                var errors = response.getError();
                var errorMessage = '';
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                        console.log('errorMessage doInit npsFeedback ' + errorMessage);
                        helper.showMessage(errorMessage, 'error', 'pester', 5000);
                        return false;
                    }
                } else {
                    console.log("Unknown error doInit npsquestion");
                }
            }
        });
        $A.enqueueAction(action);
    },

    saveMasterQuestion: function (component, event, helper) {
        helper.saveMasterQuestionHelper(component, event, helper);
    },

    showPreviousQuestion: function (component, event, helper) {
        component.set("v.displayNextQuestion", component.get("v.displayNextQuestion") - 1);
    },

    showNextQuestion: function (component, event, helper) {

        console.log('selectedLookupValue--------- ', JSON.stringify(component.get("v.selectedLookupValueDisplay")));
        
        let masterQuestionListToValidateLookup = component.get("v.masterQuestionList");
        console.log('masterQuestionListToValidateLookup @@ ', JSON.stringify(masterQuestionListToValidateLookup));
        

        let indexToSetQuesValue = component.get("v.displayNextQuestion") - 1; // subtract 1 to get previously selected question index.
        let quesValueOnIndex = masterQuestionListToValidateLookup[indexToSetQuesValue].Options; // return Options value of the previous question bwfore navigating to next question.

        let masterQuestionList = component.get("v.masterQuestionList");

        /* Logic to mandate all lookup fields of 1st question, starts from here */
        if (quesValueOnIndex == '001') {
            let checkDuplicateLookupValueArray = [];
            for (let index = 0; index < masterQuestionListToValidateLookup.length; index++) {
                if (masterQuestionListToValidateLookup[index].mandatory) {
                    for (let indexInnerLoop = 0; indexInnerLoop < masterQuestionListToValidateLookup[index].lookupEntry.length; indexInnerLoop++) {
                        if (masterQuestionListToValidateLookup[index].lookupEntry[indexInnerLoop].value == 0) {
                            helper.showMessage('Please select all lookup fields', 'warning', 'pester', 5000);
                            return false;
                        }
                        // Store selected lookup value Id to check duplicate value
                        if (masterQuestionListToValidateLookup[index].lookupEntry[indexInnerLoop].value.Id) {
                            checkDuplicateLookupValueArray.push(masterQuestionListToValidateLookup[index].lookupEntry[indexInnerLoop].value.Id);
                        }
                    }
                }
            }
            // To check duplicate lookup value and dislay error message if duplicate values found
            if (new Set(checkDuplicateLookupValueArray).size !== checkDuplicateLookupValueArray.length) {
                helper.showMessage('Please select different competitors', 'warning', 'pester', 5000);
                return false;                          
            }
        }
        /* Logic to mandate all lookup fields of 1st question, End here */

        // Logic to store 3rd question values in master question list in 'thirdQuesResponseStore' attribute before it get reset because of next page index change.
        if (quesValueOnIndex == '004') {
            let thirdQuesValues = component.get("v.captureReasonForEachBrand");
            let addThirdQuesValueToMasterList = [];
            for (let index = 0; index < masterQuestionList.length; index++) {
                // If block to add selected value of previous question at particular index of that question in masterQuestion list
                if (index == indexToSetQuesValue) {
                    for (let indexInner = 0; indexInner < thirdQuesValues.length; indexInner++) {
                        addThirdQuesValueToMasterList.push({ 'value': thirdQuesValues[indexInner].thirdQuesResponse });
                    }
                    masterQuestionList[index]['thirdQuesResponseStore'] = addThirdQuesValueToMasterList;
                    component.set("v.masterQuestionList", masterQuestionList);
                }
            }
        }

        // Logic to store 2nd question picklist values in master question list in 'secondQuesResponseStore' attribute.
        if (quesValueOnIndex == '002') {
            let addSecQuesValueToMasterList = [];
            let selectedRatingOfLookups = [];
            let selectedRatingOfLookupsTemp = [];
            let selectedRatingAgainstBrandMap = [];
            let selectedRatingAgainstBrandMapTemp = [];
            let secondMax;
            let ashirvadRatingValue;
            let secondQuesVales = component.get("v.selectedLookupValueDisplay");
            for (let index = 0; index < masterQuestionList.length; index++) {
                // If block to add selected value of previous question at particular index of that question in masterQuestion list
                if (index == indexToSetQuesValue) {
                    for (let indexInner = 0; indexInner < secondQuesVales.length; indexInner++) {

                        addSecQuesValueToMasterList.push({ 'value': secondQuesVales[indexInner].secondQuesResponse });
                        selectedRatingOfLookups.push(parseInt(secondQuesVales[indexInner].secondQuesResponse));                       
                        selectedRatingAgainstBrandMap.push({ [secondQuesVales[indexInner].secondQuesResponse]: secondQuesVales[indexInner].label });
                        if (secondQuesVales[indexInner].label != undefined && (secondQuesVales[indexInner].label).includes($A.get("$Label.c.Ashirvad_Top_Brand"))) {
                            component.set("v.ratingForAshirvadBrand", parseInt(secondQuesVales[indexInner].secondQuesResponse)); // capturing rating for lookup which has Ashirvad as a keyword.                           
                            component.set("v.topBrandName", secondQuesVales[indexInner].label);
                        }
                    }
                    masterQuestionList[index]['secondQuesResponseStore'] = addSecQuesValueToMasterList;
                    component.set("v.masterQuestionList", masterQuestionList);
                }
            }
            component.set("v.selectedBrandLabelWithValue", selectedRatingAgainstBrandMap); // for testing

            /* set highest selected value corresponding to lookup value in 'ratingForTopBrand' */
            let highestRatingValue = Math.max.apply(null, selectedRatingOfLookups);

            /* Logic to find 2nd highest number in array, starts from here */
            ashirvadRatingValue = component.get("v.ratingForAshirvadBrand");
            selectedRatingOfLookupsTemp = selectedRatingOfLookups;
            // If Ashirvad is top most brand then find 2nd max brand rating
            if (ashirvadRatingValue == highestRatingValue) {
                let maxi = selectedRatingOfLookupsTemp.indexOf(highestRatingValue);
                selectedRatingOfLookupsTemp[maxi] = -Infinity; // replace max in the array with -infinity
                secondMax = Math.max.apply(null, selectedRatingOfLookupsTemp); // get the new max 
            } else { // If Ashirvad is 2nd top brand then find 2nd max brand rating apart from Ashirvad
                let maxi = selectedRatingOfLookupsTemp.indexOf(ashirvadRatingValue);
                selectedRatingOfLookupsTemp[maxi] = -Infinity; // replace max in the array with -infinity
                secondMax = Math.max.apply(null, selectedRatingOfLookupsTemp); // get the new max 
            }
            /* Logic to find 2nd highest number in array, end here */

            if (highestRatingValue != undefined) {
                component.set("v.ratingForTopBrand", highestRatingValue);
            }

            // To set highest brand name based on top rating if Ashirvad is not present in selected values
            for (const iterator of selectedRatingAgainstBrandMap) {
                if (iterator[highestRatingValue] != undefined && !iterator[highestRatingValue].includes($A.get("$Label.c.Ashirvad_Top_Brand"))) {
                    component.set("v.topBrandName", iterator[highestRatingValue]);
                    component.set("v.secondTopBrandName", iterator[highestRatingValue]);
                }
            }

            /* To set highest brand name based on top rating if Ashirvad is present in selected values, starts here */
            let ashirvadRating = component.get("v.ratingForAshirvadBrand");
            if (ashirvadRating != undefined) {
                let secBrandNameTemp;
                for (const iterator of selectedRatingAgainstBrandMap) {
                    if (iterator[secondMax] != undefined) {
                        secBrandNameTemp = iterator[secondMax];
                        component.set("v.secondTopBrandName", secBrandNameTemp);
                    }

                    if (iterator[ashirvadRating] != undefined && iterator[ashirvadRating].includes($A.get("$Label.c.Ashirvad_Top_Brand"))) {
                        component.set("v.topBrandName", iterator[ashirvadRating]);
                        component.set("v.ratingForTopBrand", ashirvadRating);
                    }
                }
            }
            /* To set highest brand name based on top rating if Ashirvad is present in selected values, end here */
        }

        /* Logic to mandate all dependent fields of lookup means 2nd question value, starts from here */
        if (quesValueOnIndex == '002') {
            let masterQuestionTempValidateList = component.get("v.masterQuestionList");
            let duplicateCompetitorsRatingArray = [];
            for (let index = 0; index < masterQuestionTempValidateList.length; index++) {
                if (masterQuestionTempValidateList[index].mandatory) {
                    for (let indexInnerLoop = 0; indexInnerLoop < masterQuestionTempValidateList[index].secondQuesResponseStore.length; indexInnerLoop++) {
                        if (masterQuestionTempValidateList[index].secondQuesResponseStore[indexInnerLoop].value == 0) {
                            helper.showMessage('Please select all field values', 'warning', 'pester', 5000);
                            return false;
                        }
                        if (masterQuestionTempValidateList[index].secondQuesResponseStore[indexInnerLoop].value) {
                            duplicateCompetitorsRatingArray.push(masterQuestionTempValidateList[index].secondQuesResponseStore[indexInnerLoop].value);
                        }
                    }
                    
                    // To check duplicate Rating value in 2nd question and dislay error message if duplicate values found
                    if (new Set(duplicateCompetitorsRatingArray).size !== duplicateCompetitorsRatingArray.length) {
                        helper.showMessage('Please select different rating', 'warning', 'pester', 5000);
                        return false;                          
                    }
                }
            }
            
        }
        /* Logic to mandate all dependent fields of lookup means 2nd question value, ends here */

        /* Logic to mandate 4th question fields, starts from here */
        if (quesValueOnIndex == '003') {
            let setWhyValueIfRatingLow;
            let whyNotAshirvadSelected;
            for (let index = 0; index < masterQuestionListToValidateLookup.length; index++) {
                if (masterQuestionListToValidateLookup[index].mandatory) {
                    for (let indexInnerLoop = 0; indexInnerLoop < masterQuestionListToValidateLookup[index].subQuestionList.length - 2; indexInnerLoop++) {
                        // If Ashirvad is not in top brand list then check mandatory rating fields for top brand only.
                        if (component.get("v.topBrandName") != $A.get("$Label.c.Ashirvad_Top_Brand")) {
                            if ((masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesRating == '' ||
                                masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesRating == '--None--')) {
                                helper.showMessage('Please select rating', 'warning', 'pester', 5000);
                                return false;
                            }
                        } else { // If Ashirvad is present in top brand list then check mandatory rating fields for Ashirvad and top brand.
                            if ((masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesTopBrandRating == '' ||
                                masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesTopBrandRating == '--None--') ||
                                (masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesRating == '' ||
                                    masterQuestionListToValidateLookup[index].subQuestionList[indexInnerLoop].subQuesRating == '--None--')) {
                                helper.showMessage('Please select rating', 'warning', 'pester', 5000);
                                return false;
                            }
                        }
                    }

                    // If block to get condition based field value if rating is less than 8
                    if (component.get("v.ratingForAshirvadBrand") < $A.get("$Label.c.Display_field_based_on_rating")) {
                        setWhyValueIfRatingLow = component.find("conditionBasedQues").get("v.value");
                    }
                    // display error message for 'Why Rating less than 8' question if Ashirvad rating is less than 8
                    if ((component.get("v.ratingForAshirvadBrand") < $A.get("$Label.c.Display_field_based_on_rating")) && ($A.util.isEmpty(setWhyValueIfRatingLow))) {
                        helper.showMessage('Please specify reason for less rating', 'warning', 'pester', 5000);
                        return false;
                    }

                    // Check mandatory if Ashirvad is not selected in top brand list.
                    if (component.get("v.topBrandName") != $A.get("$Label.c.Ashirvad_Top_Brand")) {
                        whyNotAshirvadSelected = component.find("whyNotAshirvad").get("v.value");                        
                        if ($A.util.isEmpty(whyNotAshirvadSelected)) {
                            helper.showMessage('Please fill mandatory fields', 'warning', 'pester', 5000);
                            return false;
                        }
                    }
                }
            }
        }
        /* Logic to mandate 4th question fields, End here */

        /* Logic to mandate 3rd question value, starts from here */
        if (quesValueOnIndex == '004') {
            let masterQuestionTempValidateList = component.get("v.masterQuestionList");
            for (let index = 0; index < masterQuestionTempValidateList.length; index++) {
                if (masterQuestionTempValidateList[index].mandatory) {
                    for (let indexInnerLoop = 0; indexInnerLoop < masterQuestionTempValidateList[index].thirdQuesResponseStore.length; indexInnerLoop++) {
                        if (masterQuestionTempValidateList[index].thirdQuesResponseStore[indexInnerLoop].value == 0) {
                            helper.showMessage('Please select all field values', 'warning', 'pester', 5000);
                            return false;
                        }
                    }
                }
            }
        }
        /* Logic to mandate 3rd question value, ends here */

        component.set("v.displayNextQuestion", component.get("v.displayNextQuestion") + 1);

        /* Logic to fetch selected Lookup value of 1st question and display in 2nd question, Start from here */

        let selectedLookupValueDisplay = component.get("v.selectedLookupValueDisplay");


        let selectedLookupValue = [];

        for (let index = 0; index < masterQuestionList.length; index++) {
            if (masterQuestionList[index].Type == 'Custom' &&
                masterQuestionList[index].Options == '001' &&
                masterQuestionList[index].lookupEntry.length > 0) {

                for (let innerLoopIndex = 0; innerLoopIndex < masterQuestionList[index].lookupEntry.length; innerLoopIndex++) {
                    var accountId = masterQuestionList[index].lookupEntry[innerLoopIndex].value.Id;
                    var accountName = masterQuestionList[index].lookupEntry[innerLoopIndex].value.Name;
                    let lookupSecondQuesValueTemp = { 'label': accountName, 'value': accountId, 'secondQuesResponse': 0 };
                    selectedLookupValue.push(lookupSecondQuesValueTemp);
                }
            }

        }
        component.set("v.selectedLookupValueDisplay", selectedLookupValue);
        component.set("v.masterQuestionList", masterQuestionList);

        /* Logic to fetch selected Lookup value of 1st question and display in 2nd question, End here */

        /* Logic to fetch selected Lookup value of 1st question and display in 3rd question as a label, Start from here */
        let selectedLookupVal = component.get("v.selectedLookupValueDisplay");
        let selecedLookupLabel = [];
        for (let indexInner = 0; indexInner < selectedLookupVal.length; indexInner++) {
            if (selectedLookupVal[indexInner].label) {
                selecedLookupLabel.push({ 'label': selectedLookupVal[indexInner].label, 'thirdQuesResponse': '' });
            }
        }
        component.set("v.captureReasonForEachBrand", selecedLookupLabel);
        /* Logic to fetch selected Lookup value of 1st question and display in 3rd question as a label, End here */
    }
})
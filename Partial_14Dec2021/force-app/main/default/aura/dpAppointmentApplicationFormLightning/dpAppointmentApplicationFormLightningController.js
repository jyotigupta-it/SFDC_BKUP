({
    doInit: function (component, event, helper) {
        component.set("v.Spinner", true);
        component.set("v.accountRecord", component.get("v.recordId"));
        var action = component.get("c.getAccountRecordDetails");
        action.setParams({ recordId: component.get("v.recordId") });
        var businesslineOptions = [];
        var partyTypeOptions = [];
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var responseVal = response.getReturnValue();
                component.set("v.wrapperObject", responseVal);
                console.log(
                    "wrapper-->" + JSON.stringify(component.get("v.wrapperObject"))
                );

                for (var i = 0; i < responseVal.businessLineOptions.length; i++) {
                    businesslineOptions.push({
                        class: "optionClass",
                        label: responseVal.businessLineOptions[i],
                        value: responseVal.businessLineOptions[i]
                    });
                }
                component.set("v.businessLineOptions", businesslineOptions);
                for (var i = 0; i < responseVal.partnerTypeOptions.length; i++) {
                    partyTypeOptions.push({
                        class: "optionClass",
                        label: responseVal.partnerTypeOptions[i],
                        value: responseVal.partnerTypeOptions[i]
                    });
                }

                component.set(
                    "v.mapOfRecordTypeNameANDId",
                    responseVal.map_RecordTypesAndName
                );
                component.set("v.partyTypeOptions", partyTypeOptions);
                component.set("v.gstValidated",responseVal.getGSTValidated);

                helper.AddDistributionPartner(component, event);

                window.setTimeout(
                    $A.getCallback(function () {
                        // Your async code here
                        component.set("v.Spinner", false);
                    }),
                    1500
                );
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        // log the error passed in to AuraHandledException
                        console.error("Error message: " + errors[0].message);
                        console.log("Error message: " + errors[0].message);
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title: "Error!",
                            type: "error",
                            message: "Error has occured. Please contact to your Admin!"
                        });
                        toastEvent.fire();
                    }
                } else {
                    console.log("Unknown error");
                }
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    callValidateGST: function(component, event, helper){
        component.set("v.Spinner", true);

        var countGST = component.get("v.wrapperObject.accountRef").VAT_CST_Number__c;
        //helper.callValidateGSTHelper(component, event);
        if(countGST===undefined){
            var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title: "Warning!",
                            type: "Warning",
                            message: "GST number is invalid, Please check you GST number"
                        });
                        toastEvent.fire();
                        component.set("v.Spinner", false);
        }else if(countGST.length<15){
            var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title: "Warning!",
                            type: "Warning",
                            message: "Please check you GST number. GST Number should be 15 Digits"
                        });
                        toastEvent.fire();
                        component.set("v.Spinner", false);
        }else{
            helper.callValidateGSTHelper(component, event);
        }
        
    },

    gstChanged: function(component){
        debugger;
        component.set("v.gstValidated",false);
    },

    handleAddDistributionPartnerClick: function (component, event, helper) {
        component.set("v.Spinner", true);
        helper.AddDistributionPartner(component, event);
        window.setTimeout(
            $A.getCallback(function () {
                // Your async code here
                component.set("v.Spinner", false);
            }),
            500
        );
    },
    
       handleKeyUp: function (component, event, helper) {
        var isEnterKey = evt.keyCode === 13;
        var queryTerm = cmp.find('enter-search').get('v.value');
        if (isEnterKey) {
            cmp.set('v.issearching', true);
            setTimeout(function() {
                alert('Searched for "' + queryTerm + '"!');
                cmp.set('v.issearching', false);
            }, 2000);
        }  
    },
 

    handleRemoveDistributionPartnerClick: function (component, event, helper) {
        component.set("v.Spinner", true);
        helper.RemoveDistributionPartner(component, event);
        window.setTimeout(
            $A.getCallback(function () {
                // Your async code here
                component.set("v.Spinner", false);
            }),
            500
        );
    },

    handlePartnerCategory: function (component, event, helper) {
        var accountRecord = component.get("v.wrapperObject.accountRef");
        if (accountRecord.Type_of_Partner__c === "Projects Partner") {
            component.set("v.projectPartnerRequired", true);
            component.set("v.distributionPartnerRequired", false);
        }
        if (accountRecord.Type_of_Partner__c === "Distributor Partner") {
            component.set("v.distributionPartnerRequired", true);
            component.set("v.projectPartnerRequired", false);
        }
    },

    handleSelect: function (component, event, helper) {
        component.set("v.Spinner", true);
        var businessActivityAndHistory = component.get(
            "v.wrapperObject.listBusinessActivityAndHistory"
        );

        component.set(
            "v.wrapperObject.listBusinessActivityAndHistory",
            businessActivityAndHistory
        );
        window.setTimeout(
            $A.getCallback(function () {
                // Your async code here
                component.set("v.Spinner", false);
            }),
            500
        );
    },

    handleValidateForm: function (component, event, helper) {
        component.set("v.Spinner", true);

        helper.handleValidateFormHelper(component, event);

        window.setTimeout(
            $A.getCallback(function () {
                component.set("v.Spinner", false);
            }),
            500
        );

        let validExpense = component.find('accountEmailId').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
    },

    handlereturnFormValidation: function (component, event, helper) {
        var checkError = event.getParam("hasError");
        var getformHasErrorArray = component.get("v.formHasError");
        if (checkError == true) {
            getformHasErrorArray.push(true);
        }
        var getElementIndex = getformHasErrorArray.indexOf(true);
        if (getElementIndex != -1) {
            component.set("v.validationStatus", true);
        } else {
            component.set("v.validationStatus", false);
        }
    },

    submitApplicationForm: function (component, event, helper) {
        component.set("v.Spinner", true);

        helper.handleValidateFormHelper(component, event);

        var getformHasErrorArray = component.get("v.formHasError");
        var getElementIndex = getformHasErrorArray.indexOf(true);
        if (getElementIndex != -1) {
            component.set("v.validationStatus", true);
        } else {
            component.set("v.validationStatus", false);
        }

        var checkFormValidationError = component.get("v.validationStatus");

        if (checkFormValidationError == true) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: "Error!",
                type: "error",
                message:
                    "Form page has erros. Please varify them before submitting the application."
            });
            toastEvent.fire();
        } else {
            /*var accountRecord = component.get("v.accountObj");
            //console.log('Account Record'+JSON.stringify(accountRecord));
            var distributionPartnerDetails = component.get(
                "v.listPartnerDetailsObject"
            );
            //console.log('distribution Partner'+JSON.stringify(distributionPartnerDetails));

            var projectPartnerDetails = component.get(
                "v.listProjectPartnerDetailsObject"
            );
            var ProprietorPartnersDirectors = component.get(
                "v.listProprietorPartnersDirectors"
            );
            var businessActivityAndHistory = component.get(
                "v.listBusinessActivityAndHistory"
            );
            var totalTurnOverInstance = component.get("v.totalTurnOverDP");
            var sisterConcerns = component.get("v.listSisterConcerns");
            var businessAreaAndStaffDetailsInstance = component.get(
                "v.businessAreaAndStaffDetailsDP"
            );
            var bankFinancialDetail = component.get("v.financialDetailDP");
            var bankloanDetails = component.get("v.loanDetails");
            var businessProposalQuestionsInstance = component.get(
                "v.businessProposalQuestionsDP"
            );
            var salesProjection = component.get("v.salesProjectionInstanceDP");
            var detailsOfSelfandFamilyMembers = component.get(
                "v.detailsOfSelfandFamily"
            );

            var check1 = component.get('v.upload_One_passport_Size');
            var check2 = component.get('v.copyOfPanCard');*/

            var action = component.get("c.saveData");
            action.setParams({recordId:component.get("v.recordId"),
            wrapperToUPSERT: component.get("v.wrapperObject")});
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Success!",
                        type: "success",
                        message: "DP Appointment Application Form has been submitted. Please upload all the required documents and then proceed."
                    });
                    toastEvent.fire();
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        recordId: component.get("v.recordId"),
                        slideDevName: "related"
                    });
                    navEvt.fire();
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            // log the error passed in to AuraHandledException
                            console.error("Error message: " + errors[0].message);
                            console.log("Error message: " + errors[0].message);
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title: "Error!",
                                type: "error",
                                message: "Error has occured. Please contact to your Admin!"
                            });
                            toastEvent.fire();
                        }
                    } else {
                        console.log("Unknown error");
                    }
                } else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(action);
            /*var action = component.get("c.saveDPAppointmentApplicationDetails");
            action.setParams({
                recordId: component.get("v.recordId"),
                accountObj: accountRecord,
                listPartnerDetailsObject: distributionPartnerDetails,
                listProjectPartnerDetailsObject: projectPartnerDetails,
                listProprietorPartnersDirector: ProprietorPartnersDirectors,
                listBusinessActivityAndHistory: businessActivityAndHistory,
                totalTurnOver: totalTurnOverInstance,
                listSisterConcerns: sisterConcerns,
                businessAreaAndStaffDetails: businessAreaAndStaffDetailsInstance,
                financialDetail: bankFinancialDetail,
                loanDetails: bankloanDetails,
                businessProposalQuestions: businessProposalQuestionsInstance,
                salesProjectionInstance: salesProjection,
                detailsOfSelfandFamily: detailsOfSelfandFamilyMembers,
                upload_One_passport_Size : check1,
                copyOfPanCard : check2,
                copyOfSalesTax : component.get('v.copyOfSalesTax'),
                copyOfShopLicense : component.get('v.copyOfShopLicense'),
                fourPhotographOfEstablishment : component.get('v.fourPhotographOfEstablishment'),
                copyOfLasttwoYearsAudited : component.get('v.copyOfLasttwoYearsAudited'),
                copyOfLastTwoYearsIncome : component.get('v.copyOfLastTwoYearsIncome'),
                lastOneYearBank : component.get('v.lastOneYearBank'),
                visitingCard : component.get('v.visitingCard'),
                securityCheques : component.get('v.securityCheques'),
                billingCommitmentSales : component.get('v.billingCommitmentDP'),
                dealerNetworkAdditionSales : component.get('v.dealerNetworkAdditionDP')
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: "Success!",
                        type: "success",
                        message: "DP Appointment Application Form has been submitted. Please upload all the required documents and then proceed."
                    });
                    toastEvent.fire();
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        recordId: component.get("v.recordId"),
                        slideDevName: "related"
                    });
                    navEvt.fire();
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            // log the error passed in to AuraHandledException
                            console.error("Error message: " + errors[0].message);
                            console.log("Error message: " + errors[0].message);
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title: "Error!",
                                type: "error",
                                message: "Error has occured. Please contact to your Admin!"
                            });
                            toastEvent.fire();
                        }
                    } else {
                        console.log("Unknown error");
                    }
                } else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(action);

            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId": component.get("v.recordId"),
                "slideDevName": "related"
            });
            navEvt.fire();*/
            component.set("v.Spinner", false); 
        }
        
    }
});
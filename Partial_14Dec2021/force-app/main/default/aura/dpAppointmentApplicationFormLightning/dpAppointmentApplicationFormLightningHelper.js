({
    AddDistributionPartner : function(component,event) {
        debugger;
        var partnerName = event.getParam("whichPartner"); 
        
        var mapOfRecordTypeName_and_Id = component.get("v.mapOfRecordTypeNameANDId");
        /*var distributionPartnerDetails = component.get("v.listPartnerDetailsObject");
        var projectPartnerDetails = component.get("v.listProjectPartnerDetailsObject");
        var ProprietorPartnersDirectors = component.get("v.listProprietorPartnersDirectors");
        var businessActivityAndHistory = component.get("v.listBusinessActivityAndHistory");
        var totalTurnOverInstance = component.get("v.totalTurnOver");
        var sisterConcerns = component.get("v.listSisterConcerns");
        var businessAreaAndStaffDetailsInstance = component.get("v.businessAreaAndStaffDetails");
        var bankFinancialDetail = component.get("v.financialDetail");
        var bankloanDetails = component.get("v.loanDetails");
        var businessProposalQuestionsInstance = component.get("v.businessProposalQuestions");
        var salesProjection = component.get("v.salesProjectionInstanceDP");
        var detailsOfSelfandFamilyMembers = component.get("v.detailsOfSelfandFamily");
        var billingCommitmentInstance = component.get("v.billingCommitment");
        var dealerNetworkAdditionInstance = component.get("v.dealerNetworkAddition");*/
        
        if(partnerName===undefined){
            
            let size_of_map = Object.keys(mapOfRecordTypeName_and_Id).length;
            var wrapperVal = component.get("v.wrapperObject");
            for(var recordTypeName in mapOfRecordTypeName_and_Id){
                if(recordTypeName === 'Distribution Partner' && wrapperVal.listPartnerDetailsObject.length==0){
                    var getVal = wrapperVal.listPartnerDetailsObject;
                    getVal.push({
                        'sobjectType': 'Partner_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id[recordTypeName],
                        'Distributor__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listPartnerDetailsObject",getVal);
                }else if(recordTypeName ==='Project Partner' && wrapperVal.listProjectPartnerDetailsObject.length==0){
                    var getVal = wrapperVal.listProjectPartnerDetailsObject;
                    getVal.push({
                        'sobjectType': 'Partner_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id[recordTypeName],
                        'Distributor__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listProjectPartnerDetailsObject",getVal);
                }else if(recordTypeName ==='Proprietor Details' && wrapperVal.listProprietorPartnersDirector.length==0){
                    var getVal = wrapperVal.listProprietorPartnersDirector;
                    getVal.push({
                        'sobjectType': 'Contact',
                        'RecordTypeId':mapOfRecordTypeName_and_Id[recordTypeName],
                        'AccountId':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listProprietorPartnersDirector",getVal);
                }/*else if(recordTypeName ==='Turnover Details'){
                    totalTurnOverInstance = {
                        'sobjectType': 'DP_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id[recordTypeName],
                        'Distributor__c':component.get("v.recordId")
                    }
                }*/else if(recordTypeName ==='Sister Concern' && wrapperVal.listSisterConcerns==0){
                    var getVal = wrapperVal.listSisterConcerns;
                    getVal.push({
                        'sobjectType': 'Partner_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Sister Concern'],
                        'Distributor__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listSisterConcerns",getVal);
                }/*else if(recordTypeName ==='Staff Details'){
                    businessAreaAndStaffDetailsInstance = {
                        'sobjectType': 'DP_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Staff Details'],
                        'Distributor__c':component.get("v.recordId")
                    };
                }else if(recordTypeName ==='Financial Details'){ 
                    bankFinancialDetail = {
                        'sobjectType': 'Bank_Details__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Financial Details'],
                        'Distributor__c':component.get("v.recordId")
                    };
                }*/else if(recordTypeName ==='Loan Details' && wrapperVal.loanDetails.length==0){
                    var getVal = wrapperVal.loanDetails;
                    getVal.push({
                        'sobjectType': 'Bank_Details__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Loan Details'],
                        'Distributor__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.loanDetails",getVal);
                }/*else if(recordTypeName ==='Business Proposal Questionaries'){
                    businessProposalQuestionsInstance = {
                        'sobjectType': 'DP_Detail__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Business Proposal Questionaries'],
                        'Distributor__c':component.get("v.recordId")
                    };
                }*/else if(recordTypeName ==='Sales Projection' && wrapperVal.salesProjectionInstance.length==0){
                    var getval= wrapperVal.salesProjectionInstance;
                    getval.push({
                        'sobjectType': 'Sales_Projection__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Projection'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.salesProjectionInstance",getval);
                }else if(recordTypeName ==='Data of Self and Family Deatails' && wrapperVal.detailsOfSelfandFamily.length==0){
                    var getval= wrapperVal.detailsOfSelfandFamily;
                    getval.push({
                        'sobjectType': 'Contact',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Data of Self and Family Deatails'],
                        'AccountId':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.detailsOfSelfandFamily",getval);
                }else if(recordTypeName ==='Account Assignment Group' && wrapperVal.listAccountAssignmentGroup.length==0){
                    var getval= wrapperVal.listAccountAssignmentGroup;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Account Assignment Group'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listAccountAssignmentGroup",getval);
                }else if(recordTypeName ==='Credit Control Area' && wrapperVal.listCreditControlArea.length==0){
                    var getval= wrapperVal.listCreditControlArea;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Credit Control Area'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listCreditControlArea",getval);
                }else if(recordTypeName ==='Cus Group' && wrapperVal.listCusGroup.length==0){
                    var getval= wrapperVal.listCusGroup;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Cus Group'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listCusGroup",getval);
                }else if(recordTypeName ==='Cus Pricing Procedure' && wrapperVal.listCusPricingProcedure.length==0){
                    var getval= wrapperVal.listCusPricingProcedure;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Cus Pricing Procedure'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listCusPricingProcedure",getval);
                }else if(recordTypeName ==='Delivering Plant' && wrapperVal.listDeliveringPlant.length==0){
                    var getval= wrapperVal.listDeliveringPlant;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Delivering Plant'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listDeliveringPlant",getval);
                }else if(recordTypeName ==='Delivery Priority' && wrapperVal.listDeliveryPriority.length==0){
                    var getval= wrapperVal.listDeliveryPriority;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Delivery Priority'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listDeliveryPriority",getval);
                }else if(recordTypeName ==='Distributor Channel' && wrapperVal.listDistributorChannel.length==0){
                    var getval= wrapperVal.listDistributorChannel;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Distributor Channel'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listDistributorChannel",getval);
                }else if(recordTypeName ==='Division' && wrapperVal.listDivison.length==0){
                    var getval= wrapperVal.listDivison;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Division'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listDivison",getval);
                }else if(recordTypeName ==='Incoterms' && wrapperVal.listIncoterms.length==0){
                    var getval= wrapperVal.listIncoterms;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Incoterms'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listIncoterms",getval);
                }else if(recordTypeName ==='Payment Terms' && wrapperVal.listPaymentTerms.length==0){
                    var getval= wrapperVal.listPaymentTerms;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Payment Terms'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listPaymentTerms",getval);
                }else if(recordTypeName ==='Price Group' && wrapperVal.listPriceGroup.length==0){
                    var getval= wrapperVal.listPriceGroup;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Price Group'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listPriceGroup",getval);
                }else if(recordTypeName ==='Sales Group' && wrapperVal.listSalesGroup.length==0){
                    var getval= wrapperVal.listSalesGroup;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Group'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listSalesGroup",getval);
                }else if(recordTypeName ==='Sales Office' && wrapperVal.listSalesOffice.length==0){
                    var getval= wrapperVal.listSalesOffice;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Office'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listSalesOffice",getval);
                }else if(recordTypeName ==='Sales Organization' && wrapperVal.listSalesOrg.length==0){
                    var getval= wrapperVal.listSalesOrg;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Organization'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listSalesOrg",getval);
                }else if(recordTypeName ==='Shipping Condition' && wrapperVal.listSalesCondition.length==0){
                    var getval= wrapperVal.listSalesCondition;
                    getval.push({
                        'sobjectType': 'DP_SAP_Foreign_Key__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Shipping Condition'],
                        'Distributer__c':component.get("v.recordId")
                    });
                    component.set("v.wrapperObject.listSalesCondition",getval);
                }
                /*else if(recordTypeName ==='Billing Commitment'){
                    billingCommitmentInstance = {
                        'sobjectType': 'Sales_Projection__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Billing Commitment'],
                        'Distributer__c':component.get("v.recordId")
                    };
                }else if(recordTypeName ==='Dealer Network Addition'){
                    dealerNetworkAdditionInstance = {
                        'sobjectType': 'Sales_Projection__c',
                        'RecordTypeId':mapOfRecordTypeName_and_Id['Dealer Network Addition'],
                        'Distributer__c':component.get("v.recordId")
                    };
                }*/
                
            }
            // Current Business Activity / Business History
            var getval= component.get("v.wrapperObject.listBusinessActivityAndHistory");
            getval.push({
                'sobjectType': 'Business_Activity_History__c',
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listBusinessActivityAndHistory",getval);
        }else if(partnerName==='distributionPartnerDetails'){
            var getval= component.get("v.wrapperObject.listPartnerDetailsObject");
            getval.push({
                'sobjectType': 'Partner_Detail__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Distribution Partner'],
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listPartnerDetailsObject",getval);
        }else if(partnerName==='projectPartnerDetails'){
            var getval= component.get("v.wrapperObject.listProjectPartnerDetailsObject");
            getval.push({
                'sobjectType': 'Partner_Detail__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Project Partner'],
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listProjectPartnerDetailsObject",getval);
        }else if(partnerName==='contactPartner'){
            component.set("v.moreThanOneProprietor",true);
            var getval= component.get("v.wrapperObject.listProprietorPartnersDirector");
            getval.push({
                'sobjectType': 'Contact',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Proprietor Details'],
                'AccountId':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listProprietorPartnersDirector",getval);
        }else if(partnerName==='businessActivityHistory'){
            var getval= component.get("v.wrapperObject.listBusinessActivityAndHistory");
            getval.push({
                'sobjectType': 'Business_Activity_History__c',
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listBusinessActivityAndHistory",getval);
        }else if(partnerName==='sisterConcern'){
            var getval= component.get("v.wrapperObject.listSisterConcerns");
            getval.push({
                'sobjectType': 'Partner_Detail__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Sister Concern'],
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listSisterConcerns",getval);
        }else if(partnerName==='loanDetailBank'){
            var getval= component.get("v.wrapperObject.loanDetails");
            getval.push({
                'sobjectType': 'Bank_Details__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Loan Details'],
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.loanDetails",getval);
        }else if(partnerName==='projectionSales'){
            var getval= component.get("v.wrapperObject.salesProjectionInstance");
            getval.push({
                'sobjectType': 'Sales_Projection__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Projection'],
                'Distributor__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.salesProjectionInstance",getval);
        }else if(partnerName==='selfAndFamily'){
            component.set("v.moreThanOneFamilyMember",true);
            var getval= component.get("v.wrapperObject.detailsOfSelfandFamily");
            getval.push({
                'sobjectType': 'Contact',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Data of Self and Family Deatails'],
                'AccountId':component.get("v.recordId")
            });
            component.set("v.wrapperObject.detailsOfSelfandFamily",getval);
        }else if(partnerName==='Add Account Assignment'){
            var getval= component.get("v.wrapperObject.listAccountAssignmentGroup");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Account Assignment Group'],
                'AccountId':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listAccountAssignmentGroup",getval);
        }else if(partnerName==='Add Credit Control'){
            var getval= component.get("v.wrapperObject.listCreditControlArea");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Credit Control Area'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listCreditControlArea",getval);
        }else if(partnerName==='Add Customer Group'){
            var getval= component.get("v.wrapperObject.listCusGroup");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Cus Group'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listCusGroup",getval);
        }else if(partnerName==='Add Customer Pricing'){
            var getval= component.get("v.wrapperObject.listCusPricingProcedure");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Cus Pricing Procedure'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listCusPricingProcedure",getval);
        }else if(partnerName==='Add Delivery Plant'){
            var getval= component.get("v.wrapperObject.listDeliveringPlant");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Delivering Plant'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listDeliveringPlant",getval);
        }else if(partnerName==='Add Delivery Priority'){
            var getval= component.get("v.wrapperObject.listDeliveryPriority");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Delivery Priority'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listDeliveryPriority",getval);
        }else if(partnerName==='Add Distributor Channel'){
            var getval= component.get("v.wrapperObject.listDistributorChannel");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Distributor Channel'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listDistributorChannel",getval);
        }else if(partnerName==='Add Divison'){
            var getval= component.get("v.wrapperObject.listDivison");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Division'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listDivison",getval);
        }else if(partnerName==='Add Incoterms'){
            var getval= component.get("v.wrapperObject.listIncoterms");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Incoterms'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listIncoterms",getval);
        }else if(partnerName==='Add Payment Terms'){
            var getval= component.get("v.wrapperObject.listPaymentTerms");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Payment Terms'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listPaymentTerms",getval);
        }else if(partnerName==='Add Price Group'){
            var getval= component.get("v.wrapperObject.listPriceGroup");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Price Group'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listPriceGroup",getval);
        }else if(partnerName==='Add Sales Group'){
            var getval= component.get("v.wrapperObject.listSalesGroup");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Group'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listSalesGroup",getval);
        }else if(partnerName==='Add Sales Office'){
            var getval= component.get("v.wrapperObject.listSalesOffice");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Office'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listSalesOffice",getval);
        }else if(partnerName==='Add Sales Organization'){
            var getval= component.get("v.wrapperObject.listSalesOrg");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Sales Organization'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listSalesOrg",getval);
        }else if(partnerName==='Add Shipping Condition'){
            var getval= component.get("v.wrapperObject.listSalesCondition");
            getval.push({
                'sobjectType': 'DP_SAP_Foreign_Key__c',
                'RecordTypeId':mapOfRecordTypeName_and_Id['Shipping Condition'],
                'Distributer__c':component.get("v.recordId")
            });
            component.set("v.wrapperObject.listSalesCondition",getval);
        }

        component.set("v.formHasError",true);
    },
    
    RemoveDistributionPartner : function(component,event) {
        debugger;
        var index = event.getParam("indexVar"); 
        var partnerName = event.getParam("whichPartner"); 
        var removedRecordIds = component.get("v.wrapperObject.recordsToDelete");
        if(partnerName==='distributionPartnerDetails'){
            var AllRowsList = component.get("v.wrapperObject.listPartnerDetailsObject");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listPartnerDetailsObject", AllRowsList);
        }else if(partnerName==='projectPartnerDetails'){
            var AllRowsList = component.get("v.wrapperObject.listProjectPartnerDetailsObject");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            
            component.set("v.wrapperObject.listProjectPartnerDetailsObject", AllRowsList);
        }else if(partnerName==='contactPartner'){
            var AllRowsList = component.get("v.wrapperObject.listProprietorPartnersDirector");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            var sizeOfList = component.get("v.wrapperObject.listProprietorPartnersDirector");
            if(sizeOfList.length===1){
                component.set("v.moreThanOneProprietor",false);
            }
            component.set("v.wrapperObject.listProprietorPartnersDirector", AllRowsList);
        }else if(partnerName==='businessActivityHistory'){
            var AllRowsList = component.get("v.wrapperObject.listBusinessActivityAndHistory");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listBusinessActivityAndHistory", AllRowsList);
        }
        else if(partnerName==='sisterConcern'){
            var AllRowsList = component.get("v.wrapperObject.listSisterConcerns");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listSisterConcerns", AllRowsList);
        }else if(partnerName==='loanDetailBank'){
            var AllRowsList = component.get("v.wrapperObject.loanDetails");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.loanDetails", AllRowsList);
        }else if(partnerName==='projectionSales'){
            var AllRowsList = component.get("v.wrapperObject.salesProjectionInstance");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.salesProjectionInstance", AllRowsList);
        }
        else if(partnerName==='selfAndFamily'){
            
            var AllRowsList = component.get("v.wrapperObject.detailsOfSelfandFamily");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            var sizeOfList = component.get("v.wrapperObject.detailsOfSelfandFamily");
            if(sizeOfList.length===1){
                component.set("v.moreThanOneFamilyMember",false);
            }
            component.set("v.wrapperObject.detailsOfSelfandFamily", AllRowsList);
        }else if(partnerName==='Remove Account Assignment'){
            var AllRowsList = component.get("v.wrapperObject.listAccountAssignmentGroup");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listAccountAssignmentGroup", AllRowsList);
        }else if(partnerName==='Remove Credit Control'){
            var AllRowsList = component.get("v.wrapperObject.listCreditControlArea");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listCreditControlArea", AllRowsList);
        }else if(partnerName==='Remove Customer Group'){
            var AllRowsList = component.get("v.wrapperObject.listCusGroup");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listCusGroup", AllRowsList);
        }else if(partnerName==='Remove Customer Pricing'){
            var AllRowsList = component.get("v.wrapperObject.listCusPricingProcedure");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listCusPricingProcedure", AllRowsList);
        }else if(partnerName==='Remove Delivery Plant'){
            var AllRowsList = component.get("v.wrapperObject.listDeliveringPlant");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listDeliveringPlant", AllRowsList);
        }else if(partnerName==='Remove Delivery Priority'){
            var AllRowsList = component.get("v.wrapperObject.listDeliveryPriority");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listDeliveryPriority", AllRowsList);
        }else if(partnerName==='Remove Distributor Channel'){
            var AllRowsList = component.get("v.wrapperObject.listDistributorChannel");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listDistributorChannel", AllRowsList);
        }else if(partnerName==='Remove Divison'){
            var AllRowsList = component.get("v.wrapperObject.listDivison");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listDivison", AllRowsList);
        }else if(partnerName==='Remove Incoterms'){
            var AllRowsList = component.get("v.wrapperObject.listIncoterms");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listIncoterms", AllRowsList);
        }else if(partnerName==='Remove Payment Terms'){
            var AllRowsList = component.get("v.wrapperObject.listPaymentTerms");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listPaymentTerms", AllRowsList);
        }else if(partnerName==='Remove Price Group'){
            var AllRowsList = component.get("v.wrapperObject.listPriceGroup");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listPriceGroup", AllRowsList);
        }else if(partnerName==='Remove Sales Group'){
            var AllRowsList = component.get("v.wrapperObject.listSalesGroup");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listSalesGroup", AllRowsList);
        }else if(partnerName==='Remove Sales Office'){
            var AllRowsList = component.get("v.wrapperObject.listSalesOffice");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listSalesOffice", AllRowsList);
        }else if(partnerName==='Remove Sales Organization'){
            var AllRowsList = component.get("v.wrapperObject.listSalesOrg");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listSalesOrg", AllRowsList);
        }else if(partnerName==='Remove Shipping Condition'){
            var AllRowsList = component.get("v.wrapperObject.listSalesCondition");
            removedRecordIds.push(AllRowsList[index].Id);
            AllRowsList.splice(index, 1);
            component.set("v.wrapperObject.listSalesCondition", AllRowsList);
        }

        component.set("v.wrapperObject.recordsToDelete",removedRecordIds);
        
    },

    handleValidateFormHelper : function(component,event){

        component.set("v.formHasError",[]);
        var formHasErrorArray = component.get("v.formHasError");
        var isValidate = true;
        var businessLineInp = component.find('businessLine');
        var businessLineVal = component.find('businessLine').get('v.value');

        if ($A.util.isUndefinedOrNull(businessLineVal) || $A.util.isUndefined(businessLineVal) || $A.util.isEmpty(businessLineVal)) {
            businessLineInp.setCustomValidity("No of Dealers field is required");
            isValidate = false;
        } else {
            businessLineInp.setCustomValidity("");
        }
        businessLineInp.reportValidity();

        var partyTypeInp = component.find('partyType');
        var partyTypeVal = component.find('partyType').get('v.value');

        if ($A.util.isUndefinedOrNull(partyTypeVal) || $A.util.isUndefined(partyTypeVal) || $A.util.isEmpty(partyTypeVal)) {
            partyTypeInp.setCustomValidity("No of Dealers field is required");
            isValidate = false;
        } else {
            partyTypeInp.setCustomValidity("");
        }
        partyTypeInp.reportValidity();

        if (isValidate == false) {
            component.set("v.formHasError", true);
            formHasErrorArray.push(true);
        }

        var accountRecord = component.get("v.wrapperObject.accountRef");
        //console.log('Account Record'+JSON.stringify(accountRecord));

        if (accountRecord.Type_of_Partner__c == 'Distributor Partner') {
            var child = component.find("distributionPartnerEditForm");
            var projectpartnerMethodCall = component.find("projectPartnerEditForm");
            var lengthOfArray = child.length;
            if (lengthOfArray == undefined) {
                var status = child.validationDR();

            } else {
                for (var i = 0; i < lengthOfArray; i++) {
                    var status = child[i].validationDR();
                }
            }
            if (projectpartnerMethodCall.length == undefined) {
                projectpartnerMethodCall.validationDRHide();
            } else {
                for (var i = 0; i < projectpartnerMethodCall.length; i++) {
                    var status = projectpartnerMethodCall[i].validationDRHide();
                }
            }
        } else if (accountRecord.Type_of_Partner__c == 'Projects Partner') {
            var child = component.find("projectPartnerEditForm");
            var distributionPartnerMethodcall = component.find("distributionPartnerEditForm");
            var lengthOfArray = child.length;
            if (lengthOfArray == undefined) {
                var status = child.validationDR();
            } else {
                for (var i = 0; i < lengthOfArray; i++) {
                    var status = child[i].validationDR();
                }
            }
            if (distributionPartnerMethodcall.length == undefined) {
                distributionPartnerMethodcall.validationDRHide();
            } else {
                for (var i = 0; i < distributionPartnerMethodcall.length; i++) {
                    var status = distributionPartnerMethodcall[i].validationDRHide();
                }
            }
        }
    },

    callValidateGSTHelper: function(component,event){
        var action = component.get("c.validateGST");
        action.setParams({ recordId: component.get("v.recordId"),
                        gstNumber:component.get("v.wrapperObject.accountRef.VAT_CST_Number__c")});
        action.setCallback(this, function (response) {
            debugger;
                                var state = response.getState();
                                var responseVal = response.getReturnValue();
                                if (state === "SUCCESS") {
                                    
                                    if(responseVal.gststatusWithPortal==true){
                                        component.set("v.gstValidated",true);
                                    }

                                } else if (state === "ERROR") {
                                    var errors = response.getError();
                                    if (errors) {
                                        if (errors[0] && errors[0].message) {
                                            // log the error passed in to AuraHandledException
                                            console.error("Error message: " + errors[0].message);
                                            console.log("Error message: " + errors[0].message);
                                            var toastEvent = $A.get("e.force:showToast");
                                            
                                            toastEvent.setParams({
                                                mode: 'sticky',
                                                title: "Error!",
                                                type: "error",
                                                message: errors[0].message
                                            });
                                            toastEvent.fire();
                                                component.set("v.gstValidated",false);
                                        }
                                    } else {
                                        console.log("Unknown error");
                                    }
                                } else {
                                    console.log("Failed with state: " + state);
                                }
                                component.set("v.Spinner", false);
                            });
        $A.enqueueAction(action);
    }
                        
})
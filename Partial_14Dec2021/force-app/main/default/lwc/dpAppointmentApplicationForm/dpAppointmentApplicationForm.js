console.log('hello world');

import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';

const FIELDS = [
    'Account.Name',
    'Account.Industry',
    'Account.Phone',
    'Account.Business_Line__c',
    'Account.Type_of_Partner__c	'
];

export default class dpAppointmentApplicationForm extends LightningElement {
    debugger;
    @api recordId;
    dealerRecordTypeId;
    @track account;
    @track name;
    @track industry;
    @track phone;
    @track businessLine;
    @track businessLineoptions;
    @track typeOfPartner;
    @track typeOfPartneroptions;
    @track distributionPartners = [{
        District__c:'',
        No_of_Dealers__c:''
    }];
    
    @wire(getRecord,  { recordId: '$recordId', fields: FIELDS})
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading account',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            this.account = data;
            this.name = this.account.fields.Name.value;
            this.industry = this.account.fields.Industry.value;
            this.phone = this.account.fields.Phone.value;
            this.businessLine = this.account.fields.Business_Line__c.value;
            this.typeOfPartner = this.account.fields.Type_of_Partner__c.value;
        }
    }  
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    getObjectdata({data}){
        if(data){
            const rtis = data.recordTypeInfos;
            this.dealerRecordTypeId = Object.keys(rtis).find(rti => rtis[rti].name === 'Dealer');
        }
    }
    
    @wire(getPicklistValuesByRecordType, { objectApiName: 'Account', recordTypeId:'$dealerRecordTypeId' }) 
    BusinessLinePicklistValues({error, data}) {
        if(data) {
            this.businessLineoptions = data.picklistFieldValues.Business_Line__c.values;
            this.typeOfPartneroptions = data.picklistFieldValues.Type_of_Partner__c.values;
        }
        else if(error) {
            window.console.log('error =====> '+JSON.stringify(error));
        }
    }
}
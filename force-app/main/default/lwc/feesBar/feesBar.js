import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import pais from '@salesforce/resourceUrl/Pais';
import estado from '@salesforce/resourceUrl/Estado';
import cidade from '@salesforce/resourceUrl/Cidade';

const FIELDS = [
    'OrderItem.Order.Account_Address__r.City__r.Name',
    'OrderItem.Order.Account_Address__r.City__r.State__r.Name',
    'OrderItem.Order.Account_Address__r.City__r.State__r.Country__r.Name'
];

export default class FeesBar extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS }) orderItem;

    get city() { return this.orderItem.data ? getFieldValue(this.orderItem.data, FIELDS[0]) : ''; }

    get state() { return this.orderItem.data ? getFieldValue(this.orderItem.data, FIELDS[1]) : ''; }

    get country() { return this.orderItem.data ? getFieldValue(this.orderItem.data, FIELDS[2]) : ''; }


    pais = pais;
    estado = estado;
    cidade = cidade;

}
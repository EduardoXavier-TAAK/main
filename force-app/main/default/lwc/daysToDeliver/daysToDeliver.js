import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import deliver from '@salesforce/schema/Order.Remaining_Days__c';
import pedido from '@salesforce/schema/Order.OrderNumber';
import caminhao from '@salesforce/resourceUrl/Caminhao';
import Relogio from '@salesforce/resourceUrl/Relogio';

export default class DaysToDeliver extends LightningElement {
    @api recordId

    @wire(getRecord, { recordId: '$recordId', fields: [deliver, pedido] })
    registro;

    changeColor() {
        const elemento = this.template.querySelector('.num');
        if (Number(deliver) <= 0) {
            elemento.classList.toggle('red');
        }
    }
    cam = caminhao
    relogio = Relogio

    const 

    get deliver(){
        return this.registro.data ? getFieldValue(this.registro.data, deliver) : '';
    }

    get orderNumber() {
        return this.registro.data ? getFieldValue(this.registro.data, pedido) : '';
    }
}
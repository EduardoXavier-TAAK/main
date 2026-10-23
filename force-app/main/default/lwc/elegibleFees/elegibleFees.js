import { LightningElement, wire, api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import getShipping from '@salesforce/apex/FeesBarController.getShipping';
import getTaxes from '@salesforce/apex/FeesBarController.getTaxes';
import getMargin from '@salesforce/apex/FeesBarController.getMargin';

export default class ElegibleFees extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId' }) orderItem;

    @wire(getShipping, { orderItemId: '$recordId' }) shippingResult;

    @wire(getTaxes, { orderItemId: '$recordId' }) taxresult;

    @wire(getMargin, { orderItemId: '$recordId' }) marginresult;

    get shippingFees() { return this.shippingResult?.data || [];  }

    get taxesFees() { return this.taxresult?.data || [];  }

    get marginFees() { return this.marginresult?.data || [];  }
    
}
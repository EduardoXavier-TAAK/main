import { LightningElement, api, wire } from 'lwc';

import getUf from '@salesforce/apex/stateBanner.getStateSelect';

import MG from "@salesforce/resourceUrl/MG";
import RJ from "@salesforce/resourceUrl/RJ";
import SP from "@salesforce/resourceUrl/SP";
import DF from "@salesforce/resourceUrl/DF";
import BA from "@salesforce/resourceUrl/BA";

export default class StatesBanner extends LightningElement {
    @api recordId;
    ufValue = MG; 

    @wire(getUf, { recordId: '$recordId' }) ufResult;

    get uf() { 
        if(this.ufResult === 'MG') { this.ufValue = MG }

        if(this.ufResult === 'SP') { this.ufValue = SP  }

        if(this.ufResult === 'RJ') { this.ufValue = RJ }

        if(this.ufResult === 'DF'){ this.ufValue = DF } 

        if(this.ufResult === 'BA'){ this.ufValue = BA  } 

        return this.ufValue
    
    }
}

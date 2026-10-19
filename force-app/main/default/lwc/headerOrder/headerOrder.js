import { LightningElement } from 'lwc';
import Name from '@salesforce/user/Id';
import Banner from "@salesforce/resourceUrl/Banner";

export default class HeaderOrder extends LightningElement {
    
  get bannerUrl(){
    return Banner;
  }
  
  greeting = Name;

  handleGreetingChange(event) {
    this.greeting = event.target.value;
  }

  currentDate = new Date().toDateString();
  get capitalizedGreeting() {
    return `Bem vindo, ${this.greeting.toUpperCase()}!`;
  }

}


import { LightningElement , wire} from 'lwc';
import {publish, MessageContext} from 'lightning/messageService'
import COUNT_UPDATE from '@salesforce/messageChannel/Counting_Update__c';


export default class PubLms extends LightningElement {

    @wire(MessageContext) messageContext;

    handleIncrement(){
        const payload = { operator : 'add' ,
                        constant : 1
                      };
        publish(this.messageContext, COUNT_UPDATE, payload);
    }

    handleDecrement(){
        const payload = { operator : 'subtract' ,
                        constant : 1
                      };
        publish(this.messageContext, COUNT_UPDATE, payload);
    }

    handleMultiply(){
        const payload = { operator : 'multiply' ,
                        constant : 2
                      };
        publish(this.messageContext, COUNT_UPDATE, payload);
    }
}
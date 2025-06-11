import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COUNT_UPDATE from '@salesforce/messageChannel/Counting_Update__c';

export default class SubLms extends LightningElement {
    count = 0;
    subscription = 0;

    @wire(MessageContext) messageContext;
    connectedCallback(){
        this.handleSubscribe();
    }   
    
    handleSubscribe(){
        this.subscription = subscribe(
            this.messageContext,
            COUNT_UPDATE,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message){
        if(message.operator == 'add'){
            this.count += message.constant;
        }
        else if(message.operator == 'subtract'){
            this.count -= message.constant;
        }
        else if(message.operator == 'multiply'){
            this.count *= message.constant;
        }
    }
    
    
    
}
import { LightningElement, track, wire } from 'lwc';
import {subscribe, MessageContext} from 'lightning/messageService'
import NAME_UPDATE from '@salesforce/messageChannel/Fullname_Update__c';

export default class TaskFullNameSubscriber extends LightningElement {
    @track firstName = '';
    @track lastName = '' ;
    subscription = 0;

    @wire(MessageContext) messageContext;
    connectedCallback(){
        this.handleSubscribe();
    }

    handleSubscribe(){
        this.subscription = subscribe(
            this.messageContext, 
            NAME_UPDATE,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message){
        this.firstName = message.fName;
        this.lastName = message.lName;
    }
}
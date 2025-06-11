import { LightningElement, track, wire } from 'lwc';
import {publish, MessageContext} from 'lightning/messageService'
import NAME_UPDATE from '@salesforce/messageChannel/Fullname_Update__c';

export default class TaskFullNamePublisher extends LightningElement {
    @wire(MessageContext) messageContext;
    @track fNameValue = '';
    @track lNameValue = '';
    handleClick(){
        const payload = {
            fName  : this.fNameValue,
            lName : this.lNameValue
        }
        publish(this.messageContext, NAME_UPDATE, payload);
    }
    handleFNameChange(event){
        this.fNameValue = event.detail.value;
    }
    handleLNameChange(event){
        this.lNameValue = event.detail.value;
    }

}
import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class SubscriberComponent extends LightningElement {
    strCapturedTxt = '';
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){

        registerListener('EventFromPub', this.setCaptureText, this);

    }

    disconnectedCallback(){

        unregisterAllListeners(this);

    }

    setCaptureText(obj){
        this.strCapturedTxt = obj;
    }
}
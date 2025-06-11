import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class TaskContactTableSubscriber extends LightningElement {
    accData = [];
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){

        registerListener('Account Publisher', this.accountData, this);
    }

   

    accountData(data){
        console.log("inside subscriber : ", data);
        this.accData = data;
        console.log("accData : ", this.accData);
    }


    disconnectedCallback(){
        unregisterAllListeners(this);
    }

}
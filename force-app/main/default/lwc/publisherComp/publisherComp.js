import { LightningElement , wire } from 'lwc';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class PublisherComponent extends LightningElement {
    strText = '';
    @wire(CurrentPageReference) objPageRef;

    changeName(event){
        this.strText = event.target.value;
    }

    publishEvent(){
        fireEvent(this.objPageRef, 'EventFromPub', this.strText);
    }
}
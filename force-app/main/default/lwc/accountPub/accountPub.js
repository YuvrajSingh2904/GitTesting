import { LightningElement, wire} from 'lwc';
import getAccountInfo from '@salesforce/apex/accountDataTableWRadioButtonController.getAccount';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

const columns = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Rating', fieldName: 'Rating'}
]

export default class TaskContactTablePublisher extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    columns = columns;
    accData = [];
    selectedRow = [];
    getSelectedRecords = [];

    @wire(getAccountInfo)
        accountData({data, error})
    {
        if(data){
            console.log('Account Data: ', data);
            this.accData = data;
        }
        else if(error){
            console.log('error', error);
        }
    }

    connectedCallback(){
        
    }
    handleRowSelect(event){
        let selectedAccount = event.detail.selectedRows;
        console.log('selectedRow:  ', selectedAccount);
        fireEvent(this.pageRef, 'Account Publisher', selectedAccount);
    }
   
}
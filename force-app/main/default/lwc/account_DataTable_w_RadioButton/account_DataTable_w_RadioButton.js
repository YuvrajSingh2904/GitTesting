import { LightningElement, wire, track, api } from 'lwc';
import getAccount from '@salesforce/apex/accountDataTableWRadioButtonController.getAccount';


export default class Account_DataTable_w_RadioButton extends LightningElement {

    @api idForChild = 'xxxx';

    @wire (getAccount)
    wiredAccounts;

    
    handleRadioChange(event) { 
        this.idForChild = event.target.value;
        console.log('Selected Account ID: ' + this.idForChild);
    }

}
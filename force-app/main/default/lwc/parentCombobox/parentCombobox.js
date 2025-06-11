import { LightningElement } from 'lwc';

export default class ParentCombobox extends LightningElement {
    
    value = "";
    accTable = false;
    conTable = false;
    oppTable = false;

    get options(){
        return[
            {label: 'None', value: 'None'},
            {label: 'Account', value: 'Account'},
            {label: 'Contact', value: 'Contact'},
            {label: 'Opportunity', value: 'Opportunity'}
        ]
    }
    handleChange(event){
        this.value = event.detail.value;
        if(this.value === 'Account'){
            console.log("Account Data = "+ JSON.stringify(this.data));
            this.accTable = true;
            this.conTable = false;
            this.oppTable = false;
        } else if(this.value === 'Contact'){
            this.accTable = false;
            this.conTable = true;
            this.oppTable = false;
        } else if(this.value === 'Opportunity'){
            this.accTable = false;
            this.conTable = false;
            this.oppTable = true;
        } else {
            this.accTable = false;
            this.conTable = false;
            this.oppTable = false;
        }

    }
}
import { LightningElement, wire, track } from 'lwc';
import getContact from '@salesforce/apex/accountDataTableWRadioButtonController.getContact';
import updatedContactDetail from '@salesforce/apex/accountDataTableWRadioButtonController.updatedContactDetail';

const conColumns = [
    {label: 'First Name', fieldName: 'FirstName', editable: true},
    {label: 'Last Name', fieldName: 'LastName', editable: true}
];

export default class TestInlineEdits extends LightningElement {

    @track conData;
    @track conDraftValues =[];
    @track conColumns = conColumns;
    inputForID = '001Qy00000fTXFZIA4';


    @wire(getContact, {accountId: '$inputForID'})
    wiredContacts({data, error}){
        if(data){
            console.log(JSON.stringify(data));
            this.conData = data;
        }
        else if(error){
            console.log(JSON.stringify(error))
        }
    }

    handleConSave(event){
        this.conDraftValues = event.detail.draftValues;
        console.log("Updated Values -->", JSON.stringify(this.conDraftValues));
        updatedContactDetail({contactData: this.conDraftValues})
            .then(result => {
                console.log("Updated Contact Details: "+ JSON.stringify(result))
            })
            .catch(error => {
                console.error(""+JSON.stringify(error))
            })
        }


}
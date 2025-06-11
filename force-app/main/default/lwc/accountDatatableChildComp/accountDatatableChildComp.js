import { LightningElement, api, wire, track } from 'lwc';
import getContact from '@salesforce/apex/accountDataTableWRadioButtonController.getContact';
import updatedContactDetail from '@salesforce/apex/accountDataTableWRadioButtonController.updatedContactDetail';

const columns = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true}
]

export default class AccountDatatableChildComp extends LightningElement {
    @api parentinput;
    @track data;
    @track columns = columns;
    @track draftValues = [];

    @wire(getContact, {accountId:'$parentinput'})
    wiredContacts({data, error}){
        if(data){
            console.log(JSON.stringify(data));
            this.data = data;
        }
        else if(error){
            console.log(JSON.stringify(error))
        }
    }


    handleSave(event){

        this.draftValues= event.detail.draftValues;
        console.log("Updated Values -->", JSON.stringify(this.draftValues));
        updatedContactDetail({contactData: this.draftValues})
           .then(result => {
                console.log("Updated Contact Details: "+ JSON.stringify(result))
            })
            .catch(error => {
                console.error(""+JSON.stringify(error))
            })
    }
    

}













// @track contacts = [];
    // firstName;
    // lastName;
    



    // @wire (getContact, {accountId:'$parentinput'})
    // wiredContacts({error,data}) 
    // {
    //     if(data){
    //         this.contacts = data;
    //         console.log("Data ---> "+data);
    //         console.log("Data ---S>>>" + JSON.stringify(data));
    //     }else if(error){
    //         console.log("Error"+JSON.stringify(error));
    //     }
    // }

    // handleFNameChange(event){
    //     this.firstName = event.target.value;
    //     console.log(this.firstName);
    //     console.log("Contact Id = "+event.target.dataset.id);
    // }
    // handleLNameChange(event){
    //     this.lastName = event.target.value;
    //     console.log(this.lastName);
    // }


    // handleUpdate(event){

    //     const conId = event.target.dataset.id;
    //     console.log(conId);
    //     saveContact({ContactId:conId, FirstName:this.firstName, LastName:this.lastName})
    //     .then(result => {
    //         console.log("Contact Details: "+ JSON.stringify(result))
    //         console.log("Saved")
    //     })
    //     .catch(error => {
    //         console.error(""+JSON.stringify(error))
    //     })
    // }



// const columns = [
//     {label: 'View', type: 'button-icon', initialWidth:75, typeAttributes: { iconName: 'action:preivew', title: 'Preview', variant: 'border-filled', alternativeText: 'View'}},
//     {label: 'First Name', fieldName: 'FirstName'},
//     {label: 'Last Name', fieldName: 'Lastname'},
//     {label: 'Email', fieldName: 'Email'},
//     {label: 'Phone', fieldName: 'Phone'}
// ]

    // @track columns = columns;
    // @track contactRow={};
    // @track rowOffset = 0;
    // @track modalContainer = false;
    // @track saveDraftValues = [];
    // @track contacts;

    // handleRowAction(event){
    //     const dataRow = event.detail.row;
    //     window.console.log('dataRow@@ ' + dataRow);
    //     this.contactRow=dataRow;
    //     window.console.log('contactRow## ' + dataRow);
    //     this.modalContainer=true;
    // }

    // handleSave(){
    //     saveRecords(this.conactRow)
    // }

    // closeModalAction(){
    //     this.modalContainer=false;
    // }
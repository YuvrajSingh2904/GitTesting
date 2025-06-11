import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getAccounts from '@salesforce/apex/updateDeleteComboboxController.getAccount';
import getContacts from '@salesforce/apex/updateDeleteComboboxController.getContact';
import getOpportunities from '@salesforce/apex/updateDeleteComboboxController.getOpportunity';

import updateAccDetail from '@salesforce/apex/updateDeleteComboboxController.updateAccDetail';
import updateConDetail from '@salesforce/apex/updateDeleteComboboxController.updatedContactDetail';
import updateOppDetail from '@salesforce/apex/updateDeleteComboboxController.updateOppDetail';

import deleteRecords from '@salesforce/apex/updateDeleteComboboxController.deleteRecords';
import deleteConRecords from '@salesforce/apex/updateDeleteComboboxController.deleteConRecords';
import deleteOppRecords from '@salesforce/apex/updateDeleteComboboxController.deleteOppRecords';

const columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Rating', fieldName: 'Rating', editable: true }
];

const conColumns = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true }
];

const oppColumns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Stage', fieldName: 'StageName', editable: true }
];

export default class UpdateDeleteCombobox extends LightningElement {
    value = "";
    accTable = false;
    conTable = false;
    oppTable = false;
    accData = [];
    conData = [];
    oppData = [];
    @track columns = columns;
    @track conColumns = conColumns;
    @track oppColumns = oppColumns;
    @track draftValues = [];
    @track conDraftValues = [];
    @track oppDraftValues = [];
    selectedRowIds = [];
    isButtonDisabled = true;
    data = [];

    get options() {
        return [
            { label: 'None', value: 'None' },
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' }
        ];
    }

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.data = data;
            console.log("Account Data" + this.data);
        } else if (error) {
            console.log("Error" + error);
        }
    }

    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.conData = data;
            console.log("Contact Data" + this.conData);
        } else if (error) {
            console.log("Error" + error);
        }
    }

    @wire(getOpportunities)
    wiredOpportunities({ error, data }) {
        if (data) {
            this.oppData = data;
            console.log("Opportunity Data" + this.oppData);
        } else if (error) {
            console.log("Error" + error);
        }
    }

    handleChange(event) {
        this.value = event.detail.value;
        console.log("Object Selected = " + this.value);
        if (this.value === 'Account') {
            console.log("Account Data = " + JSON.stringify(this.data));
            this.accTable = true;
            this.conTable = false;
            this.oppTable = false;
        } else if (this.value === 'Contact') {
            this.accTable = false;
            this.conTable = true;
            this.oppTable = false;
        } else if (this.value === 'Opportunity') {
            this.accTable = false;
            this.conTable = false;
            this.oppTable = true;
        } else {
            this.accTable = false;
            this.conTable = false;
            this.oppTable = false;
        }

        this.dispatchEvent(new CustomEvent('valuechange', { detail: this.value }));
    }

    handleSave(event) {
        this.draftValues = event.detail.draftValues;
        console.log("Updated Values -->", JSON.stringify(this.draftValues));
        updateAccDetail({ accountData: this.draftValues })
            .then(result => {
                console.log("Updated Account Details: " + JSON.stringify(result));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'All Accounts Updated',
                        variant: 'Success',
                    })
                );
                this.draftValues = [];
                return refreshApex(this.accData);
            })
            .catch(error => {
                console.error("" + JSON.stringify(error));
                console.log("Error" + error);
            });

        this.dispatchEvent(new CustomEvent('save', { detail: this.draftValues }));
    }

    handleConSave(event) {
        this.conDraftValues = event.detail.draftValues;
        updateConDetail({ contactData: this.conDraftValues })
            .then(result => {
                console.log("Updated Contact Details: " + JSON.stringify(result));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'All Contacts Updated',
                        variant: 'Success',
                    })
                );
                this.conDraftValues = [];
                return refreshApex(this.conData);
            })
            .catch(error => {
                console.error("" + JSON.stringify(error));
            });

        this.dispatchEvent(new CustomEvent('consave', { detail: this.conDraftValues }));
    }

    handleOppSave(event) {
        this.oppDraftValues = event.detail.draftValues;
        updateOppDetail({ oppData: this.oppDraftValues })
            .then(result => {
                console.log("Updated Opportunity Details: " + JSON.stringify(result));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'All Opportunities Updated',
                        variant: 'Success',
                    })
                );
                this.oppDraftValues = [];
                return refreshApex(this.oppData);
            })
            .catch(error => {
                console.error("" + JSON.stringify(error));
            });

        this.dispatchEvent(new CustomEvent('oppsave', { detail: this.oppDraftValues }));
    }

    handleRowSelection(event) {
        this.selectedRowIds = event.detail.selectedRows.map(row => row.Id);
        console.log("Selected Row Ids: " + this.selectedRowIds);
        this.isButtonDisabled = this.selectedRowIds.length === 0;

        this.dispatchEvent(new CustomEvent('rowselection', { detail: this.selectedRowIds }));
    }

    handleDelete() {
    if (this.selectedRowIds.length > 0) {
        deleteRecords({ recordIds: this.selectedRowIds })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Deleted',
                        variant: 'Success'
                    })
                );
                return refreshApex(this.accData);
            })
            .catch(error => {
                console.error("Error Deleting Records" + JSON.stringify(error));
            });

        this.dispatchEvent(new CustomEvent('delete', { detail: 'deleteAccount' }));
    }
}

    handleConDelete() {
        if (this.selectedRowIds.length > 0) {
            deleteConRecords({ recordIds: this.selectedRowIds })
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record Deleted',
                            variant: 'Success'
                        })
                    );
                    return refreshApex(this.conData);
                })
                .catch(error => {
                    console.error("Error Deleting Records" + JSON.stringify(error));
                });

            this.dispatchEvent(new CustomEvent('delete', { detail: 'deleteContact' }));
        }
    }

    handleOppDelete() {
        if (this.selectedRowIds.length > 0) {
            deleteOppRecords({ recordIds: this.selectedRowIds })
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record Deleted',
                            variant: 'Success'
                        })
                    );
                    return refreshApex(this.oppData);
                })
                .catch(error => {
                    console.error("Error Deleting Records" + JSON.stringify(error));
                });

            this.dispatchEvent(new CustomEvent('delete', { detail: 'deleteOpportunity' }));
        }
    }
}
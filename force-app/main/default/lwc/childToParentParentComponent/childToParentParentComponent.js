import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track selectedValue = '';
    @track selectedRows = [];

    handleValueChange(event) {
        this.selectedValue = event.detail;
        // Handle the value change from child component
        console.log("Selected Value in Parent: ", this.selectedValue);
    }

    handleDelete(event) {
        const deleteType = event.detail;
        // Handle the delete action from child component
        console.log("Delete Action in Parent: ", deleteType);
    }

    handleConDelete(event) {
        const deleteType = event.detail;
        // Handle the contact delete action from child component
        console.log("Contact Delete Action in Parent: ", deleteType);
    }

    handleOppDelete(event) {
        const deleteType = event.detail;
        // Handle the opportunity delete action from child component
        console.log("Opportunity Delete Action in Parent: ", deleteType);
    }

    handleRowSelection(event) {
        this.selectedRows = event.detail;
        // Handle the row selection from child component
        console.log("Selected Rows in Parent: ", this.selectedRows);
    }

    handleSave(event) {
        const draftValues = event.detail;
        // Handle the save action from child component
        console.log("Save Action in Parent: ", draftValues);
    }

    handleConSave(event) {
        const draftValues = event.detail;
        // Handle the contact save action from child component
        console.log("Contact Save Action in Parent: ", draftValues);
    }

    handleOppSave(event) {
        const draftValues = event.detail;
        // Handle the opportunity save action from child component
        console.log("Opportunity Save Action in Parent: ", draftValues);
    }
}
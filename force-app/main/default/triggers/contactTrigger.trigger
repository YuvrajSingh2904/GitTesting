trigger contactTrigger on Contact (before insert, before update, after insert, after delete, after update, after undelete) {
	contactTriggerHandler.PrimaryContactValidation(trigger.new, trigger.oldmap);
    contactTriggerHandler.contactLimitValidation(trigger.new, trigger.oldmap);
    contactTriggerHandler.numberOfContacts(trigger.new, trigger.oldMap, trigger.isInsert, trigger.isUpdate, trigger.isDelete, trigger.isUndelete);
}
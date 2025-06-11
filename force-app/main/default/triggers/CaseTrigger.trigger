trigger CaseTrigger on Case (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        CaseTriggerHandler.handlePriorityUpdate(Trigger.new);
    }
}
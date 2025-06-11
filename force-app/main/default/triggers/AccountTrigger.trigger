trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            AccountTriggerHandler.triggerMethod(trigger.new);
        }
        if(trigger.isUpdate){
            
        }
    }
    if(trigger.isAfter){
        if(trigger.isInsert){
            
            
            
        }
        if(trigger.isUpdate){
            AccountTriggerHandler.interviewQ(trigger.new, trigger.oldMap);
        }
    }
}
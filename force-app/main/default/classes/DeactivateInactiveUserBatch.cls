public class DeactivateInactiveUserBatch implements Database.Batchable<SObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM User WHERE LastLoginDate < LAST_N_DAYS:30 AND IsActive = true';
        return Database.getQueryLocator(query);
    } 
    public void execute(Database.BatchableContext bc, List<User> scope){
        for (User u : scope) {
            u.IsActive = false; 
        } 
        update scope;
    }
    public void finish(Database.BatchableContext bc) { 
        System.debug('Batch job finished');
    }
}
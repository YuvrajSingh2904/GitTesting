public class DeactivateInactiveUsersScheduler implements Schedulable {
    public void execute(SchedulableContext sc){
        DeactivateInactiveUserBatch batch = new DeactivateInactiveUserBatch();
        Database.executeBatch(batch);
    }
}
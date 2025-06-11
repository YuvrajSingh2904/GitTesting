public class CaseTriggerHandler {
    public static void handlePriorityUpdate(List<Case> caseList) {
        for (Case c : caseList) {
            if (c.Priority == 'Testing Pick Value') {
                c.SuppliedName = 'Apex Triggered';
            }
        }
    }
}
@isTest
public class TestUtility {
    /**
     * Creates and inserts a test Account record.
     */
    public static Account createTestAccount(String name, Decimal totalAmount, String rating) {
        Account acc = new Account(Name = name, Total_Amount__c = totalAmount, Rating = rating);
        insert acc;
        return [SELECT Id, Name, Total_Amount__c, Rating FROM Account WHERE Id = :acc.Id];
    }

    /**
     * Creates and inserts a test Opportunity record linked to an Account.
     */
    public static Opportunity createTestOpportunity(String name, Id accountId, Decimal amount, String stageName) {
        Opportunity opp = new Opportunity(Name = name, AccountId = accountId, Amount = amount, StageName = stageName, CloseDate = Date.today());
        insert opp;
        return [SELECT Id, Name, AccountId, Amount, StageName FROM Opportunity WHERE Id = :opp.Id];
    }
}
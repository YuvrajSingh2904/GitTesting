@isTest
public class OpportunityTriggerHandlerTest {
    
    @isTest
    static void testUpdateParentTotalAmountOnInsert() {
        // Create an account
        Account acc = TestUtility.createTestAccount('Test Account', 0, 'Warm');

        // Create opportunities
        Opportunity opp1 = TestUtility.createTestOpportunity('Opp 1', acc.Id, 5000, 'Prospecting');
        Opportunity opp2 = TestUtility.createTestOpportunity('Opp 2', acc.Id, 7000, 'Negotiation');

        // Run the test
        Test.startTest();
        Opportunity opp3 = TestUtility.createTestOpportunity('Opp 3', acc.Id, 3000, 'Proposal');
        Test.stopTest();

        // Verify that the Total_Amount__c is updated
        Account updatedAcc = [SELECT Id, Total_Amount__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(15000, updatedAcc.Total_Amount__c); // 5000 + 7000 + 3000
    }

    @isTest
    static void testUpdateAccountRatingAllClosedWon() {
        // Create an account
        Account acc = TestUtility.createTestAccount('Hot Account', 0, 'Cold');

        // Create Opportunities (all Closed Won)
        Opportunity opp1 = TestUtility.createTestOpportunity('Opp X', acc.Id, 2000, 'Closed Won');
        Opportunity opp2 = TestUtility.createTestOpportunity('Opp Y', acc.Id, 3000, 'Closed Won');

        // Run the test
        Test.startTest();
        Opportunity opp3 = TestUtility.createTestOpportunity('Opp Z', acc.Id, 5000, 'Closed Won');
        Test.stopTest();

        // Verify that the Account rating is updated to Hot
        Account updatedAcc = [SELECT Id, Rating FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Hot', updatedAcc.Rating);
    }

}
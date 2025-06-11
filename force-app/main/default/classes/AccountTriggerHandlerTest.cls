/*
@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void testUpdateDescriptionBasedonRating(){
        Account acc1 = TestDataFactory.createAccount(false);
        insert acc1;
        
        Account acc2 = [SELECT Id, Description, Rating FROM Account WHERE Id =: acc1.Id];
        acc2.Rating = 'Warm';
        
        Map<Id, Account> oldMap = new Map<Id, Account>();
        oldMap.put(acc1.Id, acc1);

        AccountTriggerHandler.updateDescriptionBasedonRating(new List<Account>{acc2}, oldMap);
        
        Account updatedAcc = [SELECT Id, Description, Rating FROM Account WHERE Id = :acc1.Id];
        System.assertEquals('Hot', updatedAcc.Description);
    }
}
*/
@isTest
public class AccountTriggerHandlerTest {
    @isTest
    static void testUpdateDescriptionBasedOnRating() {

        Account acc = TestUtility.createTestAccount('Test Account', 'Hot', 'Initial Description');

        System.assertEquals('Hot', acc.Rating);
        System.assertEquals('Initial Description', acc.Description);

        Test.startTest();
        acc.Rating = 'Warm';
        update acc;
        Test.stopTest();

        Account updatedAcc = [SELECT Id, Rating, Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Warm', updatedAcc.Rating);
        System.assertEquals('Hot', updatedAcc.Description);     }

    @isTest
    static void testUpdateWithoutRatingChange() {
 
        Account acc = TestUtility.createTestAccount('Test Account 2', 'Cold', 'Original Desc');


        Test.startTest();
        acc.Description = 'New Description';
        update acc;
        Test.stopTest();

        Account updatedAcc = [SELECT Id, Rating, Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Cold', updatedAcc.Rating);
        System.assertEquals('New Description', updatedAcc.Description); 
    }
}
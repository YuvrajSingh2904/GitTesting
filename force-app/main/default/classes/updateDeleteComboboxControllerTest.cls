@isTest
public class updateDeleteComboboxControllerTest {
    
    @testSetup
    static void setupTestData() {
        // Create test Accounts
        List<Account> accList = new List<Account>{
            new Account(Name = 'Test Account 1', Rating = 'Hot'),
            new Account(Name = 'Test Account 2', Rating = 'Warm')
        };
        insert accList;

        // Create test Contacts
        List<Contact> conList = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe', AccountId = accList[0].Id),
            new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = accList[1].Id)
        };
        insert conList;

        // Create test Opportunities
        List<Opportunity> oppList = new List<Opportunity>{
            new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = accList[0].Id),
            new Opportunity(Name = 'Opportunity 2', StageName = 'Closed Won', CloseDate = Date.today(), AccountId = accList[1].Id)
        };
        insert oppList;
    }

    @isTest
    static void testGetAccount() {
        Test.startTest();
        List<Account> accounts = updateDeleteComboboxController.getAccount();
        Test.stopTest();
        
        System.assertNotEquals(0, accounts.size(), 'Accounts should be retrieved');
    }

    @isTest
    static void testGetContact() {
        Test.startTest();
        List<Contact> contacts = updateDeleteComboboxController.getContact();
        Test.stopTest();
        
        System.assertNotEquals(0, contacts.size(), 'Contacts should be retrieved');
    }

    @isTest
    static void testGetOpportunity() {
        Test.startTest();
        List<Opportunity> opportunities = updateDeleteComboboxController.getOpportunity();
        Test.stopTest();
        
        System.assertNotEquals(0, opportunities.size(), 'Opportunities should be retrieved');
    }

    @isTest
    static void testUpdateAccDetail() {
        List<Account> accList = [SELECT Id, Name, Rating FROM Account LIMIT 1];
        accList[0].Rating = 'Cold';

        Test.startTest();
        String result = updateDeleteComboboxController.updateAccDetail(accList);
        Test.stopTest();

        System.assertEquals('Success', result, 'Account update should return Success');

        Account updatedAcc = [SELECT Id, Rating FROM Account WHERE Id = :accList[0].Id];
        System.assertEquals('Cold', updatedAcc.Rating, 'Account rating should be updated to Cold');
    }

    @isTest
    static void testUpdatedContactDetail() {
        List<Contact> conList = [SELECT Id, FirstName FROM Contact LIMIT 1];
        conList[0].FirstName = 'Michael';

        Test.startTest();
        String result = updateDeleteComboboxController.updatedContactDetail(conList);
        Test.stopTest();

        System.assertEquals('Successfully Updated', result, 'Contact update should return Successfully Updated');

        Contact updatedCon = [SELECT Id, FirstName FROM Contact WHERE Id = :conList[0].Id];
        System.assertEquals('Michael', updatedCon.FirstName, 'Contact FirstName should be updated');
    }

    @isTest
    static void testUpdateOppDetail() {
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity LIMIT 1];
        oppList[0].Name = 'Updated Opportunity';

        Test.startTest();
        String result = updateDeleteComboboxController.updateOppDetail(oppList);
        Test.stopTest();

        System.assertEquals('Success', result, 'Opportunity update should return Success');

        Opportunity updatedOpp = [SELECT Id, Name FROM Opportunity WHERE Id = :oppList[0].Id];
        System.assertEquals('Updated Opportunity', updatedOpp.Name, 'Opportunity Name should be updated');
    }

    @isTest
    static void testDeleteRecords() {
        List<Account> accList = [SELECT Id FROM Account LIMIT 1];
        List<Id> accIds = new List<Id>{accList[0].Id};

        Test.startTest();
        updateDeleteComboboxController.deleteRecords(accIds);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account WHERE Id = :accList[0].Id];
        System.assertEquals(0, count, 'Account should be deleted');
    }

    @isTest
    static void testDeleteConRecords() {
        List<Contact> conList = [SELECT Id FROM Contact LIMIT 1];
        List<Id> conIds = new List<Id>{conList[0].Id};

        Test.startTest();
        updateDeleteComboboxController.deleteConRecords(conIds);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Contact WHERE Id = :conList[0].Id];
        System.assertEquals(0, count, 'Contact should be deleted');
    }

    @isTest
    static void testDeleteOppRecords() {
        List<Opportunity> oppList = [SELECT Id FROM Opportunity LIMIT 1];
        List<Id> oppIds = new List<Id>{oppList[0].Id};

        Test.startTest();
        updateDeleteComboboxController.deleteOppRecords(oppIds);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Opportunity WHERE Id = :oppList[0].Id];
        System.assertEquals(0, count, 'Opportunity should be deleted');
    }
}
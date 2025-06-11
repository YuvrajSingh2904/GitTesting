@isTest
private class accountDataTableTest {
    
    @isTest
    static void testGetAccount() {
        // Create Test Data
        for (Integer i = 0; i < 5; i++) {
            TestDataFactory.createAccount(true);
        }

        // Call Method
        Test.startTest();
        List<Account> accounts = accountDataTableWRadioButtonController.getAccount();
        Test.stopTest();

        // Assertions
        System.assertNotEquals(accounts, null, 'Account list should not be null');
        System.assertEquals(5, accounts.size(), 'Should return 5 accounts');
    }

    @isTest
    static void testGetContact() {
        // Create Test Data
        Map<String, Object> testData = TestDataFactory.createAccountWithContacts(3, true);
        Account acc = (Account) testData.get('account');

        // Call Method
        Test.startTest();
        List<Contact> contacts = accountDataTableWRadioButtonController.getContact(acc.Id);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(contacts, null, 'Contact list should not be null');
        System.assertEquals(3, contacts.size(), 'Should return 3 contacts');
    }

    @isTest
    static void testUpdatedContactDetail() {
        // Create and insert a test Account
        Account acc = new Account(Name = 'Test Account', Rating = 'Hot');
        insert acc;
    
        // Create and insert test Contacts linked to the Account
        List<Contact> ConList = new List<Contact>();
        Contact contact1 = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@example.com', AccountId = acc.Id);
        Contact contact2 = new Contact(FirstName = 'Jane', LastName = 'Smith', Email = 'jane.smith@example.com', AccountId = acc.Id);
        ConList.add(contact1);
        ConList.add(contact2);
        insert ConList;
    
        // Modify Contact Data
        contact1.FirstName = 'UpdatedJohn';
        contact2.LastName = 'UpdatedSmith';
    
        // Serialize ONLY the List<Contact>, NOT an object wrapper
        String contactJson = JSON.serialize(ConList);
    
        // Debugging Output
        System.debug('Serialized Contact JSON: ' + contactJson);
    
        // Call Method
        Test.startTest();
        String result = accountDataTableWRadioButtonController.updatedContactDetail(contactJson);
        Test.stopTest();
    
        // Assertions
        System.assertEquals('Successfully Updated', result, 'Should return success message');
    
        // Verify Database Update
        Contact updatedContact1 = [SELECT FirstName FROM Contact WHERE Id = :contact1.Id];
        Contact updatedContact2 = [SELECT LastName FROM Contact WHERE Id = :contact2.Id];
    
        System.assertEquals('UpdatedJohn', updatedContact1.FirstName, 'First contact should be updated');
        System.assertEquals('UpdatedSmith', updatedContact2.LastName, 'Second contact should be updated');
    }
}
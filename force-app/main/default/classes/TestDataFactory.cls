@isTest
public class TestDataFactory {
    
    // Create a test Account
    @testVisible
    public static Account createAccount(Boolean insertRecord) {
        Account acc = new Account(
            Name = 'Test Account ' + System.currentTimeMillis(),
            Rating = 'Hot'
        );

        if (insertRecord) {
            insert acc;
        }
        return acc;
    }

    // Create test Contacts linked to an Account
    @testVisible
    public static List<Contact> createContacts(Account acc, Integer numContacts, Boolean insertRecords) {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 0; i < numContacts; i++) {
            Contact con = new Contact(
                FirstName = 'TestFirst' + i,
                LastName = 'TestLast' + i,
                Email = 'test' + i + '@example.com',
                AccountId = acc.Id
            );
            contacts.add(con);
        }

        if (insertRecords && !contacts.isEmpty()) {
            insert contacts;
        }
        return contacts;
    }

    // Create an Account with Contacts
    @testVisible
    public static Map<String, Object> createAccountWithContacts(Integer numContacts, Boolean insertRecords) {
        Account acc = createAccount(insertRecords);
        List<Contact> contacts = createContacts(acc, numContacts, insertRecords);

        return new Map<String, Object>{
            'account' => acc,
            'contacts' => contacts
        };
    }
    
    @testVisible
    public static List<Account> createAccountRecord(String name, Integer Count, Boolean isInsert){
        List<Account> accList = new List<Account>();
        
        for(integer i=1; i<=Count; i++){
            Account acc = new Account();
            acc.Name = Name + i;
			accList.add(acc);
        }
        if(isInsert){
            insert accList;
        }
        
        return accList;
        
    }
    
}
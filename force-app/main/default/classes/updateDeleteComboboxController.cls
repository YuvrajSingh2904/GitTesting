public with sharing class updateDeleteComboboxController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount() {
        List<Account> accList = [SELECT Id, Name, Rating FROM Account LIMIT 20];
        return accList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact() {
        List<Contact> conList = [SELECT Id, FirstName, LastName FROM Contact LIMIT 20];
        return conList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity() {
        List<Opportunity> oppList = [SELECT Id, Name, StageName FROM Opportunity LIMIT 20];
        return oppList;
    }
    @AuraEnabled
    public static string updateAccDetail(object accountData){
        system.debug('Account Data : ' + accountData );
        
        List<Account> accountList = (List<Account>)JSON.deserialize(JSON.serialize(accountData), List<Account>.class);

        system.debug('Account List : ' + accountList);

        if(!accountList.isEmpty()){
            update accountList;
            return 'Success';
        }
        return null;
    }

    @AuraEnabled
    public static string updatedContactDetail(object contactData){
       System.debug('Contact  Data: ' + contactData);

       List<Contact> conList = (List<Contact>)JSON.deserialize(JSON.serialize(contactData), List<Contact>.class);
       
       System.debug('Contact List: ' + conList);

       if(!conList.isEmpty()){
           update conList;
           return 'Successfully Updated';
       }
       return null;
    }

    @AuraEnabled
    public static string updateOppDetail(object oppData){
        system.debug('Opportunity Data : ' + oppData );

        List<Opportunity> oppList = (List<Opportunity>)JSON.deserialize(JSON.serialize(oppData), List<Opportunity>.class);  

        system.debug('Opportunity List : ' + oppList);

        if(!oppList.isEmpty()){
            update oppList;
            return 'Success';
        }
        return null;
    }

    @AuraEnabled
    public static void deleteRecords(List<Id> recordIds){
        try {
            List<SObject> recordsToDelete = [SELECT Id FROM Account WHERE Id IN :recordIds];
            delete recordsToDelete;
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteConRecords(List<Id> recordIds){
        try {
            List<SObject> recordsToDelete = [SELECT Id FROM Contact WHERE Id IN :recordIds];
            delete recordsToDelete;
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteOppRecords(List<Id> recordIds){
        try {
            List<SObject> recordsToDelete = [SELECT Id FROM Opportunity WHERE Id IN :recordIds];
            delete recordsToDelete;
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}
public class accountDataTableWRadioButtonController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount() {
        List<account> accList = [SELECT Id, Name, Rating FROM Account LIMIT 5];
        return accList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(String accountId){
        //Id newId = Id.valueOf(accountId);
        List<Contact> conList = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId =: accountId];
        
        System.debug('contactList: '+conList);
        return conList;
    }

    @AuraEnabled
    public static string updatedContactDetail(string contactData){
       System.debug('Contact  Data: ' + contactData);

       List<Contact> conList = (List<Contact>)JSON.deserialize(JSON.serialize(contactData), List<Contact>.class);
       
       System.debug('Contact List: ' + conList);

       if(!conList.isEmpty()){
           update conList;
           return 'Successfully Updated';
       }
       return null;
    }
}  




// @AuraEnabled(cacheable=true)
    // public static List<Contact> saveContact(String ContactId, String FirstName, String LastName){
        
    //     List<Contact> updatedContactlist = new List<Contact>();

    //     if(ContactId != Null){
    //         Contact con = new Contact();
    //         con.FirstName = FirstName;
    //         con.LastName = LastName;
    //         updatedContactlist.add(con);
    //     }

    //     if(!updatedContactlist.isEmpty()){
    //         System.debug('UpdatedContactList :'+ updatedContactlist);
    //         update updatedContactlist;
    //         return updatedContactlist;
    //     }   
    // }
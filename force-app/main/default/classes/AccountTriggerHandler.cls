public with sharing class AccountTriggerHandler {
    //Write a trigger whenever the Account Rating is changing then the Old Value of the rating should be populated in the Account description
    public static void updateDescriptionBasedonRating(List<Account> accList, Map<id, Account> oldMap){
        for (Account acc: accList){
            Account oldAcc = oldMap.get(acc.id);
            if(acc.Rating != oldAcc.Rating){
                acc.Description = oldAcc.Rating;
            }
        }
    }
    
    //whenver account's phone field is updated then all related contacts phone should also get updated with parent account's phone 
    public static void updateContactPhone(List<Account> accList, Map<Id, Account> oldMap){
        Set<Id> accIds = new Set<Id>();
        Map<Id, String> accMap = new map<Id,String>();
        for(Account acc : accList){
            if(acc.Phone != null && acc.Phone != oldMap.get(acc.Id).Phone){
                accIds.add(acc.Id);
                accMap.put(acc.Id, acc.Phone);
            }
        }
    }
    ///write a trigger on Account, when an account is inserted, automatically account billing address 
    //should populate into the account shipping address
    public static void triggerMethod(List<Account> accList){
        
        For(Account ac: accList){
            if(ac.Phone != null){
                ac.Fax = ac.Phone;
                
            }
        }
        
    }
    /*write a trigger We have a custom field on the Account object called "No of Branches" 
* whenever an Account is created or updated if the "No of Branches" field is populated 
* or its value is increased the system should automatically create that many Opportunity records related to the Account. 
* suppose if the field has value 3 and we are updating to 4 then only 1 opportunity should get created  
*/
    public static void interviewQ(List<Account> accList, Map<Id, Account> oldMap){
        List<Opportunity> oppUpdate = new List<Opportunity>();
        for(Account acc : accList){
            Account oldAcc = oldMap.get(acc.id);
            Integer currentCount;
            Integer previousCount;
            if(acc.aaTestNamespace__No_of_Branches__c == null){
                currentCount = 0;
            }else if(oldAcc.aaTestNamespace__No_of_Branches__c == null){
                previousCount = 0;
            }else {
                currentCount = (Integer)acc.aaTestNamespace__No_of_Branches__c;
                previousCount = (Integer)oldAcc.aaTestNamespace__No_of_Branches__c;
            }
            System.Debug('Current Count --->' + currentCount);
            System.Debug('previousCount --->' + previousCount);
            
            if(acc.aaTestNamespace__No_of_Branches__c != oldAcc.aaTestNamespace__No_of_Branches__c && currentCount > previousCount){
                Integer Diff = currentCount - previousCount;
                //Integer Difference = (Integer)Diff;
                for(Integer i = 0; i<Diff; i++){
                    Opportunity opp = new Opportunity();
                    opp.Name = acc.Name + 'Branch Opportunity' + (previousCount + i);
                    opp.AccountId = acc.Id;
                    opp.StageName = 'Prospecting';
                    opp.CloseDate = Date.Today().addDays(30);
                    
                    oppUpdate.add(opp);
                }
                
            }
        }
        System.Debug('Opp to Update ---> ' + oppUpdate);
        if(!oppUpdate.isEmpty()){
            Insert oppUpdate;
        }
        
    }
    
}
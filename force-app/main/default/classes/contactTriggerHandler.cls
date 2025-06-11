public class contactTriggerHandler {
    //Account can only have one Primary Contact
    public static void PrimaryContactValidation(List<Contact> conList, Map<Id, Contact> oldMap){
        Set<Id> parentId = new Set<Id>();
        For(Contact con: conList){
            if(con.AccountId != null){
                parentId.add(con.AccountId);
            }
        }
        Map<Id, List<Contact>> accountToPrimary = new Map<Id, List<Contact>>();
        for(Contact exCon: [SELECT Id, AccountId, Primary_Contact__c FROM Contact WHERE AccountId IN :parentId and Primary_Contact__c = TRUE]){
            if(!accountToPrimary.containsKey(exCon.AccountId)){
                accountToPrimary.put(exCon.AccountId, new List<Contact>());
            }
            accountToPrimary.get(exCon.AccountId).add(exCon);
        }
        
        
        for(Contact con: conList){
            if(con.Primary_Contact__c && con.AccountId != null){
                List<Contact> primaryCons = accountToPrimary.get(con.AccountId);
                if(Trigger.isInsert || (Trigger.isUpdate && oldMap.get(con.Id).Primary_Contact__c != false)){
                    Integer Count;
                    if(primaryCons != null){
                        Count = primaryCons.size();
                    }
                    else{
                        Count = 0;
                    }
                    if(Count > 0){
                        con.addError('This Account already has a primary Contact.');
                    }
                }
                
                
            }
        }
        
        
        
    }
    
    //No more than 5 contacts in an Account
    public Static void contactLimitValidation(List<Contact> conList, Map<Id, Contact> oldMap){
        Set<Id> primaryId = new Set<Id>();
        For(Contact con: conList){
            if(Con.AccountId != null){
                primaryId.add(con.AccountId);
            }
        }
        
        Map<Id, List<Contact>> accToConMap = new Map<Id, List<Contact>>();
        for(Contact con: [SELECT Id, AccountId FROM Contact WHERE AccountId IN :primaryId]){
            if(!accToConMap.containsKey(con.AccountId)){
                accToConMap.put(con.AccountId, new List<Contact>());
            }
            accToConMap.get(con.AccountId).add(con);
        }
        
        for(Contact con: conList){
            if(con.AccountId != null){
                List<Contact> exCons = accToConMap.get(con.AccountId);
                if(exCons == null){
                    exCons = new List<Contact>();
                    accToConMap.put(con.AccountId, exCons);
                }
                exCons.add(con);
                
                if(exCons.size() > 5){
                    con.addError('You cannout add more that 5 contacts');
                }
            }
        }
    }
    //update the number of the contact assosciated to an account
    public static void numberOfContacts(List<Contact> conList, Map<id, Contact> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isUndelete){
        set<Id> accIds = new set<Id>();
        if(isInsert || isUndelete){
            for(Contact con: conList){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
        if(isUpdate){
            for(Contact con : conList){
                Id oldAccId = oldMap.get(con.Id).AccountId;
                Id newAccId = con.AccountId;
                if(oldAccId != null) accIds.add(oldAccId);
                if(newAccId != null) accIds.add(newAccId);
            }
        }
        if(isDelete){
            for(Contact con : oldMap.values()){
                if(con.AccountId != null){
                    accIds.add(con.AccountId);
                }
            }
        }
        
        Map<id, List<contact>> accIdToCon = new Map<id, List<Contact>>();
        for(Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accIds]){
            if(!accIdToCon.containsKey(con.AccountId)){
                accIdToCon.put(con.AccountId, new List<Contact>());
            }
            accIdToCon.get(con.AccountId).add(con);
        }
        List<Account> accToUpdate = new List<Account>();
        for(Id accId : accIds){
            List<contact> conFromMap = accIdToCon.get(accId);
            if(conFromMap != null){
                Integer conCount = conFromMap.size();
                Account acc = new Account( Id = accId, 
                                          Number_of_Contacts__c = conCount);
                accToUpdate.add(acc);
            }
            
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    
}
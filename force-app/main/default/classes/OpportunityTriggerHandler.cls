public class OpportunityTriggerHandler {
    public static void updateParentTotalAmount(List<Opportunity> newOpps, List<Opportunity> oldOpps, Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
        Set<Id> accountIds = new Set<Id>();

        // Add Account IDs for Insert, Update and Undelete operations
        if (isInsert || isUpdate || isUndelete) {
            for (Opportunity opp : newOpps) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        // Add Account IDs for Delete operations
        if (isDelete) {
            for (Opportunity opp : oldOpps) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        // Update the Total_Amount__c field on the Account
        updateAccountTotalAmount(accountIds);
    }

    private static void updateAccountTotalAmount(Set<Id> accountIds) {
        // Map to store Account Id and their total amounts
        Map<Id, Decimal> accountTotalAmounts = new Map<Id, Decimal>();

        // Query Opportunities grouped by AccountId and calculate sum of Amount
        for (AggregateResult ar : [SELECT AccountId, SUM(Amount) totalAmount FROM Opportunity WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountTotalAmounts.put((Id)ar.get('AccountId'), (Decimal)ar.get('totalAmount'));
        }

        // List to store Accounts to update
        List<Account> accountsToUpdate = new List<Account>();

        // Iterate through the map and update Total_Amount__c field on Account
        for (Id accountId : accountTotalAmounts.keySet()) {
            accountsToUpdate.add(new Account(Id = accountId, Total_Amount__c = accountTotalAmounts.get(accountId)));
        }

        // Perform the update operation
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    
    public static void updateAccountRating(List<Opportunity> oppList){
        Map<Id, Id> accountToOpportunityMap = new Map<Id, Id>();
        // Collect all accounts that need to be checked 
        for(Opportunity opp : oppList) { 
            if(opp.StageName == 'Closed Won' && opp.AccountId != null) { 
                accountToOpportunityMap.put(opp.AccountId, opp.Id); } 
        } // Check all accounts for which opportunities are in 'Closed Won' stage 
        List<Account> accountsToUpdate = new List<Account>();
        for(Id accountId : accountToOpportunityMap.keySet()) { 
            Boolean allOpportunitiesClosedWon = true; 
            for(Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE AccountId = :accountId]) {
                if(opp.StageName != 'Closed Won') {
                    allOpportunitiesClosedWon = false; break;
                } 
            } if(allOpportunitiesClosedWon) {
                accountsToUpdate.add(new Account(Id = accountId, Rating = 'Hot')); 
            } 
        } // Update account rating 
        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate; 
        }
    }
}
public class DataFactory {
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
@RestResource(Urlmapping = '/AccountContactApi')
global class AccountConAPi {
	@httpPost
    global static void saveAccConFromExtSys(){
        RestRequest req = RestContext.Request;
        RestResponse res = RestContext.Response;
        
        String body = req.requestBody.toString();
        MyJsonCls myObj = (MyJsonCls) JSON.deserialize(body, MyJsonCls.class);
        
        System.debug('@@@' + myObj.CustomerName);
        
        if(myObj.isAccount == true){
            Account acc = new Account(Name = myObj.CustomerName);
            INSERT acc;
        }
        else if(myObj.isAccount == false){
            Contact con = new Contact(Lastname = myObj.CustomerName);
            INSERT con;
        }
    }
}
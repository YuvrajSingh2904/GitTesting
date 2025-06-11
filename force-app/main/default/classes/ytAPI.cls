public with sharing class ytAPI {
    public static void sendYTJson(){
        
        List<MainWrapper> mainWrapperList = new List<MainWrapper>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.SetEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            String result = String.valueOf( JSON.deserializeUntyped(response.getBody()) );
            system.debug('Result --> ' + result);
           // YoutubeResult result = YoutubeResult.parse(response.getBody());
            //system.debug('Parsed Value --> ' + result);
            MainWrapper wrap = (MainWrapper)JSON.deserialize(result, MainWrapper.class);
            System.debug('Wrap --> ' + wrap);
           
            
        }
    }
    
    public class MainWrapper{
        public integer userId{get;set;}
        public integer id{get;set;}
        public string title{get;set;}
        public string completed{get;set;}
    } 


        
}
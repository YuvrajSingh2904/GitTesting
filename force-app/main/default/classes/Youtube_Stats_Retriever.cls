public with sharing class Youtube_Stats_Retriever {
    //SFDCFactsAcademy - UCMjPIPV4-WfywFcCkXnHr6w&key
    //Sanjay Gupta - UCI4ifRomfs0DMT5PB8iVclw
    private static final string YOUTUBE_URL = 'https://youtube.googleapis.com/youtube/v3/channels?part=snippet&part=contentDetails&part=statistics&id=UCI4ifRomfs0DMT5PB8iVclw&key=AIzaSyD_SSLvICEYA5jvp6cT84xGY-AiRduOZF8';
    private static final string Get = 'GET';
    @AuraEnabled(cacheable=true)
    public static List<myWrapper> getStats(){
        List<myWrapper> wrp = new List<myWrapper>();

        Http httpCallout = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(YOUTUBE_URL);
        req.setMethod(GET);
        
        HttpResponse youtubeResponse = httpCallout.send(req);
        Youtube_Result youtubeStatsResponse = Youtube_Result.parse(youtubeResponse.getBody()); 
        List<Youtube_Result.Items> ytResponseItems = youtubeStatsResponse.Items;
       // System.debug('YoutubeStatsResponseItems ' + ytResponseItems);

        for(Youtube_Result.Items itm : ytResponseItems){
               myWrapper YTWrap = new myWrapper();
               YTWrap.title = itm.snippet.title;
               YTWrap.viewCount = itm.statistics.viewCount;
               YTWrap.subscriberCount = itm.statistics.subscriberCount;
               YTWrap.videoCount = itm.statistics.videoCount;
               wrp.add(YTWrap);

        }

        System.debug('wrp: ' + wrp);

        return wrp;
    }

    public class myWrapper {
        @AuraEnabled
        public string title;
        @AuraEnabled
        public string viewCount;
        @AuraEnabled
        public String subscriberCount;
        @AuraEnabled
        public String videoCount;
    }
}
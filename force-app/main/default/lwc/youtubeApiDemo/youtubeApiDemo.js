import { LightningElement, wire, track } from 'lwc';
import getStats from '@salesforce/apex/Youtube_Stats_Retriever.getStats';

export default class YoutubeApiWireDemo extends LightningElement {
    @track ytStats ;
    @track title;
    @track viewCount;
    @track subscriberCount;
    @track videoCount;


    @wire(getStats) 
    wiredData({data,error}){
        if(data){
            this.ytStats = data[0];
            console.log("STATS-----", JSON.stringify(this.ytStats));
            this.title = this.ytStats.title;
            this.viewCount = this.ytStats.viewCount;
            this.videoCount = this.ytStats.videoCount;
            this.subscriberCount = this.ytStats.subscriberCount;
            
        }
        else if(error){
            console.log(error)
        }
    };
 

}
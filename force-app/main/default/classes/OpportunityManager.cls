@RestResource(urlMapping='/Opportunities/*')
	global with sharing class OpportunityManager {

	@HttpPost
	global static ID createOpportunity(String name, String stage,String closedate, String source) {
		Opportunity newOpportunity = new Opportunity( 
                                            name=name,
                                            stageName=stage,
                                            leadSource=source,
                                            closedate=Date.valueOf(closedate));

		insert newOpportunity;
		return newOpportunity.Id;

	}
}
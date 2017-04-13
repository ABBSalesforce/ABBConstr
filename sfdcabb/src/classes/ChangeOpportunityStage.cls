global class ChangeOpportunityStage{
    
    webservice static Id ChangeOpportunityStage(Id OpportunityId){
        Opportunity OppItr = new Opportunity(id=OpportunityId,StageName='Submitted to COPS');
        if(OppItr != null)
            update OppItr;
        return OppItr.id;
    }
}
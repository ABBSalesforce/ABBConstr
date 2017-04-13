trigger PRITrigger on PRI__c (After insert, After delete) {
    
    Set<id> OppIdsSet = new Set<id>();
    for(PRI__c objPri : trigger.isInsert?trigger.new:trigger.old){
        OppIdsSet.add(objPri.Opportunity__c);
    }
    List<Opportunity> OppList = new List<opportunity>();
    for(Opportunity objOpp : [SELECT Id, (SELECT Id FROM FlexTrunk_PRI__r Limit 1) FROM Opportunity 
                                    WHERE Id IN : OppIdsSet AND RecordType.DeveloperName= 'PRI_Service']) {
        if(objOpp.FlexTrunk_PRI__r.isEmpty()) {
            objOpp.Required_PRI__c = 'Required';
        }
        else {
            objOpp.Required_PRI__c = 'Completed';
        }
        OppList.add(objOpp);
    }
    Update OppList;
}
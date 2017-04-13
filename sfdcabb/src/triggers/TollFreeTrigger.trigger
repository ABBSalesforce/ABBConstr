trigger TollFreeTrigger on Tollfree__c (After insert, After delete) {
     Map<Id,PQ__c> mapIdToPQIds = new Map<Id,PQ__c>();
    
    if(trigger.isInsert) {
        for(Tollfree__c objTolFree :trigger.new ) {
            mapIdToPQIds.put(objTolFree.PQ__c, new PQ__c(Id=objTolFree.PQ__c,Toll_Free_Complete__c=true));
        }
        Update mapIdToPQIds.values();
    }
    if(trigger.isDelete) {
        Set<Id> PQIdsSet = new Set<Id>();
        for(Tollfree__c objTolFree :trigger.old) {
            PQIdsSet.add(objTolFree.PQ__c);
        }    
        for(PQ__c objPQ : [SELECT Id, (SELECT Id FROM Toll_frees__r WHERE ID NOT IN : trigger.oldMap.keySet() Limit 1) 
                            FROM PQ__c WHERE Id IN : PQIdsSet]) {
            if(objPQ.Toll_frees__r.isEmpty()) {
                mapIdToPQIds.put(objPQ.Id, new PQ__c(Id=objPQ.Id,Toll_Free_Complete__c=false));
            }
        }
        Update mapIdToPQIds.values();
    }
}
trigger MultipleDLsTrigger on MultipleDL__c (After insert, After Delete) {
    Map<Id,PQ__c> mapIdToPQIds = new Map<Id,PQ__c>();
    
    if(trigger.isInsert) {
        for(MultipleDL__c objMultDls : trigger.new ) {
            mapIdToPQIds.put(objMultDls.PQ_Lookup__c, new PQ__c(Id=objMultDls.PQ_Lookup__c, Multiple_DLs_Complete__c=true));
        }
        Update mapIdToPQIds.values();
    }
    if(trigger.isDelete) {
        Set<Id> PQIdsSet = new Set<Id>();
        for(MultipleDL__c objMultDls : trigger.old) {
            PQIdsSet.add(objMultDls.PQ_Lookup__c);
        }    
        for(PQ__c objPQ : [SELECT Id, (SELECT Id FROM MultipleDLs__r WHERE Id NOT IN : trigger.oldMap.keySet() Limit 1) 
                                FROM PQ__c WHERE Id IN : PQIdsSet]) {
            if(objPQ.MultipleDLs__r.isEmpty()) {
                mapIdToPQIds.put(objPQ.Id, new PQ__c(Id=objPQ.Id, Multiple_DLs_Complete__c=false));
            }
        }
        Update mapIdToPQIds.values();
    }
}
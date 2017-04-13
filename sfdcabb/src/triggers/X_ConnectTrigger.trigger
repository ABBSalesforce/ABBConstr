trigger X_ConnectTrigger on X_Connect__c (After insert, After delete) {
     Map<Id,PQ__c> mapIdToPQIds = new Map<Id,PQ__c>();
    
    if(trigger.isInsert) {
        for(X_Connect__c objXconnect : trigger.new ) {
            mapIdToPQIds.put(objXconnect.PQ__c, new PQ__c(Id=objXconnect.PQ__c, X_Connect_Complete__c=true));
        }
        Update mapIdToPQIds.values();
    }
    if(trigger.isDelete) {
        Set<Id> PQIdsSet = new Set<Id>();
        for(X_Connect__c objXconnect : trigger.old) {
            PQIdsSet.add(objXconnect.PQ__c);
        }    
        for(PQ__c objPQ : [SELECT Id, (SELECT Id FROM X_Connects__r WHERE Id NOT IN : trigger.oldMap.keySet() Limit 1) 
                            FROM PQ__c WHERE Id IN : PQIdsSet]) {
            if(objPQ.X_Connects__r.isEmpty()) {
                mapIdToPQIds.put(objPQ.Id, new PQ__c(Id=objPQ.Id, X_Connect_Complete__c=false));
            }
        }
        Update mapIdToPQIds.values();
    }
}
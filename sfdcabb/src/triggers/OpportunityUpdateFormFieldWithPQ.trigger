trigger OpportunityUpdateFormFieldWithPQ on PQ__c (After insert, After update, After delete) {

    Set<String> RecTypeForPQ = new Set<String> {'Vid_HSD_Phone', 'HSD_Phone', 'Phone_only','Video_Phone'};
    Set<String> RecTypeForLOA = new Set<String> {'Vid_HSD_Phone', 'HSD_Phone', 'Phone_only','Video_Phone'};
    Set<String> RecTypeForMDL = new Set<String> {'Vid_HSD_Phone', 'HSD_Phone', 'Phone_only', 'PRI_Service','Video_Phone'};
    Map<Id, RecordType> mapRecType = new Map<Id,RecordType>([Select DeveloperName, SobjectType From RecordType 
                                                                Where SobjectType = 'Opportunity' AND DeveloperName IN : RecTypeForMDL]);
    
    Set<Id> setOppIdsRelatedToPortedPQ = new Set<Id>();
    Set<Id> setOppIdsRelatedToMDLPQ = new Set<Id>();
    Set<Id> setOppIdsRelatedToXConnectPQ = new Set<Id>();
    Set<Id> setOppIdsRelatedToTollFreePQ = new Set<Id>();
    Set<Id> OppIdsSet = new Set<Id>();
   
    
    if(trigger.isInsert) 
    {    
        for(PQ__c objPQ : trigger.new) {
            OppIdsSet.add(objPQ.Opportunity__c);    
            Boolean isHosted = String.isNotBlank(objPQ.TN1__c) || String.isNotBlank(objPQ.TN2__c)||String.isNotBlank(objPQ.TN3__c)
                                 ||String.isNotBlank(objPQ.TN4__c) ||String.isNotBlank(objPQ.TN5__c) ||String.isNotBlank(objPQ.TN6__c)
                                 ||String.isNotBlank(objPQ.TN7__c)||String.isNotBlank(objPQ.TN8__c);
           
             if(isHosted) 
                setOppIdsRelatedToPortedPQ.add(objPQ.Opportunity__c); 
            
            if(objPQ.Multiple_DL__c) 
                setOppIdsRelatedToMDLPQ.add(objPQ.Opportunity__c);
            
            if(objPQ.Tollfree_Number__c)
                setOppIdsRelatedToTollFreePQ.add(objPQ.Opportunity__c)  ;
            
            if(objPQ.Telephone_System__c && objPQ.Contractor_Required__c)
                setOppIdsRelatedToXConnectPQ.add(objPQ.Opportunity__c);
        }
        
        List<Opportunity> oppList = [SELECT RecordTypeId, Required_XConnect__c, Required_LOA__c, Required_MDL__c, Required_TFN__c,
                                    Required_PQ__c FROM Opportunity WHERE Id IN : OppIdsSet AND RecordTypeId IN : mapRecType.keySet()];
        
        
        Map<Id,Opportunity> mapIdToOppForUpdate = new Map<Id,Opportunity>(); 
        for(Opportunity objOpp : oppList) {
        
            if(objOpp.Required_PQ__c == 'Required') { 
                objOpp.Required_PQ__c = 'Completed';
                mapIdToOppForUpdate.put(objOpp.Id, objOpp);
            }
            
            if(setOppIdsRelatedToMDLPQ.contains(objOpp.Id) && objOpp.Required_MDL__c != 'Completed') {
                objOpp.Required_MDL__c = 'Required';
                mapIdToOppForUpdate.put(objOpp.Id, objOpp);
            }
            if(setOppIdsRelatedToTollFreePQ.contains(objOpp.Id) && objOpp.Required_TFN__c != 'Completed') {
                objOpp.Required_TFN__c = 'Required';
                mapIdToOppForUpdate.put(objOpp.Id, objOpp);
            }
            if(setOppIdsRelatedToXConnectPQ.contains(objOpp.Id) && objOpp.Required_XConnect__c != 'Completed') {
                objOpp.Required_XConnect__c = 'Required';
                mapIdToOppForUpdate.put(objOpp.Id, objOpp);
            }
            if(setOppIdsRelatedToPortedPQ.contains(objOpp.Id) && (objOpp.Required_LOA__c != 'Completed' && objOpp.Required_LOA__c != 'Submitted') && RecTypeForLOA.contains(mapRecType.get(objOpp.RecordTypeId).DeveloperName)) {
                objOpp.Required_LOA__c = 'Required';
                mapIdToOppForUpdate.put(objOpp.Id, objOpp);
            }
        }
        if(! mapIdToOppForUpdate.isEmpty()) {
//            OpportunityUpdate.isRunningTrigger = true;
            Update mapIdToOppForUpdate.values();
            System.debug('mapIdToOppForUpdate-------------'+mapIdToOppForUpdate.values());
        }
    }
                    
            
    if(trigger.isUpdate || trigger.isDelete) {
        
        for(PQ__c objPQ : trigger.isDelete?trigger.old:trigger.new) {
    
            OppIdsSet.add(objPQ.Opportunity__c);    
        }
        System.debug('Update PQ ---------'+OppIdsSet);
        //where ID NOT IN : trigger.oldmap.keySet()
        
        Set<Id> DeletedPQIds = new Set<Id>();
        if(trigger.isDelete) {
            DeletedPQIds.addAll(trigger.oldMap.keySet());
        }
         
        Map<Id, WR_OppCompleteStatue> mapOppIdToReqStatus = new Map<Id, WR_OppCompleteStatue>(); 
        
        Map<Id,Opportunity> mapIdToOpp = new Map<Id,Opportunity>([SELECT (SELECT Opportunity__c, Telephone_System__c, Contractor_Required__c, 
                                                                    isHosted1__c, isHosted2__c, isHosted3__c, isHosted4__c, isHosted5__c, 
                                                                    isHosted6__c, isHosted7__c, isHosted8__c, Multiple_DL__c, Tollfree_Number__c,
                                                                    X_Connect_Complete__c, Site_Survey_Complete__c, LOA_Complete__c, 
                                                                    Toll_Free_Complete__c, Multiple_DLs_Complete__c,TN1__c,TN2__c,TN3__c,
                                                                    TN4__c,TN5__c,TN6__c,TN7__c,TN8__c
                                                                    FROM PQ__r WHERE ID NOT IN : DeletedPQIds),RecordTypeId, Required_XConnect__c, Required_LOA__c, 
                                                                    Required_MDL__c, Required_TFN__c FROM Opportunity 
                                                                    WHERE Id IN : OppIdsSet AND RecordTypeId IN : mapRecType.keySet()]);
        System.debug('At PQ Update---------'+mapIdToOpp);
        Set<Id> noPQOppIds = new Set<Id>();
        for(opportunity objOpp : mapIdToOpp.values()) {
           
            WR_OppCompleteStatue objWrCls = new WR_OppCompleteStatue();
            
            if(objOpp.PQ__r.isEmpty()) {
                noPQOppIds.add(objOpp.Id);
              //  objOpp.Required_PQ__c = objOpp.Required_MDL__c = objOpp.Required_TFN__c =  objOpp.Required_XConnect__c = '';
            }
            
            for(PQ__c objPQ : objOpp.PQ__r) {
                
                if(objPQ.X_Connect_Complete__c)
                    objWrCls.X_Connect_Complete = 'Completed';
                
                if(objPQ.Toll_Free_Complete__c)
                    objWrCls.Toll_Free_Complete = 'Completed';
               
                if(objPQ.Multiple_DLs_Complete__c)
                    objWrCls.Multiple_DLs_Complete = 'Completed';
               
                if(objPQ.Multiple_DL__c) 
                    setOppIdsRelatedToMDLPQ.add(objPQ.Opportunity__c);
                
                if(objPQ.Tollfree_Number__c)
                    setOppIdsRelatedToTollFreePQ.add(objPQ.Opportunity__c)  ;
                
                if(objPQ.Telephone_System__c && objPQ.Contractor_Required__c)
                    setOppIdsRelatedToXConnectPQ.add(objPQ.Opportunity__c);
                
                    
                Boolean isHosted = String.isNotBlank(objPQ.TN1__c) || String.isNotBlank(objPQ.TN2__c)||String.isNotBlank(objPQ.TN3__c)
                                     ||String.isNotBlank(objPQ.TN4__c) ||String.isNotBlank(objPQ.TN5__c) ||String.isNotBlank(objPQ.TN6__c)
                                     ||String.isNotBlank(objPQ.TN7__c)||String.isNotBlank(objPQ.TN8__c);
               
                if(isHosted) {
                    setOppIdsRelatedToPortedPQ.add(objPQ.Opportunity__c); 
                }
                /*
                if(objPQ.Site_Survey_Complete__c)
                    objWrCls.Site_Survey_Complete = 'Completed';
                
                if(objPQ.LOA_Complete__c)
                    objWrCls.LOA_Complete = 'Completed';
                */
            }
            mapOppIdToReqStatus.put(objOpp.Id, objWrCls);
        }
        
        Map<Id,Opportunity> mapIdToOppForUpdate2 = new Map<Id,Opportunity>(); 
        for(Id itrOppId : OppIdsSet) {
            
            Opportunity objOpp = mapIdToOpp.get(itrOppId);
            if(objOpp == null)
                continue;
            
            if(noPQOppIds.contains(objOpp.Id)) {
                objOpp.Required_PQ__c = objOpp.Required_MDL__c = objOpp.Required_TFN__c =  objOpp.Required_XConnect__c = '';
                objOpp.Required_LOA__c = '';
            }
            
            if(objOpp.Required_MDL__c != 'Completed')
                objOpp.Required_MDL__c = '';
            if(objOpp.Required_TFN__c != 'Completed')
                objOpp.Required_TFN__c = '';
            if(objOpp.Required_XConnect__c != 'Completed')
                objOpp.Required_XConnect__c = '';
            if((objOpp.Required_LOA__c != 'Completed' &&  objOpp.Required_LOA__c != 'Submitted')) {
                objOpp.Required_LOA__c = '';
            }
            
            if(objOpp.Required_MDL__c != 'Completed' && setOppIdsRelatedToMDLPQ.contains(objOpp.Id) && RecTypeForMDL.contains(mapRecType.get(objOpp.RecordTypeId).DeveloperName)) {
                objOpp.Required_MDL__c = mapOppIdToReqStatus.get(objOpp.Id).Multiple_DLs_Complete;
            }
            if(objOpp.Required_TFN__c != 'Completed' && setOppIdsRelatedToTollFreePQ.contains(objOpp.Id) && RecTypeForMDL.contains(mapRecType.get(objOpp.RecordTypeId).DeveloperName)) {
                objOpp.Required_TFN__c = mapOppIdToReqStatus.get(objOpp.Id).Toll_Free_Complete;
            }
            if(objOpp.Required_XConnect__c != 'Completed' && setOppIdsRelatedToXConnectPQ.contains(objOpp.Id) && RecTypeForMDL.contains(mapRecType.get(objOpp.RecordTypeId).DeveloperName)) {
                objOpp.Required_XConnect__c = mapOppIdToReqStatus.get(objOpp.Id).X_Connect_Complete;
            }
            
            if(setOppIdsRelatedToPortedPQ.contains(objOpp.Id) && RecTypeForLOA.contains(mapRecType.get(objOpp.RecordTypeId).DeveloperName) 
                    && objOpp.Required_LOA__c == '') {
                objOpp.Required_LOA__c = mapOppIdToReqStatus.get(objOpp.Id).LOA_Complete;
            }
            /*else if(setOppIdsRelatedToPortedPQ.contains(objOpp.Id) == false && (objOpp.Required_LOA__c == 'Completed' || objOpp.Required_LOA__c == 'Submitted'))
               objOpp.Required_LOA__c = '';*/
           
    //      objOpp.Required_Site_Survey__c = mapOppIdToReqStatus.get(objOpp.Id).Site_Survey_Complete;
            mapIdToOppForUpdate2.put(objOpp.Id, objOpp);
        }
        if(! mapIdToOppForUpdate2.isEmpty()) {
//          OpportunityUpdate.isRunningTrigger = true;
            Update mapIdToOppForUpdate2.values();
        }
       
    }

    class WR_OppCompleteStatue{
        String X_Connect_Complete;
        String Site_Survey_Complete;
        String LOA_Complete;
        String Toll_Free_Complete;
        String Multiple_DLs_Complete;
        public WR_OppCompleteStatue() {
            X_Connect_Complete =  Toll_Free_Complete = LOA_Complete  = Multiple_DLs_Complete = 'Required';
            //Site_Survey_Complete = LOA_Complete 
            
        }
    }                        
                  
}
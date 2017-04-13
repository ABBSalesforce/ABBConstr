trigger OpportunityUpdateFormField on Opportunity (Before insert, Before update, After insert) {
    
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
         
            Map<Id,RecordType> mapRecType = new Map<Id,RecordType>([SELECT DeveloperName FROM RecordType WHERE SobjectType = 'Opportunity']);
       
            Set<String> RecTypeForSiteSurvey = new Set<String>{'Vid_HSD_Phone', 'HSD_Phone', 'Phone_only', 'PRI_Service','Video_Phone'};
            Set<String> RecTypeForPQ = new Set<String>{'Vid_HSD_Phone', 'HSD_Phone', 'Phone_only','Video_Phone'};
            Set<String> RecTypeNonRequire = new Set<String>{'HSD_only','Fiber','Bulk_Services','Video_only','Vid_HSD','Other_non_standard_services','h_Change_Request','Limited_Usage'};
            Set<Id> setOpportunityId = new Set<Id>();
            Set<Id> setOpportunityUpdate = new Set<Id>();
            
            for(Opportunity objItr : trigger.new){
                if(objItr.amount != NULL && objItr.amount >= 100){ setOpportunityUpdate.add(objItr.id);}
                 else setOpportunityId.add(objItr.id);
            }
            
            for(Opportunity opp : [SELECT id, Required_Agreement__c,(SELECT id, Required_Agreement__c 
                                   FROM OpportunityLineItems WHERE Required_Agreement__c = true)
                                   FROM Opportunity WHERE Id IN :setOpportunityId])
            {
                if(!opp.OpportunityLineItems.isEmpty()){
                     setOpportunityUpdate.add(opp.id);
                }    
            }
       
            for(Opportunity objOpp : trigger.new) {
                if(objOpp.RecordTypeId == Null) 
                    Continue;
                String OppRecType = mapRecType.get(objOpp.RecordTypeId).DeveloperName;
                System.debug('required_PQ'+objOpp.Required_PQ__c );
                
                if(RecTypeNonRequire.Contains(OppRecType)){
                    if(objOpp.Required_PQ__c != 'Completed' && objOpp.Required_PQ__c != 'Submitted') 
                        {objOpp.Required_PQ__c ='N/A';}
                    if(objOpp.Required_PRI__c != 'Completed')
                        {objOpp.Required_PRI__c='N/A';}
                    if(objOpp.Required_Site_Survey__c != 'Completed' && objOpp.Required_Site_Survey__c != 'Submitted') 
                        {objOpp.Required_Site_Survey__c ='N/A';}
                }
                
                if(RecTypeForSiteSurvey.Contains(OppRecType) && objOpp.Required_Site_Survey__c != 'Completed' && objOpp.Required_Site_Survey__c != 'Submitted' ) 
                    objOpp.Required_Site_Survey__c= 'Required';
                
                if(RecTypeForPQ.Contains(OppRecType) && objOpp.Required_PQ__c != 'Completed') {
                    objOpp.Required_PQ__c = 'Required';
                    if(objOpp.Required_PRI__c != 'Completed') objOpp.Required_PRI__c = 'N/A';
                 }
                 
                if(OppRecType == 'PRI_Service' && objOpp.Required_PRI__c != 'Completed' ){
                    objOpp.Required_PRI__c = 'Required';
                     if(objOpp.Required_PQ__c != 'Completed') objOpp.Required_PQ__c = 'N/A';    
                }
               

                
                if(objOpp.Required_Agreement__c != 'Completed') {  
                    //System.debug('==psdfsfsfsdfsfdssaravanan' + objOpp.Required_Agreement__c);  
                    if(setOpportunityUpdate.contains(objOpp.id))
                        if (objOpp.Required_Agreement__c != 'Counter Signature'){
                            objOpp.Required_Agreement__c = 'Required';
                            }
                   // else
                    //System.debug('==psdfsfsfsdfsfdssaravanan' + objOpp.id);
                    
                    
                         //objOpp.Required_Agreement__c = 'N/A';
                }
                //if (objOpp.Required_Agreement__c == 'Counter Signature'){
               // objOpp.Required_Agreement__c = 'Required';
               // }
           }
           
           
            if(Trigger.isInsert){
                List<Pricebook2> prcbooklist = [select id,name from pricebook2];
                 Map<String,Id> prcbookMap = new Map<String,Id>();
                 Map<Id,String> abbAccmap = new Map<Id,String>();
                 Set<Opportunity> OppItrortunityUpdateIds = new Set<Opportunity>();
                 Set<Id> accountIds = new Set<Id>();
             
                if(!prcbooklist.isEmpty()){
                    for(Pricebook2 prcIter : prcbooklist){
                        prcbookMap.put(prcIter.name,prcIter.id);
                    }
                }
                System.debug('==prcmap'+prcbookMap);
                
                for(Opportunity OppIdsItr : Trigger.new){
                    accountIds.add(OppIdsItr.accountid);
                }
                for(Account AccItr : [SELECT id,ABB_Region__c FROM Account WHERE Id IN:accountIds]){
                    abbAccmap.put(AccItr.id,AccItr.ABB_Region__c);
                }
            
                for(Opportunity OppItr : Trigger.new){
                    if(prcbookMap.size() > 0){    
                    
                        if(abbAccmap.get(OppItr.accountId) == 'Aiken - D3'){
                            OppItr.Pricebook2Id = prcbookMap.get('Aiken Price Book - D3');
                        }
                        else if(abbAccmap.get(OppItr.accountId) == 'Aiken - D2'){
                            OppItr.Pricebook2Id = prcbookMap.get('Aiken Price Book - D2');
                       }
                       else if(abbAccmap.get(OppItr.accountId) == 'WPA-D2'){
                            OppItr.Pricebook2Id=prcbookMap.get('WPA Price Book - D2');
                        }
                        else if(abbAccmap.get(OppItr.accountId) == 'WPA-D3'){
                             System.debug(OppItr.Pricebook2Id+'==='+prcbookMap.get('WPA Price Book - D3'));
                             OppItr.Pricebook2Id=prcbookMap.get('WPA Price Book - D3');
                        }
                        else if(abbAccmap.get(OppItr.accountId) == 'DelMar North (DE)'){
                             OppItr.Pricebook2Id= prcbookMap.get('DelMar North (DE) Price Book');
                        }
                         else if(abbAccmap.get(OppItr.accountId) == 'DelMar South (MD)'){
                             OppItr.Pricebook2Id=prcbookMap.get('DelMar South (MD) Price Book');
                        }
                        else if(abbAccmap.get(OppItr.accountId) == 'Indian Creek'){
                             OppItr.Pricebook2Id=prcbookMap.get('Indian Creek Price Book');
                        }
                        else if(abbAccmap.get(OppItr.accountId) == 'Miami'){
                             OppItr.Pricebook2Id=prcbookMap.get('Miami Price Book');
    
                           }
                        else if(abbAccmap.get(OppItr.accountId) == 'CT'){
                             OppItr.Pricebook2Id=prcbookMap.get('CT Price Book');    
                           }
                      
                      }
                      System.debug('====assign'+OppItr.Pricebook2Id);
                }
            }

        }
    }
}
trigger BulkPricebookOpp on Opportunity (Before insert, Before update) {
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
            {
                 List<Pricebook2> prcbooklist = [select id,name from pricebook2];
                 Map<String,Id> prcbookMap = new Map<String,Id>();
                 Map<Id,String> abbAccmap = new Map<Id,String>();
                 List<RecordType> recordtypId =  [Select Id,Name From RecordType Where SobjectType = 'Opportunity'];
                 Map<Id,String> recMap = new Map<Id,String>();
                 Set<Opportunity> OppItrortunityUpdateIds = new Set<Opportunity>();
                 Set<Id> accountIds = new Set<Id>();
                 Set<Id> RectypIds = new Set<Id>();
                              
                if(!prcbooklist.isEmpty())
                {
                    for(Pricebook2 prcIter : prcbooklist)
                    {
                        prcbookMap.put(prcIter.name,prcIter.id);
                    }
                }
                System.debug('==prcmap'+prcbookMap);
                
                for(RecordType rectyp : recordtypId)
                {
                    recMap.put(rectyp.Id,rectyp.name);
                }
                
                for(Opportunity OppIdsItr : Trigger.new)
                {
                    accountIds.add(OppIdsItr.accountid);
                    
                }
                for(Account AccItr : [SELECT id,ABB_Region__c FROM Account WHERE Id IN:accountIds])
                {
                    abbAccmap.put(AccItr.id,AccItr.ABB_Region__c);
                }
            
                for(Opportunity OppItr : Trigger.new)
                {
                    if(prcbookMap.size() > 0)
                    { 
                         
                        if (recMap.get(OppItr.RecordTypeId) == 'k) Bulk Services')
                        {
                            OppItr.Pricebook2Id = prcbookMap.get('Bulk Price Book');
                        }
                        else if(Trigger.isUpdate)
                        {
                          if(OppItr.RecordTypeId!=Trigger.oldMap.get(OppItr.Id).RecordTypeId)
                            {
                            if(recMap.get(OppItr.RecordTypeId) == 'k) Bulk Services')
                            OppItr.Pricebook2Id = prcbookMap.get('Bulk Price Book');
                            else if(abbAccmap.get(OppItr.accountId) == 'Aiken - D3')
                            {
                             OppItr.Pricebook2Id = prcbookMap.get('Aiken Price Book - D3');
                            }
                            else if(abbAccmap.get(OppItr.accountId) == 'Aiken - D2')
                            {
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
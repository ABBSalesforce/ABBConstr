trigger ProcessSignedAgreement on echosign_dev1__SIGN_Agreement__c (After insert,After update) {
    
       
    Map<id,Opportunity> mapOpportunityUpdate1 = new Map<id,Opportunity>();
   
    System.debug('====sid'+Trigger.newMap.keySet());
    //Site Survey Agreement
    for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                         echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                                    FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE ID IN:Trigger.newMap.keySet() and Name LIKE 'Site Survey%' ORDER BY CreatedDate]){
             System.debug('===agree'+agree);
           if(agree.echosign_dev1__Status__c == 'Out for Signature'){  
               agree.echosign_dev1__Opportunity__r.Required_Site_Survey__c = 'Submitted';    
               mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r);
           }
           else if(agree.echosign_dev1__Status__c == 'Signed' || 
                   agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){ 
                       agree.echosign_dev1__Opportunity__r.Required_Site_Survey__c = 'Completed';
                       mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
           }
           System.debug('====map'+mapOpportunityUpdate1);
     }
     
     //LOA Agreement
      for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                         echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                                    FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE ID IN:Trigger.newMap.keySet() and Name LIKE 'LOA%' ORDER BY CreatedDate]){
            System.debug('===agree'+agree);
            if(agree.echosign_dev1__Status__c == 'Out for Signature'){ 
               agree.echosign_dev1__Opportunity__r.Required_LOA__c = 'Submitted';    
               mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r);
           }
          
           else if(agree.echosign_dev1__Status__c == 'Signed' || 
                   agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){ 
                       agree.echosign_dev1__Opportunity__r.Required_LOA__c = 'Completed';
                       mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
           }
           System.debug('====map'+mapOpportunityUpdate1);
     }
  
    if(Trigger.isUpdate){
         Set<Id> AgreementStatusUpdate = new Set<Id>();
         for(echosign_dev1__SIGN_Agreement__c agree : Trigger.new){
             if(agree.echosign_dev1__Status__c != Trigger.oldmap.get(agree.id).echosign_dev1__Status__c){
                 AgreementStatusUpdate.add(agree.id);
             }
         }
         //X-Connect
         for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                         echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                                    FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE ID IN: AgreementStatusUpdate and Name LIKE 'Cross-Connect%' ORDER BY CreatedDate]){
           if(agree.echosign_dev1__Status__c == 'Signed' || 
                   agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){
                       agree.echosign_dev1__Opportunity__r.Required_XConnect__c = 'Completed';
                       mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
            }
        } 
        
        //Multiple-DL
        for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                         echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                                    FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE ID IN: AgreementStatusUpdate and Name LIKE 'Multiple Directory%' ORDER BY CreatedDate]){
           if(agree.echosign_dev1__Status__c == 'Signed' || 
                   agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){ 
                       agree.echosign_dev1__Opportunity__r.Required_MDL__c = 'Completed';
                       mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
            }
        } 
        
        //Toll Free 
        for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                         echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                                    FROM echosign_dev1__SIGN_Agreement__c 
                                                   WHERE ID IN: AgreementStatusUpdate and Name LIKE 'Toll Free%' ORDER BY CreatedDate]){
           if(agree.echosign_dev1__Status__c == 'Signed' || 
                   agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){ 
                       agree.echosign_dev1__Opportunity__r.Required_TFN__c = 'Completed';
                       mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
            }
        }
        
        //Agreement 
        for(echosign_dev1__SIGN_Agreement__c agree : [SELECT id, Name, echosign_dev1__Status__c, echosign_dev1__Opportunity__r.id, 
                                                 echosign_dev1__Opportunity__r.Required_Site_Survey__c   
                                            FROM echosign_dev1__SIGN_Agreement__c 
                                           WHERE ID IN: AgreementStatusUpdate and Name LIKE 'Agreement for%' ORDER BY CreatedDate]){
            if(  agree.echosign_dev1__Status__c=='Waiting for Counter-Signature'){ 
                   agree.echosign_dev1__Opportunity__r.Required_Agreement__c = 'Counter Signature';
                   mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
            }
                                               
             else if(agree.echosign_dev1__Status__c == 'Signed' ){ 
               agree.echosign_dev1__Opportunity__r.Required_Agreement__c = 'Completed';
               mapOpportunityUpdate1.put(agree.echosign_dev1__Opportunity__r.id,agree.echosign_dev1__Opportunity__r); 
           }
                                               
        }  
             
    }
     
     //Update 
     if(!mapOpportunityUpdate1.isEmpty()){
         update mapOpportunityUpdate1.values();
     }
     
}
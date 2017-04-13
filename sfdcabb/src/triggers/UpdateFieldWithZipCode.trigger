trigger UpdateFieldWithZipCode on Account (Before insert, Before update, After Update) {
    
    if(trigger.isBefore){
        Set<String> setAccPosCode = new Set<String>();
        Map<String,Zip_Code__c> ZipCodefieldsMap = new Map<String,Zip_Code__c>();
        
        for(Account objAcc : trigger.new){
            if(trigger.isInsert) {
                IF(objAcc.BillingPostalCode!=null) {
                    Integer ZipLen = objAcc.BillingPostalCode.length();
                    String zipString = objAcc.BillingPostalCode;
                    if(ZipLen > 5) {
                        zipString = objAcc.BillingPostalCode.substring(0, 5);
                        System.debug('==Substring'+zipString);
                    }
                    
                    setAccPosCode.add(zipString);
                  
                    System.debug('====='+setAccPosCode);
                }
            }
            else if(objAcc.BillingPostalCode!=Trigger.oldMap.get(objAcc.id).BillingPostalCode && objAcc.BillingPostalCode!=null){
                Integer ZipLen = objAcc.BillingPostalCode.length();
                String zipString = objAcc.BillingPostalCode;
                if(ZipLen > 5) {
                    zipString = objAcc.BillingPostalCode.substring(0, 5);
                    System.debug('==Substring'+zipString);
                }
                
                setAccPosCode.add(zipString);
                System.debug('=='+setAccPosCode);
            }
        }
        
        if(!setAccPosCode.isEmpty()){
            for(Zip_Code__c itrZipCode : [SELECT Name,System__c, Service_Type__c, PriceBook_Name__c,
                                                City__c,State__c 
                                           FROM Zip_Code__c 
                                          WHERE Name IN : setAccPosCode]){
                ZipCodefieldsMap.put(itrZipCode.Name,itrZipCode);
            }
        }
        
       for(Account itrAcc : Trigger.new){ 
           if(itrAcc.BillingPostalCode==null) continue;
           String s = itrAcc.BillingPostalCode;
                Integer ZipLen = itrAcc.BillingPostalCode.length();
                if(ZipLen > 5) {
                    s = itrAcc.BillingPostalCode.substring(0, 5);
                }
            if(Trigger.isInsert){
                
                if(ZipCodefieldsMap.get(s) != null){
                    System.debug('insert====='+ZipCodefieldsMap);
                    
                    itrAcc.Zip_Code__c = ZipCodefieldsMap.get(s).id;
                    itrAcc.ABB_Region__c = ZipCodefieldsMap.get(s).PriceBOok_Name__c; 
                    itrAcc.System__c = ZipCodefieldsMap.get(s).System__c;
                    itrAcc.ServiceType__c = ZipCodefieldsMap.get(s).Service_Type__c ;
                    itrAcc.City__c = ZipCodefieldsMap.get(s).City__c;
                    itrAcc.State__c = ZipCodefieldsMap.get(s).State__c;
                }}
                else if(Trigger.isUpdate){
                    //if(itrAcc.BillingPostalCode!=Trigger.oldMap.get(itrAcc.id).BillingPostalCode){
                        if(ZipCodefieldsMap.get(s)!= null){
                            System.debug('update====='+ZipCodefieldsMap);
                            itrAcc.Zip_Code__c = ZipCodefieldsMap.get(s).id;
                            itrAcc.ABB_Region__c = ZipCodefieldsMap.get(s).PriceBOok_Name__c; 
                            itrAcc.System__c = ZipCodefieldsMap.get(s).System__c;
                            itrAcc.ServiceType__c = ZipCodefieldsMap.get(s).Service_Type__c ;
                            itrAcc.City__c = ZipCodefieldsMap.get(s).City__c;
                            itrAcc.State__c = ZipCodefieldsMap.get(s).State__c;
                        }
                    }   
                //}   
            
         }
    }
    else if(trigger.isAfter){
        if(trigger.isUpdate){
            Set<id> getpricebookid= new Set<id>();
            Set<ID> aID = new Set<ID>();
            Set<ID> aID1 = new Set<ID>();
            Set<ID> getname = new Set<ID>();
            List<Account> lacc = new List<Account>();
            List<Opportunity> name = new list <Opportunity>();
            List<Opportunity> lop = new List<Opportunity>();
            List<pricebook2> prclst = new List<pricebook2>();
            Map<string,id> getpricebookid1= new Map<string,id>();
            String pricebookidget;
            
            List<OpportunityLineItem> opplineitem = new List<OpportunityLineItem>();
            
                for(Account acc : trigger.new){
                    if(acc.BillingPostalCode!= trigger.oldMap.get(acc.id).BillingPostalCode){
                    aID.add(acc.id);
                    }
                 }
                 System.debug('==aid'+aid);
                 Map<id,Account> mAcc = new Map<id,Account>([SELECT id, ABB_Region__c FROM Account WHERE id IN: aID]);
                 system.debug('===amit==='+mAcc);
            
                 lop = [SELECT id,Pricebook2Id,accountId FROM Opportunity WHERE accountId IN :mAcc.keySet()];
                 system.debug('===amit1==='+lop);
                //changes
                 for(Opportunity opp5 :lop){
                     getpricebookid.add(opp5.id);            
                     system.debug('bubai'+ getpricebookid);
                 }   
                
                 opplineitem = [select id,opportunityid from  OpportunityLineItem where opportunityid=:getpricebookid];
                 system.debug('kalam'+ opplineitem);
                  
                if(opplineitem.size()>0 ){
                     system.debug('yeserror');
                     for(OpportunityLineItem opli : opplineitem){
                        getname.add(opli.opportunityid);
                      }
                      if(getname.size()>0){
                          name = [select name from Opportunity where id in : getname ];
                       }
                   Trigger.new[0].Adderror('Products are already assigned to OpportunityLineItem of this Account,You cannot Change Zip Code now! If you want to change the Zip Code,delete the Products added on OpportunityLineItems '+ name);
                }     
                else{
                        prclst=[select id,name from pricebook2];
                        System.debug('===pricebook list.size()'+prclst.size());
                        if(prclst.size()>0){
                            for(pricebook2 pcc:prclst ){
                                getpricebookid1.put(pcc.name,pcc.id)    ;
                            }
                            System.debug('===testpricebookid'+getpricebookid1);
                        }
                        if(getpricebookid1.size()>0){
                            system.debug('yesupdate');
                            for(Opportunity op1 : lop){
                            Account ac = mAcc.get(op1.AccountID);
                            system.debug('===amit2==='+ac);
                            system.debug('===amit2==='+ac.ABB_Region__c);
                            if(ac.ABB_Region__c == 'Aiken - D3'){
                                system.debug('===amit3==='+ac);
                                pricebookidget=getpricebookid1.get('Aiken Price Book - D3');
                                op1.Pricebook2Id =  pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c == 'Aiken - D2'){
                                pricebookidget=getpricebookid1.get('Aiken Price Book - D2');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c == 'WPA-D2'){
                                pricebookidget=getpricebookid1.get('WPA Price Book - D2');
                                op1.Pricebook2Id =  pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c == 'WPA-D3'){
                                pricebookidget=getpricebookid1.get('WPA Price Book - D3');
                                op1.Pricebook2Id =  pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c == 'DelMar North (DE)'){
                                pricebookidget=getpricebookid1.get('DelMar North (DE) Price Book');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c =='DelMar South (MD)'){  
                                pricebookidget=getpricebookid1.get('DelMar South (MD) Price Book');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                            }
                            else if(ac.ABB_Region__c == 'Indian Creek'){
                                pricebookidget=getpricebookid1.get('Indian Creek Price Book');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                             }
                            else if(ac.ABB_Region__c == 'Miami'){
                                pricebookidget=getpricebookid1.get('Miami Price Book');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                             }
                             else if(ac.ABB_Region__c == 'CT'){
                                pricebookidget=getpricebookid1.get('CT Price Book');
                                op1.Pricebook2Id = pricebookidget;
                                update op1;
                             }
                        }
                     
                    }  
                } 
            }
        }   
}
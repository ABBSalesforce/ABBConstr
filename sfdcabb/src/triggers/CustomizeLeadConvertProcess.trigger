trigger CustomizeLeadConvertProcess on Lead (After insert) {
  
    map<String,Id> convertedAccountmap = new map<String,Id>();
    map<Id,Account> updateAccmap = new map<Id,Account>();
    
    LisT<Account> accList = new List<Account>();
    for(Lead leadItr : Trigger.new){
        if (leadItr.ConvertedAccountId != null && leadItr.postalCode != NULL) {
            accList.add(new Account(ID=leadItr.ConvertedAccountId, ShippingPostalCode=leadItr.postalCode));
            //convertedAccountmap.put(leadItr.postalCode,leadItr.ConvertedAccountId);
        }
    }
    if(! accList.isEmpty()) {
        System.debug('====accList'+accList);
        Update accList;
    }
    
}
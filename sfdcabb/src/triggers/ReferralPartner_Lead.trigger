trigger ReferralPartner_Lead on Lead (before Insert,before update) {
    // build a set of the referrer names
    Set<String> referrerNames=new Set<String>();

    // iterate the records in the trigger
    for (Lead ld : trigger.new)
    {
        referrerNames.add(ld.Referral_Text__c);
    }
     System.debug('+++referaltext'+referrerNames);

    // query back all matching referrer records, and add these to a map keyed by name

    Map<String, Referral_Partner__c> refPtrsByName=new Map<String, Referral_Partner__c>();
    for (Referral_Partner__c refPtr : [select id, Name from Referral_Partner__c where name in :referrerNames])
    {
        refPtrsByName.put(refPtr.Name, refPtr);
    }
     System.debug('+++===referalName'+refPtrsByName);
    // now iterate the records and populate the referral partner lookup
    for (Lead ld : trigger.new)
    {
        Referral_Partner__c refPtr=refPtrsByName.get(ld.Referral_Text__c);
        if (null!=refPtr)
        {
            ld.Referral_Partner__c=refPtr.id;
        }
       System.debug('+++++++++referalPart'+ld.Referral_Partner__c);
    }

}
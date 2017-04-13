trigger ReferralPartner_Opp on Opportunity (before insert, before update) {
// build a set of the referrer names
    Set<String> referrerNames1=new Set<String>();

    // iterate the records in the trigger
    for (Opportunity refopp : trigger.new)
    {
        referrerNames1.add(refopp.Referral_Text__c);
    }

    // query back all matching referrer records, and add these to a map keyed by name

    Map<String, Referral_Partner__c> refPtrsByNames=new Map<String, Referral_Partner__c>();
    for (Referral_Partner__c refPtr1 : [select id, Name from Referral_Partner__c where name in :referrerNames1])
    {
        refPtrsByNames.put(refPtr1.Name, refPtr1);
    }

    // now iterate the records and populate the referral partner lookup
    for (Opportunity refopp : trigger.new)
    {
        Referral_Partner__c refPtr1=refPtrsByNames.get(refopp.Referral_Text__c);
        if (null!=refPtr1)
        {
            refopp.Referral_Partner__c=refPtr1.id;
        }
        
    }
}
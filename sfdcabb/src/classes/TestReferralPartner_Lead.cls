@isTest
public class TestReferralPartner_Lead {
    public static testMethod void LeadCoverageTest(){
        //Insert Referral_Partner__c records, add all manadary fields here 
       // Referral_Partner__c ref = new Referral_Partner__c(Name = 'Tester');
       // insert ref;

        List<Lead> lstLead = new List<Lead>();
        Lead lead = new Lead(FirstName='Test1',LastName='Tested', Company='Test1 Inc.', Phone = '12345',
                            Email='test6@duptest.com', Referral_Text__c = 'ABB1001');
        lstLead.add(lead);
        Lead lead1 = new Lead(FirstName='Test2',LastName='Tested1', Company='Test2 Inc.', Phone = '123456',
                            Email='test3@duptest.com', Referral_Text__c = 'ABB1002');
        lstLead.add(lead1);
        try{
            insert lstLead;
			
			delete lstLead;
        }
        catch(Exception e){}
     }
    

}
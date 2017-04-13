@isTest(seeAllData=true)
public class TestJobSchedule_TriggerTest {
	static testMethod void Test_JobSchedule_Processedby() 
   	{  
       //Job_Schedules__c jsch_new = new Job_Schedules__c(Name='Trigger Test',Opportunity__c='006e00000058qV0AAI', House__c='16602431200059', JobNumber__c='984358',Processor_CSG_ID__c='EHW');
       //Insert jsch_new;
		
       Job_Schedules__c jsch= [SELECT Id, House__c, JobNumber__c, Processor_CSG_ID__c, Processed_By__c FROM Job_Schedules__c where Id='a0o40000002WrWwAAK'];
       System.debug('Processor_CSG_ID__c value:'+jsch.Processor_CSG_ID__c); 
       jsch.Processor_CSG_ID__c ='ELY';
       update jsch;
        
        // get the value back and assert it
        Job_Schedules__c jsch_updated= [SELECT Id, House__c, JobNumber__c, Processor_CSG_ID__c, Processed_By__c FROM Job_Schedules__c where Id='a0o40000002WrWwAAK'];
        System.debug('Processor_CSG_ID__c updated value:'+ jsch_updated.Processor_CSG_ID__c);
        System.assertEquals('ELY', jsch_updated.Processor_CSG_ID__c);
   	} 
}
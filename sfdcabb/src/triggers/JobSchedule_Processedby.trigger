//Auto Populate Operator Name based on the ID from Lookup Table
trigger JobSchedule_Processedby on Job_Schedules__c(Before Update) {
    Set < String > JobProcessNames = new Set < String > ();
    Map < String, Commercial_Processor__c > accMap = new Map < String, Commercial_Processor__c > ();
    //hold all the CSG_OPid__c in a set 
    for (Job_Schedules__c o: trigger.new) {
        if (o.processor_csg_id__c != NULL) {
            JobProcessNames.add(o.processor_csg_id__c);
        }
    }
    System.debug(JobProcessNames);
    //query all the related ID and create a map
    for (Commercial_Processor__c acc: [SELECT ID,CSG_OPid__c  FROM Commercial_Processor__c WHERE CSG_OPid__c  IN: JobProcessNames]) {
        accMap.put(acc.CSG_OPid__c, acc);
        System.debug(acc.CSG_OPid__c);
    }
    //relate Processed_by__C
    for (Job_Schedules__c o: trigger.new) {
        Commercial_Processor__c acc = accMap.get(o.processor_csg_id__c);
        if (acc != NULL && acc.CSG_OPid__c != NULL) {
            System.debug(acc.ID);
            o.Processed_By__c = acc.ID;
            System.debug(o.Processed_By__c);
        }
    }
}
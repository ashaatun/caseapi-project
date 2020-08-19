trigger CaseTrigger on Case (before insert,before update,after insert, after update) {
    //we can create a hierarchical custom setting to disable this trigger for bulk execution.
    CaseTriggerHandler handler = new CaseTriggerHandler();
    handler.run();
}
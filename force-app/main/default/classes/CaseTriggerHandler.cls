public class CaseTriggerHandler {
	public void run() {
            if(trigger.isAfter && trigger.isInsert) {
            }
            if(trigger.isAfter && trigger.isUpdate) {
                 afterUpdateHandler((List<Case>)trigger.new, (Map<Id,case>)trigger.oldMap);
            }

            if(trigger.isBefore && trigger.isInsert) {
            }
            if(trigger.isBefore && trigger.isUpdate) {
            }
    }
     private void afterUpdateHandler(List<case> caseList, Map<Id,case> oldCaseMap) {
        try{
			map<Id,User> caseAgentMap = new map<Id,User>();
			for(Case caseObj: caseList){
   			if(caseObj.Status != oldCaseMap.get(caseObj.id).Status && caseObj.Status == 'Closed' ){
       		caseAgentMap.put(caseObj.id,caseObj.lastModifiedBy);
   			}
			}
            //Queueable to ensure correct agentid is passed at the time of case closure
    		System.enqueueJob(new SendClosedCasesQueueable(caseAgentMap));
           
        }
        catch(Exception ex){
            system.debug('ex '+ ex.getMessage()+' '+ex.getLineNumber());
        }
    }
    
}
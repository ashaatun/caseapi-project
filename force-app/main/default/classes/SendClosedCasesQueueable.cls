public class SendClosedCasesQueueable implements Queueable, Database.AllowsCallouts {
    map<id, user> agentMap;
    public SendClosedCasesQueueable( map<id, user> agentMap)
    {
        this.agentMap = agentMap;
    }
    public void execute(QueueableContext context){
         notifyCurrentUser(agentMap);
    }
    public static void notifyCurrentUser(map<id, user> aMap)
    {
        try{
            List<Case> updateList = new List<Case>();
            for(Id caseId : aMap.keyset()){ 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://nfapihub.herokuapp.com');
                req.setMethod('POST');
                req.setHeader('Content-Type','application/json');
               	String sJSON = '{"id":"'+caseId+'","agentid":"'+aMap.get(caseId)+'"}';
				req.setBody(sJSON);
                HttpResponse res = h.send(req);
               	if (res.getStatusCode() == 200) {
                    System.debug('resp body>'+res.getBody());
                	caseResponse myResponse = (caseResponse) JSON.deserialize(res.getBody(), caseResponse.class);
                    String key = (String) myResponse.secretKey;
                    System.debug('resp key>'+key);
                    case c = new case(id=caseId);
                    c.Secret_Key__c = key;
                    updateList.add(c);
        		}
            	
            }
            if(!updateList.isEmpty()){
                update updateList;
            }
          	
            
        }catch(Exception ex) {
           system.debug('ex '+ ex.getMessage()+' '+ex.getLineNumber());
        }
        
    }
     public class caseResponse {
        public string succ ;
        public string secretKey ;
    } 
   

}
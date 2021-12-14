trigger trigAutoRequest on inventory__c (before update) {
trigAutoRequestHandler triggerHandler =  new trigAutoRequestHandler ();
triggerHandler.raiseAutoRequest();

}
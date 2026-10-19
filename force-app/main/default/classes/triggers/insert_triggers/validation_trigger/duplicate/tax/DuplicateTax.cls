public with sharing class DuplicateTax implements TriggerAction.BeforeInsert{
    public DuplicateTax() {}
    
    public void beforeInsert(List<Tax__c> triggerNew){
        Set<Id> productId = new Set<Id>();
        Set<Id> stateId = new Set<Id>();
        
        for(Tax__c i : triggerNew) productId.add(i.Product__c);
        for(Tax__c i : triggerNew) stateId.add(i.State__c);
        
        List<Tax__c> taxes = [SELECT Product__c, State__c FROM Tax__c 
                                                          WHERE Product__c IN :productId 
                                                          AND State__c IN :stateId];
        
        if(!taxes.isEmpty()){
            for(Tax__c i : triggerNew){
                for(Tax__c j : taxes){
                    
                    if(i.Product__c == j.Product__c && i.State__c == j.State__c){
                        i.addError('Registro Duplicado!');
                    }
                }
            }
        }
    }
}
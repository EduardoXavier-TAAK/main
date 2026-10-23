public with sharing class DuplicateTax implements TriggerAction.BeforeInsert{
    public DuplicateTax() {}
    
    public void beforeInsert(List<Tax__c> triggerNew){
        Map<String, Tax__c> keys = new Map<String, Tax__c>();
        Set<Id> productId = new Set<Id>();
        Set<Id> stateId = new Set<Id>();
        
        for(Tax__c i : triggerNew) {
            productId.add(i.Product__c);
            stateId.add(i.State__c);
        }
        
        List<Tax__c> taxes =
            [SELECT 
            Product__c, 
            State__c,
             Distribution_Center__c, 
             Value__c
        FROM Tax__c];
        
        for(Tax__c i : taxes){
            String key = i.Product__c + '_' + i.State__c + i.Distribution_Center__c + i.Value__c;
            
            if(!keys.containsKey(key)) keys.put(key, i);
        }
        
        for(Tax__c i : triggerNew){
            
            String key = i.Product__c + '_' + i.State__c + i.Distribution_Center__c + i.Value__c;
            
            if(keys.containsKey(key)) {
                i.addError('Imposto Duplicado!');
                break;
            }
        }
        
    }
}
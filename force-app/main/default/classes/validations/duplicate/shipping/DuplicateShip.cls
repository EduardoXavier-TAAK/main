public with sharing class DuplicateShip implements TriggerAction.BeforeInsert {
    public DuplicateShip() {
    }
    
    public void beforeInsert(List<Shipping_Fee__c> triggerNew) {
        Set<Id> cityId = new Set<Id>();
        Set<Id> stateId = new Set<Id>();
        Set<Id> countryId = new Set<Id>();
        
        Set<Id> productId = new Set<Id>();
        Set<Id> hierarchyId = new Set<Id>();
        
        Set<Id> distributionId = new Set<Id>();
        Set<Decimal> value = new Set<Decimal>();
        
        Map<String, Shipping_Fee__c> sMap = new Map<String, Shipping_Fee__c>();
        
        for (Shipping_Fee__c i : triggerNew) {
            cityId.add(i.City__c);
            stateId.add(i.State__c);
            countryId.add(i.Country__c);
            productId.add(i.Product__c);
            hierarchyId.add(i.Product_Hierarchy__c);
            distributionId.add(i.Distribution_Center__c);
            value.add(i.Value__c);
        }
        
        List<Shipping_Fee__c> allFees = [
      SELECT
        City__c,
        State__c,
        Country__c,
        Product__c,
        Product_Hierarchy__c,
        Distribution_Center__c,
        Value__c
      FROM Shipping_Fee__c
      WHERE (City__c IN :cityId OR State__c IN :stateId OR Country__c IN :cityId)
      AND (Product__c IN :productId OR Product_Hierarchy__c IN :hierarchyId)
      AND (Value__c IN :value AND Distribution_Center__c IN :distributionId)
    ];
        
        for (Shipping_Fee__c i : allFees) {
            String key = i.City__c + 
            '_' + i.State__c + 
            '_' + i.Country__c + 
            '_' + i.Product__c + 
            '_' + i.Product_Hierarchy__c + 
            '_' + i.Distribution_Center__c + 
            '_' + i.Value__c;
            
            if (!sMap.containsKey(key)) sMap.put(key, i);
        }
        
        for(Shipping_Fee__c i : triggerNew){
            String key = i.City__c + 
            '_' + i.State__c + 
            '_' + i.Country__c + 
            '_' + i.Product__c + 
            '_' + i.Product_Hierarchy__c + 
            '_' + i.Distribution_Center__c + 
            '_' + i.Value__c;
            
            if(sMap.containsKey(key)) {
                i.addError('Frete Duplicado!');
                continue;
            }
        }
        
    }
}
public with sharing class DuplicateMargin implements TriggerAction.BeforeInsert {
    public DuplicateMargin() {}
    
    public void beforeInsert(List<Margin__c> triggerNew){
        Set<Id> cityId = new Set<Id>();
        Set<Id> stateId = new Set<Id>();
        Set<Id> countryId = new Set<Id>();
        
        Set<Id> productId = new Set<Id>();
        Set<Id> hierarchyId = new Set<Id>();
        
        Set<Id> customerId = new Set<Id>();
        Set<Id> clientGroupId = new Set<Id>();
        
        Set<Id> distributionId = new Set<Id>();
        Set<Decimal> value = new Set<Decimal>();
        
        Map<String, Margin__c> mMap = new Map<String, Margin__c>();
        
        for(Margin__c i : triggerNew){
            cityId.add(i.City__c);
            stateId.add(i.State__c);
            countryId.add(i.Country__c);
            
            productId.add(i.Product__c);
            hierarchyId.add(i.Product_Hierarchy__c);
            
            customerId.add(i.Account__c);
            clientGroupId.add(i.Account_Group__c);
            
            distributionId.add(i.Distribution_Center__c);
            value.add(i.Value__c);
        
        }
        
        List<Margin__c > allMargins = [
            SELECT City__c, 
                   State__c, 
                   Country__c, 
                   Product__c,
                   Account__c,
                   Account_Group__c,
                   Product_Hierarchy__c,
                   Distribution_Center__c,
                   Value__c
            FROM Margin__c 
            WHERE (City__c IN :cityId OR State__c IN :stateId OR Country__c IN: countryId)
            AND (Product__c IN :productId OR Product_Hierarchy__c IN :hierarchyId)
            AND (Account__c IN :customerId OR Account_Group__c IN :clientGroupId)
            AND (Value__c IN :value AND Distribution_Center__c IN :distributionId)];
        
        for(Margin__c  i : allMargins){
            String key = i.City__c  + 
            '_' + i.State__c +
            '_' +i.Country__c +
            '_' +i.Product__c +
            '_' +i.Product_Hierarchy__c +
            '_' +i.Account__c +
            '_' +i.Account_Group__c +
            '_' +i.Distribution_Center__c +
            '_' +i.Value__c;
            
            if(!mMap.containsKey(key)) mMap.put(key, i);           
        }

        for(Margin__c i : triggerNew){
            String key = i.City__c  + 
            '_' + i.State__c +
            '_' +i.Country__c +
            '_' +i.Product__c +
            '_' +i.Product_Hierarchy__c +
            '_' +i.Account__c +
            '_' +i.Account_Group__c +
            '_' +i.Distribution_Center__c +
            '_' +i.Value__c;

            if(mMap.containsKey(key)){
                i.addError('Margem Duplicada!');
                continue;
            }
        }
    }
}
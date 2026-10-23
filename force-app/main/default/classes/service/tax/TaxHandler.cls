public with sharing class TaxHandler {
    public TaxHandler() {}
    
    public void selectTax(List<OrderItem> produto){
        Set<Id> productId = new Set<Id>();
        Set<Id> orderId = new Set<Id>();

        Map<String, Tax__c> keys = new Map<String, Tax__c>();
        
        for(OrderItem i : produto) productId.add(i.Product2Id);
        
        for(OrderItem i : produto) orderId.add(i.OrderId);
        
        List<Tax__c> taxes = [
        SELECT Value__c, 
                State__c, 
                Name,
                Product__c,
                CreatedDate__c
        FROM Tax__c 
        WHERE Product__c IN :productId];

        for(Tax__c i : taxes) {
            String key = i.State__c + '_' + i.Product__c;

            if(keys.containsKey(key)){
                Tax__c temp = keys.get(key);

                if(i.CreatedDate > temp.CreatedDate) keys.put(key, i);

            } else { keys.put(key, i); }
        }


        Map<Id, Order> orderMap = new Map<Id, Order>([SELECT Id, Account_Address__r.City__r.State__c FROM Order 
                                                                                                     WHERE Id IN :orderId]);
        
        for(OrderItem i : produto){
            Id state = orderMap.get(i.orderId).Account_Address__r.City__r.State__c;
            Id product = i.Product2Id;
            
            String key = state + '_' + product;

            if(keys.containsKey(key)){
                Tax__c tax = keys.get(key);

                i.Tax_Percentage__c = tax.Value__c;

                i.Tax_Name__c = tax.Name;
            }
            
        }
        
    }
}
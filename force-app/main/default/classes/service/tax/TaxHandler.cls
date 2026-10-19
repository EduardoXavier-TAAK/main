public with sharing class TaxHandler {
    public TaxHandler() {}
    
    public void selectTax(List<OrderItem> produto){
        Set<Id> productId = new Set<Id>();
        Set<Id> orderId = new Set<Id>();
        
        for(OrderItem i : produto) productId.add(i.Product2Id);
        
        for(OrderItem i : produto) orderId.add(i.OrderId);
        
        List<Tax__c> tax = [SELECT Value__c, State__c, Name FROM Tax__c 
                                                      WHERE Product__c IN :productId];
        
        Map<Id, Order> orderMap = new Map<Id, Order>([SELECT Id, Account_Address__r.City__r.State__c FROM Order WHERE Id IN :orderId]);
        
        for(OrderItem i : produto){
            for(Tax__c t : tax){
                if(t.State__c == orderMap.get(i.OrderId).Account_Address__r.City__r.State__c){
                    i.Tax_Percentage__c = t.Value__c;

                    i.Tax_Name__c = t.Name;
                    break;
                }
            }
        }
        
        
    }
}
public with sharing class MarginHandler {
    SelectMarginHelper selectMarginHelper = new SelectMarginHelper();
    
    public MarginHandler() {}
    
    public void selectMargin(List<OrderItem> triggerNew){
        
        Set<Id> productsId = new Set<Id>();
        Set<Id> hierarchysId = new Set<Id>();
        Set<Id> orderIds = new Set<Id>();
        
        Set<Id> clientsId = new Set<Id>();
        Set<Id> groupIds = new Set<Id>();
        
        Set<Id> cityIds = new Set<Id>();
        Set<Id> stateIds = new Set<Id>();
        Set<Id> countryIds = new Set<Id>();
        
        for(OrderItem i : triggerNew) {
            productsId.add(i.Product2Id);
            orderIds.add(i.OrderId);
        }
        
        Map<Id, Product2> products = new Map<Id, Product2>([
        SELECT Id, Product_Hierarchy__c FROM Product2 WHERE Id IN :productsId
    ]);
        
        for(Product2 p : products.values()) hierarchysId.add(p.Product_Hierarchy__c);
        
        Map<Id, Order> orderMap = new Map<Id, Order>([
        SELECT Id,
              Customer__c,
              Customer__r.Client_Group__c,
              Account_Address__r.City__c,
              Account_Address__r.City__r.State__c,
              Account_Address__r.City__r.State__r.Country__c
        FROM Order
        WHERE Id IN :orderIds
    ]);
        
        for(Order i : orderMap.values()){
            clientsId.add(i.Customer__c);
            groupIds.add(i.Customer__r.Client_Group__c);
            cityIds.add(i.Account_Address__r.City__c);
            stateIds.add(i.Account_Address__r.City__r.State__c);
            countryIds.add(i.Account_Address__r.City__r.State__r.Country__c);
        }
        
        List<Margin__c> productMargin = [
        SELECT Id,
                Account__c,
                Account_Group__c,
                City__c, 
                State__c, 
                Country__c, 
                Value__c, 
                Product__c, 
                Product_Hierarchy__c,
                Name 
        FROM Margin__c
        WHERE (Product__c IN :productsId  OR Product_Hierarchy__c IN :hierarchysId)
        AND (Account__c IN :clientsId OR Account_Group__c IN :groupIds)
        ];
        
        
        for(OrderItem i : triggerNew) { selectMarginHelper.selectMargin(i, orderMap, productMargin); }
    }
}
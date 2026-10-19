public with sharing class ShippingHandler {
  ShipSelectLocation shipSelectLocation = new ShipSelectLocation();
  
  public ShippingHandler() {}
  
  public void insertFee(List<OrderItem> triggerNew) {
    
    Set<Id> productsId = new Set<Id>();
    Set<Id> hierarchysId = new Set<Id>();
    Set<Id> orderIds = new Set<Id>();
    
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
              Account_Address__r.City__c,
              Account_Address__r.City__r.State__c,
              Account_Address__r.City__r.State__r.Country__c
        FROM Order
        WHERE Id IN :orderIds
    ]);
    
    List<Shipping_Fee__c> productFee = [
      SELECT Id, 
            City__c, 
            State__c, 
            Country__c, 
            Value__c, 
            Product__c, 
            Product_Hierarchy__c,
            Name
      FROM Shipping_Fee__c
      WHERE Product__c IN :productsId
      OR Product_Hierarchy__c IN :hierarchysId
      ];
    
    for(OrderItem i : triggerNew) {  shipSelectLocation.selectFeeByLocation(i, orderMap, productFee); }
        
  }
  
}
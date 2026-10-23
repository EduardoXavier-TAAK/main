public with sharing class ShippingHandler {
  private final ShipSelectLocation shipSelectLocation = new ShipSelectLocation();
  
  public ShippingHandler() {
  }
  
  public void insertFee(List<OrderItem> triggerNew) {
    Set<Id> productsId = new Set<Id>();
    Set<Id> hierarchysId = new Set<Id>();
    Set<Id> cityId = new Set<Id>();
    Set<Id> stateId = new Set<Id>();
    Set<Id> countryId = new Set<Id>();
    Set<Id> orderIds = new Set<Id>();
    
    for (OrderItem i : triggerNew) {
      productsId.add(i.Product2Id);
      orderIds.add(i.OrderId);
    }
    
    Map<Id, Product2> products = new Map<Id, Product2>(
      [SELECT Id, Product_Hierarchy__c FROM Product2 WHERE Id IN :productsId]
      );
    
    for (Product2 p : products.values()) hierarchysId.add(p.Product_Hierarchy__c);
    
    Map<Id, Order> orderMap = new Map<Id, Order>([
        SELECT
          Id,
          Account_Address__r.City__c,
          Account_Address__r.City__r.State__c,
          Account_Address__r.City__r.State__r.Country__c
        FROM Order
        WHERE Id IN :orderIds
      ]
      );
    
    for (Order orderRecord : orderMap.values()) {
      Account_Address__c address = orderRecord.Account_Address__r;
      cityId.add(address.City__c);
      stateId.add(address.City__r.State__c);
      countryId.add(address.City__r.State__r.Country__c);
      
    }
    
    List<Shipping_Fee__c> productFee = [
      SELECT
        Id,
        City__c,
        State__c,
        Country__c,
        Value__c,
        Product__c,
        Product_Hierarchy__c,
        Name,
        CreatedDate
      FROM Shipping_Fee__c
      WHERE (Product__c IN :productsId OR Product_Hierarchy__c IN :hierarchysId)
      AND (City__c IN :cityId OR State__c IN :stateId OR Country__c IN :countryId)
    ];
    
    for (OrderItem i : triggerNew) {
      shipSelectLocation.selectFeeByLocation(i, orderMap, products, productFee);
    }
  }
}
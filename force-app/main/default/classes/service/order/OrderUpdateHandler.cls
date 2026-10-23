public with sharing class OrderUpdateHandler {
    public OrderUpdateHandler() {}
  
    public List<OrderItem> updateOrder(List<Order> triggerNew, List<Order> triggerOld){
        Map<Id, Order> oldOrdersById = new Map<Id, Order>(triggerOld);
        Set<Id> changedOrderIds = new Set<Id>();
        
        for (Order order : triggerNew) {
            Order oldOrder = oldOrdersById.get(order.Id);
            
            if(OldOrder.Customer__c != order.Customer__c) {
                order.addError('Não é possível alterar a conta após a criação do pedido!');
                continue;
            }

            if (oldOrder.Account_Address__c != order.Account_Address__c) {
                changedOrderIds.add(order.Id);
            } 
        }
        
        if (changedOrderIds.isEmpty()) return new List<OrderItem>();

        return [
            SELECT
                Id,
                OrderId,
                Product2Id,
                Product2.Product_Hierarchy__c,
                Quantity,
                ListPrice,
                UnitPrice,
                TotalPrice,
                Shipping_Cost__c,
                Tax_Percentage__c,
                Margin_Percentage__c,
                Fee_Name__c,
                Tax_Name__c,
                Margin_Name__c
            FROM OrderItem
            WHERE OrderId IN :changedOrderIds
        ];
        
    }
}
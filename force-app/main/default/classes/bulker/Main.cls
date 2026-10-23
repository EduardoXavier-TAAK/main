public with sharing class Main {
    ShippingHandler shippingHandler = new ShippingHandler();
    TaxHandler taxHandler = new TaxHandler();
    MarginHandler marginHandler = new MarginHandler();
    OrderUpdateHandler orderUpdate = new OrderUpdateHandler();
    OrderItemValidation orderItemValidation = new OrderItemValidation();
    
    public Main() { }
    
    public void insertFees(List<OrderItem> triggerNew){
        shippingHandler.insertFee(triggerNew);
        
        taxHandler.selectTax(triggerNew);
        
        marginHandler.selectMargin(triggerNew);
        
        for(OrderItem i : triggerNew) {
            if(!orderItemValidation.validateOrderItem(i)) continue;
            
            i.UnitPrice = (i.ListPrice + i.Shipping_Cost__c)
                                       * (1 + i.Tax_Percentage__c / 100)
                                       * (1 + i.Margin_Percentage__c / 100);
            
            i.Discount__c = (i.TotalPrice - i.UnitPrice) / i.TotalPrice;
            
        }
    }
    
    
    public void updateOrder(List<Order> triggerNew, List<Order> triggerOld){
        List<OrderItem> orderItems = orderUpdate.updateOrder(triggerNew, triggerOld);
        
        if(orderItems.isEmpty()) return;
        
        insertFees(orderItems);
        
        List<OrderItem> newOrderItems = new List<OrderItem>();
        
        for (OrderItem orderItem : orderItems) {
            newOrderItems.add(
                new OrderItem(
                    Id = orderItem.Id,
                    Shipping_Cost__c = orderItem.Shipping_Cost__c,
                    Tax_Percentage__c = orderItem.Tax_Percentage__c,
                    Margin_Percentage__c = orderItem.Margin_Percentage__c,
                    Fee_Name__c = orderItem.Fee_Name__c,
                    Tax_Name__c = orderItem.Tax_Name__c,
                    Margin_Name__c = orderItem.Margin_Name__c,
                    UnitPrice = orderItem.UnitPrice,
                    Discount__c = orderItem.Discount__c
                )
                );
        }
        try {
            OrderItemUpdateHandler.bypassCustomizations = true;
            update newOrderItems;
        } finally {
            OrderItemUpdateHandler.bypassCustomizations = false;
        }
    }
    
    
}
public class InsertOrderPrice implements TriggerAction.BeforeInsert {
    
    ShippingHandler shippingHandler = new ShippingHandler();
    TaxHandler taxHandler = new TaxHandler();
    MarginHandler marginHandler = new MarginHandler();
    OrderItemValidation orderItemValidation = new OrderItemValidation();
    
    public void beforeInsert(List<OrderItem> triggerNew){
        shippingHandler.insertFee(triggerNew);
        
        taxHandler.selectTax(triggerNew);
        
        marginHandler.selectMargin(triggerNew);
        
        for(OrderItem i : triggerNew) {              
            if(!orderItemValidation.validateOrderItem(i)) continue;

            i.UnitPrice = (i.ListPrice + i.Shipping_Cost__c)
                         * (1 + i.Tax_Percentage__c)
                         * (1 + i.Margin_Percentage__c);
                         
            i.Discount__c = (i.TotalPrice - i.UnitPrice) / i.TotalPrice;
            
        }
    }
    
}
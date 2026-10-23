public with sharing class OrderItemUpdateHandler {
    public static Boolean bypassCustomizations = false;

    public OrderItemUpdateHandler() {}
    
    public void updateOrderItem( List<OrderItem> triggerNew, List<OrderItem> triggerOld) {
       if (bypassCustomizations) return;
       
        Map<Id, OrderItem> oldItems = new Map<Id, OrderItem>(triggerOld);
        
        for (OrderItem item : triggerNew) {
            OrderItem oldItem = oldItems.get(item.Id);

            if(item.Order.Account_Address__c == oldItem.Order.Account_Address__c){
                Decimal basePrice;
                              
                Boolean shippingChanged = oldItem.Shipping_Cost__c != item.Shipping_Cost__c;
                Boolean taxChanged = oldItem.Tax_Percentage__c != item.Tax_Percentage__c;
                Boolean marginChanged = oldItem.Margin_Percentage__c != item.Margin_Percentage__c;
                
                if(!shippingChanged && !taxChanged && !marginChanged ) continue;
                
                if(shippingChanged) item.Fee_Name__c = 'Frete Personalizado';
                
                if(taxChanged) item.Tax_Name__c = 'Imposto Personalizado';
                   
                if(marginChanged) item.Margin_Name__c = 'Margem Personalizada';

                item.UnitPrice = (item.ListPrice + item.Shipping_Cost__c)
                                                 * (1 + item.Tax_Percentage__c / 100)
                                                 * (1 + item.Margin_Percentage__c / 100);    
    
                item.Discount__c = (item.TotalPrice - item.UnitPrice) / item.TotalPrice;
            }
            
        }
    }
}
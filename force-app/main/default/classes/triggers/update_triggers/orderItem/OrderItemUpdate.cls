public with sharing class OrderItemUpdate implements TriggerAction.BeforeUpdate {
    private final OrderItemUpdateHandler service = new OrderItemUpdateHandler();
    
    public OrderItemUpdate() { }

    public void beforeUpdate(List<OrderItem> triggerNew, List<OrderItem> triggerOld){  service.updateOrderItem(triggerNew, triggerOld);  }
}
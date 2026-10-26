public with sharing class OrderItemUpdate implements TriggerAction.BeforeUpdate {
    private final Main main = new Main();
    
    public OrderItemUpdate() { }

    public void beforeUpdate(List<OrderItem> triggerNew, List<OrderItem> triggerOld){ main.updateOrderItem(triggerNew, triggerOld);  }
}
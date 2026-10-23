public with sharing class OrderUpdateTrigger implements TriggerAction.AfterUpdate {
  private final Main main = new Main();

  public OrderUpdateTrigger() {
  }

  public void afterUpdate(List<Order> triggerNew, List<Order> triggerOld) { main.updateOrder(triggerNew, triggerOld); }
}

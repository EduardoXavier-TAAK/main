public class InsertOrderPrice implements TriggerAction.BeforeInsert {
    Main main = new Main();

    public void beforeInsert(List<OrderItem> triggerNew){ main.insertFees(triggerNew); }
    
}
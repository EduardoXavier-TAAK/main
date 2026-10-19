@isTest
private class ShippingFeeTest {

    public static void selectFeeTest() {
        OrderItem orderItem = new OrderItem(
            
        );

        List<OrderItem> orderItems = [SELECT Id, Product2Id, OrderId, Shipping_Cost__c FROM OrderItem];

        

    }
}
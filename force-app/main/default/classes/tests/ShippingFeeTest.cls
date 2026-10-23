@isTest
private class ShippingFeeTest {

    @isTest
    public static void selectFeeTest() {
        System.Savepoint sp = Database.setSavepoint();
        try{
            List<OrderItem> items = new List<OrderItem>();

            Product2 pId = [SELECT Id FROM Product2 WHERE Name = 'Feijão 1Kg'].get(0);
            Order oId = [SELECT Id FROM Order WHERE OrderNumber = '00000109'].get(0);

            OrderItem ord = new OrderItem(
                Product2Id = pId.Id,
                Quantity = 1,
                OrderId = oId.Id);

            for(Integer i = 0; i < 1001; i++)items.add(ord); 
            System.debug(items.size());

            insert items;

            List<OrderItem> ordersItems = [SELECT Id FROM OrderItem WHERE Product2Id = :pId.Id AND OrderId = :oId.Id];

            Assert.areEqual(ordersItems.size() >= 200, true);
            Assert.areEqual(ordersItems.get(0).Fee_Name__c, 'São Caetano do Sul - Plantação');
            Assert.areEqual(ordersItems.get(0).Tax_Name__c, 'SP - Feijão 1Kg');
            Assert.areEqual(ordersItems.get(0).Margin_Name__c, 'SP - TAAK SP, Plantação');
            Assert.areEqual(ordersItems.get(20).TotalPrice, 9.31);

        } catch(Exception e){
            System.debug(e.getMessage());

        } finally {
            Database.rollback(sp);
        }        

    }

    
}
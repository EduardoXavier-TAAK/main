trigger ShippingTrigger on Shipping_Fee__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new MetadataTriggerHandler().run();
}
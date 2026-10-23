public with sharing class ShippingValidationTrigger implements TriggerAction.BeforeInsert {
    public ShippingValidationTrigger() {}

    public void beforeInsert(List<Shipping_Fee__c> triggerNew){
        for(Shipping_Fee__c i : triggerNew){
            Boolean location = i.City__c == null && i.State__c == null && i.Country__c == null;
            Boolean product = i.Product__c == null && i.Product_Hierarchy__c == null;

            if(location) i.AddError('Campo: Cidade, Estado ou País precisam estar preenchidos!');

            if(product) i.AddError('Campo: Produto ou Hierarquia de Produtos precisam estar preenchidos!');
        } 
    }
}
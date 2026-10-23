public with sharing class marginValidationTrigger implements TriggerAction.BeforeInsert {
    public marginValidationTrigger() {}

    public void beforeInsert(List<Margin__c> triggerNew){
        for(Margin__c i : triggerNew){
            Boolean location = i.City__c == null && i.State__c == null && i.Country__c == null;
            Boolean client = i.Account__c == null && i.Account_Group__c == null;
            Boolean product = i.Product__c == null && i.Product_Hierarchy__c == null;

            if(location) i.AddError('Campo: Cidade, Estado ou País precisam estar preenchidos!');

            if(client) i.AddError('Campo: Cliente ou Grupo de Clientes precisam estar preenchidos!');

            if(product) i.AddError('Campo: Produto ou Hierarquia de Produtos precisam estar preenchidos!');
            
        }
    }
}
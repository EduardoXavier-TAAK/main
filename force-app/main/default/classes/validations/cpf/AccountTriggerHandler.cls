public with sharing class AccountTriggerHandler implements TriggerAction.BeforeInsert {
    public AccountTriggerHandler() { }
    
    public void beforeInsert(List<Account> triggerNew) {
        for (Account i : triggerNew) {
            String cnpj = i.CNPJ__c;
            
            if (String.isBlank(cnpj)) { 
                i.addError('CNPJ inválido!');
                continue;
            }
            
            String cnpjNumbers = cnpj.replaceAll('[^0-9]', '');
            
            if (cnpjNumbers.length() != 14) {
                i.addError('CNPJ inválido! Informe exatamente 14 dígitos (Apenas números).');
                continue;
            }
            
            i.CNPJ__c = cnpjNumbers.replaceAll('^(\\d{2})(\\d{3})(\\d{3})(\\d{4})(\\d{2})$', '$1.$2.$3/$4-$5');
        }
    }
}
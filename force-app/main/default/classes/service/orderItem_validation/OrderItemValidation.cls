public with sharing class OrderItemValidation {
    public OrderItemValidation() {}   

    public boolean validateOrderItem(OrderItem i) {
        boolean isValid = true;
        
        if(i.Shipping_Cost__c == null) {
            i.addError('Não está autorizada a venda deste produto devido à falta de parâmetros (Frete). Contate o time de Pricing.');
            isValid = false;        
        }     
        
        if(i.Margin_Percentage__c == null) {
            i.addError('Não está autorizada a venda deste produto devido à falta de parâmetros (Margem). Contate o time de Pricing.');
            isValid = false;
        }
        
        if(i.Tax_Percentage__c == null) {
            i.addError('Não está autorizada a venda deste produto devido à falta de parâmetros (Imposto). Contate o time de Pricing.');
            isValid = false;
        }
        
        if(i.Quantity == null || i.Quantity <= 0) {
            i.addError('A quantidade do produto deve ser maior que zero.');
            isValid = false;
        }
        
        if(i.ListPrice == null || i.ListPrice <= 0) {
            i.addError('O preço do produto deve ser maior que zero.');
            isValid = false;
        }
        
        return isValid;
    }   
}
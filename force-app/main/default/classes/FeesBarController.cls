public with sharing class FeesBarController {
    public FeesBarController() {}
    
    @AuraEnabled(cacheable=true)
    public static List<Shipping_Fee__c> getShipping(Id orderItemId){
        OrderItem i = [
            SELECT Product2Id,
                   Product2.Product_Hierarchy__c,
                   Order.Account_Address__r.City__c,
                   Order.Account_Address__r.City__r.State__c,
                   Order.Account_Address__r.City__r.State__r.Country__c
            FROM OrderItem
            WHERE Id = :orderItemId
            LIMIT 1
        ];

        Id city = i.Order.Account_Address__r.City__c;
        Id state = i.Order.Account_Address__r.City__r.State__c;
        Id country = i.Order.Account_Address__r.City__r.State__r.Country__c;
        Id productHierarchy = i.Product2.Product_Hierarchy__c;
        
        List<Shipping_Fee__c> item = [
            SELECT Name
            FROM Shipping_Fee__c
            WHERE (Product__c = :i.Product2Id OR Product_Hierarchy__c = :productHierarchy)
            AND (City__c = :city OR State__c = :state OR Country__c = :country)
        ];
        
        return item;
    }

    @AuraEnabled(cacheable=true)
    public static List<Tax__c> getTaxes(Id orderItemId){
        OrderItem i = [
            SELECT Product2Id,
                   Order.Account_Address__r.City__r.State__c
            FROM OrderItem
            WHERE Id = :orderItemId
            LIMIT 1
        ];

        Id state = i.Order.Account_Address__r.City__r.State__c;
        
        List<Tax__c> item = [
            SELECT Name
            FROM Tax__c
            WHERE Product__c = :i.Product2Id  AND State__c = :state
        ];
        
        return item;
    }

    @AuraEnabled(cacheable=true)
    public static List<Margin__c> getMargin(Id orderItemId){
        OrderItem i = [
            SELECT Product2Id,
                   Product2.Product_Hierarchy__c,
                   Order.Customer__c,
                   Order.Customer__r.Client_Group__c,
                   Order.Account_Address__r.City__c,
                   Order.Account_Address__r.City__r.State__c,
                   Order.Account_Address__r.City__r.State__r.Country__c
            FROM OrderItem
            WHERE Id = :orderItemId
            LIMIT 1
        ];

        Id city = i.Order.Account_Address__r.City__c;
        Id state = i.Order.Account_Address__r.City__r.State__c;
        Id country = i.Order.Account_Address__r.City__r.State__r.Country__c;
        Id productHierarchy = i.Product2.Product_Hierarchy__c;
        Id client = i.Order.Customer__c;
        Id accountGroup = i.Order.Customer__r.Client_Group__c;
        
        List<Margin__c> item = [
            SELECT Name
            FROM Margin__c
            WHERE (Product__c = :i.Product2Id OR Product_Hierarchy__c = :productHierarchy)
            AND (Account__c =: client OR Account_Group__c =: accountGroup)
            AND (City__c = :city OR State__c = :state OR Country__c = :country)
            ];
        
        return item;
    }
}
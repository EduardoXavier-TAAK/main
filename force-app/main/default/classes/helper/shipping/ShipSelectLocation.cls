public with sharing class ShipSelectLocation {
    
    public void selectFeeByLocation(OrderItem orderProd, Map<Id, Order> orderMap, Map<Id, Product2> products, List<Shipping_Fee__c> shipFee) {
        Shipping_Fee__c bestFee;
        Integer bestPriority = 0;
        
        Account_Address__c address = orderMap.get(orderProd.OrderId).Account_Address__r;
        Product2 product = products.get(orderProd.Product2Id);
        
        Id city = address.City__c;
        Id state = address.City__r.State__c;
        Id country = address.City__r.State__r.Country__c;
        
        for(Shipping_Fee__c j : shipFee) {
            Integer priority = 0;
            
            boolean matchesProduct = j.Product__c == product.Id;
            boolean matchesHierarchy = j.Product_Hierarchy__c != null && j.Product_Hierarchy__c == product.Product_Hierarchy__c;
            
            boolean matchesCity = j.City__c != null && j.City__c == city;
            boolean matchesState = j.State__c != null && j.State__c == state;
            boolean matchesCountry = j.Country__c != null && j.Country__c == country;
            
            if (matchesProduct) {

                if (matchesCity) { priority = 6; } else
                
                if (matchesState) { priority = 5; } else
                
                if (matchesCountry) { priority = 4; }
                
            } else if (matchesHierarchy) {
                
                if (matchesCity) { priority = 3; } else
                
                if (matchesState) { priority = 2; } else
                
                if (matchesCountry) { priority = 1; }
            }
            
            if (priority > bestPriority) {
                bestPriority = priority;
                bestFee = j;
                
            } else if(priority == bestPriority && bestFee != null){
                if(j.CreatedDate > bestFee.CreatedDate) bestFee = j;
            }
            
        }
        
        
        if(bestFee != null) {
            orderProd.Shipping_Cost__c = bestFee.Value__c;
            
            orderProd.Fee_Name__c = bestFee.Name;
        }
    }
}
public with sharing class SelectMarginHelper {
    public SelectMarginHelper() { }
    
    public void selectMargin(OrderItem orderItem, Map<Id, Order> orderMap, List<Margin__c> marginList) {
        Margin__c bestMargin;
        
        Account_Address__c address = orderMap.get(orderItem.OrderId).Account_Address__r;
        
        Id city = address.City__c;
        Id state = address.City__r.State__c;
        Id country = address.City__r.State__r.Country__c;
        
        for(Margin__c j : marginList) {
            
            Integer bestPriority = 0;
            Integer priority = 0;
            
            boolean matchesProduct = j.Product__c == orderItem.Product2Id;
            boolean matchesHierarchy = j.Product_Hierarchy__c == orderItem.Product2.Product_Hierarchy__c;
            
            boolean matchesClient = j.Account__c == orderItem.Order.Customer__c;
            boolean matchesGroup = j.Account_Group__c == orderItem.Order.Customer__r.Client_Group__c;

            boolean matchesCity = j.City__c != null && j.City__c == city;
            boolean matchesState = j.State__c != null && j.State__c == state;
            boolean matchesCountry = j.Country__c != null && j.Country__c == country;
            
            if (matchesProduct) {
                if(matchesClient) {
                    if (matchesCity) { priority = 12; } else
                    
                    if (matchesState) { priority = 11; } else
                    
                    if (matchesCountry) { priority = 10; }
                    
                } else if(matchesGroup) {
                    
                    if (matchesCity) { priority = 9; } else
                    
                    if (matchesState) { priority = 8; } else
                    
                    if (matchesCountry ) { priority = 7; }
                }
                
            } else if (matchesHierarchy) {

                if(matchesClient) {

                    if (matchesCity) { priority = 6; } else
                    
                    if (matchesState) { priority = 5; } else
                    
                    if (matchesCountry ) { priority = 4; }
                    
                } else if (matchesGroup) {
                    
                    if (matchesCity) { priority = 3; } else
                    
                    if (matchesState) { priority = 2; } else
                    
                    if (matchesCountry) { priority = 1; }
                }
                
            }
            
            if (priority > bestPriority) {
                bestPriority = priority;
                bestMargin = j;

                orderItem.Margin_Name__c = bestMargin.Name;
            }

            if(bestMargin != null) orderItem.Margin_Percentage__c = bestMargin.Value__c;
            
        }
    }

}
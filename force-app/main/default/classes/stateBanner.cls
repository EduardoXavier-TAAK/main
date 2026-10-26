public with sharing class stateBanner {
    public stateBanner() {}

@AuraEnabled(cacheable=true)
  public static String getStateSelect(Id account){
    Account_Address__c i = [SELECT City__r.State__r.FU__c FROM Account_Address__c WHERE Id = :account LIMIT 1 ];

    return i.City__r.State__r.FU__c;
  } 
}
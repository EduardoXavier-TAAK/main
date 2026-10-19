List<Product2> p = [SELECT Id, Name FROM Product2];

List<State__c> s = [SELECT Id, Name, FU__c FROM State__c];

List<Distribution_Center__c> d = [SELECT Id, Name FROM Distribution_Center__c];

List<Tax__c> t = new List<Tax__c>();

Map<Id, Tax__c> existingTaxes = new Map<Id, Tax__c>(
  [SELECT Id, Name, Product__c, State__c FROM Tax__c]
);

for (Product2 i : p) {
  for (State__c j : s) {
    Tax__c tax = new Tax__c();
    for (Tax__c existingTax : existingTaxes.values()) {
      if (existingTax.Product__c != i.Id && existingTax.State__c != j.Id) {
            tax.Name = j.FU__c + ' - ' + i.Name;
            tax.Product__c = i.Id;
            tax.State__c = j.Id;

            tax.Distribution_Center__c = d[0].Id;

            tax.Value__c = 0.5;

            t.add(tax);
            break;
      }
    }
  }
}

insert t;

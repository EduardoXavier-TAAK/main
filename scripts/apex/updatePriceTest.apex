List<Order> sla = [SELECT Id, Name FROM Order];

sla.get(0).Name = 'Eduardo';

Update sla.get(0);


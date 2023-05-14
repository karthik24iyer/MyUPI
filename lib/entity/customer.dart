class Customer {

  String id='';
  String name='';
  num amt=0.00;
  String? details='';
  String? refNo='';

  Customer({required this.id, required this.name, required this.amt, this.details, this.refNo});
}
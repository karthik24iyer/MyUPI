class Transaction {
  String date='';
  int trsId=0;
  String sentFrom='';
  String sentTo='';
  String upiId='';
  String notes='upi';

  Transaction({required this.date, required this.trsId, required this.sentFrom, required this.sentTo, required this.upiId, required this.notes});
}
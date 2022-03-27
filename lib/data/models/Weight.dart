class Weight{
  int rfid;
  int timestamp;
  double weightInGram;
  factory Weight.fromJson(Map<String, Object> json) {
    return Weight(
    Map<String, dynamic>.from(json).values.toList()[0]['RFID_tags_id_array'].int(),
    Map<String, dynamic>.from(json).values.toList()[0]['Timestamp'].int(),
    Map<String, dynamic>.from(json).values.toList()[0]['Weight_in_gram'].double(),);
  }
  Weight(this.rfid,this.timestamp,this.weightInGram);
  
}
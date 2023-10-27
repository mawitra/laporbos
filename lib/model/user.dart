class UserModel {
  final String clusterID;
  final String custID;
  final String officerID;
  final String officerName;
  final int pin;
  final String nik;
  final String nikPic;
  final String birthPlace;
  final String birthDate;
  final String gender;
  final String address;
  final String registerDate;
  final String activationDate;
  final int isActive;
  final String pendingID;
  final int levelID;
  final String createDate;
  final String createBy;
  final String lastUpdate;
  final String lastUpdateBy;

  UserModel({
    required this.clusterID,
    required this.custID,
    required this.officerID,
    required this.officerName,
    required this.pin,
    required this.nik,
    required this.nikPic,
    required this.birthPlace,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.registerDate,
    required this.activationDate,
    required this.isActive,
    required this.pendingID,
    required this.levelID,
    required this.createDate,
    required this.createBy,
    required this.lastUpdate,
    required this.lastUpdateBy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      clusterID: json['Cluster_ID'],
      custID: json['Cust_ID'],
      officerID: json['Officer_ID'],
      officerName: json['Officer_Name'],
      pin: json['PIN'],
      nik: json['NIK'],
      nikPic: json['NIK_Pic'],
      birthPlace: json['Birth_Place'],
      birthDate: json['Birth_Date'],
      gender: json['Gender'],
      address: json['Address'],
      registerDate: json['Register_Date'],
      activationDate: json['Activation_Date'],
      isActive: json['Is_Active'],
      pendingID: json['Pending_ID'],
      levelID: json['Level_ID'],
      createDate: json['Create_Date'],
      createBy: json['Create_By'],
      lastUpdate: json['Last_Update'],
      lastUpdateBy: json['Last_Update_By'],
    );
  }
}

class CustomerModel {
  final String clusterID;
  final String custID;
  final String custName; // Updated field
  final String custUserID; // Updated field
  final String password; // Updated field
  final String mobilePhone;
  final String address;
  final String email;
  final String taxID;
  final String taxIDPic;
  final String locQR1; // Updated field
  final String locQR2; // Updated field
  final String registerDate;
  final String activationID;
  final String activationDate;
  final int isActive;
  final int isForget; // Updated field
  final int levelID;
  final String createDate;
  final String createBy;
  final String lastUpdate;
  final String lastUpdateBy;

  CustomerModel({
    required this.clusterID,
    required this.custID,
    required this.custName,
    required this.custUserID,
    required this.password,
    required this.mobilePhone,
    required this.address,
    required this.email,
    required this.taxID,
    required this.taxIDPic,
    required this.locQR1,
    required this.locQR2,
    required this.registerDate,
    required this.activationID,
    required this.activationDate,
    required this.isActive,
    required this.isForget,
    required this.levelID,
    required this.createDate,
    required this.createBy,
    required this.lastUpdate,
    required this.lastUpdateBy,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      clusterID: json['Cluster_ID'],
      custID: json['Cust_ID'],
      custName: json['Cust_Name'],
      custUserID: json['Cust_User_ID'],
      password: json['Password'],
      mobilePhone: json['Mobile_Phone'],
      address: json['Address'],
      email: json['Email'],
      taxID: json['Tax_ID'],
      taxIDPic: json['Tax_ID_Pic'],
      locQR1: json['Loc_QR1'],
      locQR2: json['Loc_QR2'],
      registerDate: json['Register_Date'],
      activationID: json['Activation_ID'],
      activationDate: json['Activation_Date'],
      isActive: json['Is_Active'],
      isForget: json['Is_Forget'] ?? 0, // Default value if it's null
      levelID: json['Level_ID'],
      createDate: json['Create_Date'],
      createBy: json['Create_By'],
      lastUpdate: json['Last_Update'],
      lastUpdateBy: json['Last_Update_By'],
    );
  }
}

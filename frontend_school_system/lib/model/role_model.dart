class RoleModel{
  final int code;
  final String status;
  final List<Role> role;

  RoleModel({this.code = 0, this.status = "no-status", required this.role});
  factory RoleModel.fromMap(Map<String,dynamic>map)=>RoleModel(
    code: map["code"],
    status: map["status"],
    role: List<Role>.from(map["data"].map((e) => Role.fromMap(e))),
  );
}

class Role{
  final int id;
  final String? name;

  Role({this.id = 0, this.name = "no-role"});

  factory Role.fromMap(Map<String,dynamic>map)=>Role(
    id: map["id"],
    name: map["role"]
  );
}
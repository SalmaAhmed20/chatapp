class Room{
  static const COLLECTION_NAME='rooms';
  String id;
  String name;
  String description;
  String category;
  Room({required this.id,
    required this.name,
    required this.description,
    required this.category});
  Room.fromJson(Map<String ,dynamic>json):this(
    id : json['id'] as String,
    name : json['name'] as String,
    description : json['description'] as String,
    category:json['category'] as String,);
  Map<String , Object>toJson(){
    return{
      'id' :id,
      'name' : name,
      'description' : description,
      'category' :category
    };
  }
}
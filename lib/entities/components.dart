import 'package:qcmcore/models/components.dart';
import 'package:qcmcore/models/mixin_utils.dart';
import 'package:qcmcore/utils/toolkit.dart' as ToolKits;

class Author with JsonAble{
   static const String EXTRA_CONTENT_TYPE_PREFIX = "content_type_";
   static const String TAG = "author";
   String? id;
  //    public String alias = "";
   String? name = "";
   String? firstName = "";
   String? gender = "";
   String? email = "", phone = "";
   String? type = "";
   String? webSite = "";
   String? photoUri = "";
   String? bibliography = "";
   bool exposed = true;
   Bundle extras = Bundle();
   late String createdAtToString, updatedAtToString;

   Author.fromJson(Map<String, dynamic> json) {
     id = json["id"];
     name = json["name"];
     firstName = json["firstName"];
     gender = json["gender"];
     email = json["email"];
     phone = json["phone"];
     type = json["type"];
     webSite = json["webSite"];
     photoUri = json["photoUri"];
     bibliography = json["bibliography"];
     exposed = json["exposed"] ?? false;
     extras = Bundle(data: json["extras"]);
     createdAtToString = json["createdAt"] ?? ToolKits.dateNowFormatted();
     updatedAtToString = json["updatedAt"] ?? createdAtToString;
   }

   @override
   Map<String, dynamic> toJson({List<String> ignores = const []}) {
    Map<String, dynamic> json = {};
    if(!ignores.contains("createdAt")){
      json["createdAt"] = createdAtToString;
    }
    if(!ignores.contains("updatedAt")){
      json["updatedAt"] = updatedAtToString;
    }

    if(webSite?.isNotEmpty == true && !ignores.contains("webSite")) {
      json["webSite"] = webSite;
    }
    if(photoUri?.isNotEmpty == true && !ignores.contains("photoUri")) {
      json["photoUri"] = photoUri;
    }
    if(bibliography?.isNotEmpty == true && !ignores.contains("bibliography")) {
      json["bibliography"] = bibliography;
    }


    if(!ignores.contains("exposed")) {
      json["exposed"] = exposed;
    }
    if(extras.isNotEmpty == true && !ignores.contains("extras")) {
      json["extras"] = extras;
    }

    if(id?.isNotEmpty == true && !ignores.contains("id")) {
      json["id"] = id;
    }
    if(name?.isNotEmpty == true && !ignores.contains("name")) {
      json["name"] = name;
    }
    if(firstName?.isNotEmpty == true && !ignores.contains("firstName")) {
      json["firstName"] = firstName;
    }

    if(gender?.isNotEmpty == true && !ignores.contains("gender")) {
      json["gender"] = gender;
    }
    if(phone?.isNotEmpty == true && !ignores.contains("phone")) {
      json["phone"] = phone;
    }
    if(type?.isNotEmpty == true && !ignores.contains("type")) {
      json["type"] = type;
    }
    return json;
   }


   Author({Author? author, this.name, this.firstName, this.gender, this.email, this.phone, this.type, this.webSite, this.photoUri, this.bibliography, this.exposed = true, Bundle? bundle, String? createdAtToString, String? updatedAtToString}){
      this.createdAtToString = createdAtToString ?? ToolKits.dateNowFormatted();
      this.updatedAtToString = updatedAtToString ?? this.createdAtToString;
   }

   DateTime get updatedAt {
     try {
       return ToolKits.parseDateTime(updatedAtToString);
     } catch(e) {
       return createdAt;
     }
   }

   DateTime get createdAt {
     try {
       return ToolKits.parseDateTime(createdAtToString);
     } catch(e) {
       return DateTime.now();
     }
   }


}
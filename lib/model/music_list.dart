class Musiclist {
  // data type
  String? artistname;
  String? songname;
  String? duration;
  String? raitings;
  String? image;
  String? songurl;

  // constructor
  Musiclist({
    this.artistname,
    this.songname,
    this.duration,
    this.raitings,
    this.image,
    this.songurl,
  });

  //method that assign values to respective datatype vairables
  Musiclist.fromJson(Map<String, dynamic> json) {
    artistname = json['artistname'];
    songname = json['songname'];
    duration = json['duration'];
    raitings = json['raitings'];
    image = json['image'];
    songurl = json['songurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artistname'] = artistname;
    data['songname'] = songname;
    data['duration'] = duration;
    data['raitings'] = raitings;
    data['image'] = image;
    data['songurl'] = songurl;
    return data;
  }
}

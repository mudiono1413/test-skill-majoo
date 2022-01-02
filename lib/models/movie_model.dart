List<MovieModel> movieFromJson(dynamic res) {
  final data = res["d"];
  return List<MovieModel>.from(data.map((x) => MovieModel.fromJson(x)));
}

class MovieModelDVI {
  int? height;
  String? imageUrl;
  int? width;

  MovieModelDVI({
    this.height,
    this.imageUrl,
    this.width,
  });
  MovieModelDVI.fromJson(Map<String, dynamic> json) {
    height = json['height']?.toInt();
    imageUrl = json['imageUrl']?.toString();
    width = json['width']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['imageUrl'] = imageUrl;
    data['width'] = width;
    return data;
  }
}

class MovieModelDV {
  MovieModelDVI? i;
  String? id;
  String? l;
  String? s;

  MovieModelDV({
    this.i,
    this.id,
    this.l,
    this.s,
  });
  MovieModelDV.fromJson(Map<String, dynamic> json) {
    i = (json['i'] != null) ? MovieModelDVI.fromJson(json['i']) : null;
    id = json['id']?.toString();
    l = json['l']?.toString();
    s = json['s']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (i != null) {
      data['i'] = i!.toJson();
    }
    data['id'] = id;
    data['l'] = l;
    data['s'] = s;
    return data;
  }
}

class MovieModelDI {
  int? height;
  String? imageUrl;
  int? width;

  MovieModelDI({
    this.height,
    this.imageUrl,
    this.width,
  });
  MovieModelDI.fromJson(Map<String, dynamic> json) {
    height = json['height']?.toInt();
    imageUrl = json['imageUrl']?.toString();
    width = json['width']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['imageUrl'] = imageUrl;
    data['width'] = width;
    return data;
  }
}

class MovieModel {
  MovieModelDI? i;
  String? id;
  String? l;
  String? q;
  int? rank;
  String? s;
  List<MovieModelDV?>? v;
  int? vt;
  int? y;
  String? yr;

  MovieModel({
    this.i,
    this.id,
    this.l,
    this.q,
    this.rank,
    this.s,
    this.v,
    this.vt,
    this.y,
    this.yr,
  });
  MovieModel.fromJson(Map<String, dynamic> json) {
    i = (json['i'] != null) ? MovieModelDI.fromJson(json['i']) : null;
    id = json['id']?.toString();
    l = json['l']?.toString();
    q = json['q']?.toString();
    rank = json['rank']?.toInt();
    s = json['s']?.toString();
    if (json['v'] != null) {
      var v = json['v'];
      final arr0 = <MovieModelDV>[];
      v.forEach((v) {
        arr0.add(MovieModelDV.fromJson(v));
      });
      v = arr0;
    }
    vt = json['vt']?.toInt();
    y = json['y']?.toInt();
    yr = json['yr']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (i != null) {
      data['i'] = i!.toJson();
    }
    data['id'] = id;
    data['l'] = l;
    data['q'] = q;
    data['rank'] = rank;
    data['s'] = s;
    if (v != null) {
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['v'] = arr0;
    }
    data['vt'] = vt;
    data['y'] = y;
    data['yr'] = yr;
    return data;
  }
}



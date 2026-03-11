// // lib/models/product_model.dart

// class ProductLocation {
//   final String type;
//   final List<double> coordinates;

//   ProductLocation({
//     required this.type,
//     required this.coordinates,
//   });

//   factory ProductLocation.fromJson(Map<String, dynamic> json) {
//     return ProductLocation(
//       type: json['type'] ?? 'Point',
//       coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }

//   double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
//   double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;
// }

// class ProductUser {
//   final String id;
//   final String mobile;
//   final String name;
//   final String email;

//   ProductUser({
//     required this.id,
//     required this.mobile,
//     required this.name,
//     required this.email,
//   });

//   factory ProductUser.fromJson(Map<String, dynamic> json) {
//     return ProductUser(
//       id: json['_id'] ?? '',
//       mobile: json['mobile'] ?? '',
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'mobile': mobile,
//       'name': name,
//       'email': email,
//     };
//   }
// }

// class SubCategory {
//   final String id;
//   final String name;

//   SubCategory({
//     required this.id,
//     required this.name,
//   });

//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//     };
//   }
// }

// class ProductFeature {
//   final String id;
//   final String name;
//   final String? image;

//   ProductFeature({
//     required this.id,
//     required this.name,
//     this.image,
//   });

//   factory ProductFeature.fromJson(Map<String, dynamic> json) {
//     return ProductFeature(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'image': image,
//     };
//   }
// }

// class Product {
//   final String id;
//   final ProductUser? user;
//   final SubCategory subCategory;
//   final String name;
//   final String type;
//   final List<String> images;
//   final String address;
//   final String description;
//   final bool isApproved;
//   final bool isActive;
//   final List<ProductFeature> features;
//   final ProductLocation location;
//   final String? approvedBy;
//   final DateTime? approvedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Product({
//     required this.id,
//     this.user,
//     required this.subCategory,
//     required this.name,
//     required this.type,
//     required this.images,
//     required this.address,
//     required this.description,
//     required this.isApproved,
//     required this.isActive,
//     required this.features,
//     required this.location,
//     this.approvedBy,
//     this.approvedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['_id'] ?? '',
//       user: json['user'] != null ? ProductUser.fromJson(json['user']) : null,
//       subCategory: SubCategory.fromJson(json['subCategory'] ?? {}),
//       name: json['name'] ?? '',
//       type: json['type'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//       address: json['address'] ?? '',
//       description: json['description'] ?? '',
//       isApproved: json['isApproved'] ?? false,
//       isActive: json['isActive'] ?? true,
//       features: (json['features'] as List<dynamic>?)
//               ?.map((f) => ProductFeature.fromJson(f))
//               .toList() ??
//           [],
//       location: ProductLocation.fromJson(json['location'] ?? {}),
//       approvedBy: json['approvedBy'],
//       approvedAt: json['approvedAt'] != null
//           ? DateTime.parse(json['approvedAt'])
//           : null,
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'user': user?.toJson(),
//       'subCategory': subCategory.toJson(),
//       'name': name,
//       'type': type,
//       'images': images,
//       'address': address,
//       'description': description,
//       'isApproved': isApproved,
//       'isActive': isActive,
//       'features': features.map((f) => f.toJson()).toList(),
//       'location': location.toJson(),
//       'approvedBy': approvedBy,
//       'approvedAt': approvedAt?.toIso8601String(),
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

// class ProductListResponse {
//   final bool success;
//   final List<Product> products;

//   ProductListResponse({
//     required this.success,
//     required this.products,
//   });

//   factory ProductListResponse.fromJson(Map<String, dynamic> json) {
//     return ProductListResponse(
//       success: json['success'] ?? false,
//       products: (json['products'] as List<dynamic>?)
//               ?.map((p) => Product.fromJson(p))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'products': products.map((p) => p.toJson()).toList(),
//     };
//   }
// }




















// lib/models/product_model.dart

class ProductLocation {
  final String type;
  final List<double> coordinates;

  ProductLocation({
    required this.type,
    required this.coordinates,
  });

  factory ProductLocation.fromJson(Map<String, dynamic> json) {
    return ProductLocation(
      type: json['type'] ?? 'Point',
      coordinates: List<double>.from(json['coordinates'] ?? [0.0, 0.0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;
}

class ProductUser {
  final String id;
  final String mobile;
  final String name;
  final String email;

  ProductUser({
    required this.id,
    required this.mobile,
    required this.name,
    required this.email,
  });

  factory ProductUser.fromJson(Map<String, dynamic> json) {
    return ProductUser(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'name': name,
      'email': email,
    };
  }
}

class SubCategory {
  final String id;
  final String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class ProductFeature {
  final String id;
  final String name;
  final String? image;

  ProductFeature({
    required this.id,
    required this.name,
    this.image,
  });

  factory ProductFeature.fromJson(Map<String, dynamic> json) {
    return ProductFeature(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}

class ContactDetails {
  final String name;
  final String mobile;
  final String email;

  ContactDetails({
    required this.name,
    required this.mobile,
    required this.email,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'email': email,
    };
  }
}

class OpeningHours {
  final String openTime;
  final String closeTime;
  final List<String> days;

  OpeningHours({
    required this.openTime,
    required this.closeTime,
    required this.days,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      days: List<String>.from(json['days'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openTime': openTime,
      'closeTime': closeTime,
      'days': days,
    };
  }
}

class HouseRent {
  final double rentAmount;
  final String details;

  HouseRent({
    required this.rentAmount,
    required this.details,
  });

  factory HouseRent.fromJson(Map<String, dynamic> json) {
    return HouseRent(
      rentAmount: (json['rentAmount'] ?? 0).toDouble(),
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rentAmount': rentAmount,
      'details': details,
    };
  }
}

class VillaRent {
  final double rentAmount;
  final String details;

  VillaRent({
    required this.rentAmount,
    required this.details,
  });

  factory VillaRent.fromJson(Map<String, dynamic> json) {
    return VillaRent(
      rentAmount: (json['rentAmount'] ?? 0).toDouble(),
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rentAmount': rentAmount,
      'details': details,
    };
  }
}

class LandDetails {
  final double amount;
  final String details;

  LandDetails({
    required this.amount,
    required this.details,
  });

  factory LandDetails.fromJson(Map<String, dynamic> json) {
    return LandDetails(
      amount: (json['amount'] ?? 0).toDouble(),
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'details': details,
    };
  }
}

class Product {
  final String id;
  final ProductUser? user;
  final SubCategory subCategory;
  final String name;
  final String type;
  final List<String> images;
  final String address;
  final String description;
  final bool isApproved;
  final bool isActive;
  final List<ProductFeature> features;
  final ProductLocation location;
  final String? approvedBy;
  final DateTime? approvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // New fields
  final ContactDetails? contactDetails;
  final String? businessLocation;
  final OpeningHours? openingHours;
  final HouseRent? houseRent;
  final VillaRent? villaRent;
  final List<String>? shopServices;
  final List<String>? businessServices;
  final LandDetails? landDetails;
  final List<String>? restaurantServices;

  Product({
    required this.id,
    this.user,
    required this.subCategory,
    required this.name,
    required this.type,
    required this.images,
    required this.address,
    required this.description,
    required this.isApproved,
    required this.isActive,
    required this.features,
    required this.location,
    this.approvedBy,
    this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.contactDetails,
    this.businessLocation,
    this.openingHours,
    this.houseRent,
    this.villaRent,
    this.shopServices,
    this.businessServices,
    this.landDetails,
    this.restaurantServices,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      user: json['user'] != null 
          ? (json['user'] is String 
              ? null 
              : ProductUser.fromJson(json['user']))
          : null,
      subCategory: json['subCategory'] != null
          ? (json['subCategory'] is String
              ? SubCategory(id: json['subCategory'], name: '')
              : SubCategory.fromJson(json['subCategory']))
          : SubCategory(id: '', name: ''),
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      isApproved: json['isApproved'] ?? false,
      isActive: json['isActive'] ?? true,
      features: (json['features'] as List<dynamic>?)
              ?.map((f) => ProductFeature.fromJson(f))
              .toList() ??
          [],
      location: ProductLocation.fromJson(json['location'] ?? {}),
      approvedBy: json['approvedBy'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      contactDetails: json['contactDetails'] != null
          ? ContactDetails.fromJson(json['contactDetails'])
          : null,
      businessLocation: json['businessLocation'],
      openingHours: json['openingHours'] != null
          ? OpeningHours.fromJson(json['openingHours'])
          : null,
      houseRent: json['houseRent'] != null
          ? HouseRent.fromJson(json['houseRent'])
          : null,
      villaRent: json['villaRent'] != null
          ? VillaRent.fromJson(json['villaRent'])
          : null,
      shopServices: json['shopServices'] != null
          ? List<String>.from(json['shopServices'])
          : null,
      businessServices: json['businessServices'] != null
          ? List<String>.from(json['businessServices'])
          : null,
      landDetails: json['landDetails'] != null
          ? LandDetails.fromJson(json['landDetails'])
          : null,
      restaurantServices: json['restaurantServices'] != null
          ? List<String>.from(json['restaurantServices'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user?.toJson(),
      'subCategory': subCategory.toJson(),
      'name': name,
      'type': type,
      'images': images,
      'address': address,
      'description': description,
      'isApproved': isApproved,
      'isActive': isActive,
      'features': features.map((f) => f.toJson()).toList(),
      'location': location.toJson(),
      'approvedBy': approvedBy,
      'approvedAt': approvedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (contactDetails != null) 'contactDetails': contactDetails!.toJson(),
      if (businessLocation != null) 'businessLocation': businessLocation,
      if (openingHours != null) 'openingHours': openingHours!.toJson(),
      if (houseRent != null) 'houseRent': houseRent!.toJson(),
      if (villaRent != null) 'villaRent': villaRent!.toJson(),
      if (shopServices != null) 'shopServices': shopServices,
      if (businessServices != null) 'businessServices': businessServices,
      if (landDetails != null) 'landDetails': landDetails!.toJson(),
      if (restaurantServices != null) 'restaurantServices': restaurantServices,
    };
  }
}

class ProductListResponse {
  final bool success;
  final List<Product> products;

  ProductListResponse({
    required this.success,
    required this.products,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      success: json['success'] ?? false,
      products: (json['products'] as List<dynamic>?)
              ?.map((p) => Product.fromJson(p))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}

class ProductResponse {
  final bool success;
  final String message;
  final Product product;

  ProductResponse({
    required this.success,
    required this.message,
    required this.product,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'product': product.toJson(),
    };
  }
}
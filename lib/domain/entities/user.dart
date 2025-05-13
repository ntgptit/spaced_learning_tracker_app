import 'package:equatable/equatable.dart';

/// User entity
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? role;
  final DateTime? createdAt;
  final bool isEmailVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.phoneNumber,
    this.role,
    this.createdAt,
    this.isEmailVerified = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatarUrl,
        phoneNumber,
        role,
        createdAt,
        isEmailVerified,
      ];

  /// Create a copy of this User with the given fields replaced
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? phoneNumber,
    String? role,
    DateTime? createdAt,
    bool? isEmailVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  /// Empty user which represents unauthenticated state
  static const empty = User(
    id: '',
    name: '',
    email: '',
    isEmailVerified: false,
  );

  /// Convenience getter to determine if user is empty (unauthenticated)
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine if user is not empty (authenticated)
  bool get isNotEmpty => this != User.empty;
}

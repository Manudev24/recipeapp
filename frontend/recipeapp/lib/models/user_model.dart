class UserModel {
  String id;
  String userName;
  String firstName;
  String lastName;
  String membership;

  UserModel({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.membership,
  });
}

// ID              uuid.UUID `gorm:"type:char(36);primary_key;"`
// UserName        string    `gorm:"unique"`
// Name            string
// Password        string
// PasswordVersion uuid.UUID `gorm:"type:char(36)"`
// MembershipId    string
// LanguageId      string

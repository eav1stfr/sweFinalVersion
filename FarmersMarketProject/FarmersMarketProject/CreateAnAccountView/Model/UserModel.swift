
struct Buyer: Codable {
    var username: String
    var email: String
    var password: String
    var first_name: String
    var last_name: String
    var role: String
}

struct UserToLogin: Codable {
    var username_or_email: String
    var password: String
}


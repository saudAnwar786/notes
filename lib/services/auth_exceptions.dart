//login exception
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}
//register exceptions
class WeakPasswordAuthException implements Exception{}
class EmailAlreadyInUSePasswordAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}
//generic exception
class GenericAuthException implements Exception{}

class UserNotLoginAuthException implements Exception{}

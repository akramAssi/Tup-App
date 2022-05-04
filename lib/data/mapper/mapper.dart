import 'package:test_app/app/extensions.dart';
import 'package:test_app/data/responses/responses.dart';
import 'package:test_app/domain/model/model.dart';

extension CustomerResponsesMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this?.id?.orEmpty() ?? "", this?.name.orEmpty() ?? "",
        this?.numberOFNotification.orZero() ?? 0);
  }
}

extension ContactResponsesMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(this?.phone.orEmpty() ?? "", this?.email.orEmpty() ?? "",
        this?.link.orEmpty() ?? "0");
  }
}

extension AuthenticationResponsesMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

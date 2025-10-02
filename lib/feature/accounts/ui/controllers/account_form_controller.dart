import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/currency_input_formatter.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';

class AccountFormController extends GetxController {
  final AccountRepository _accountRepository = getIt<AccountRepository>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final balanceController = TextEditingController();
  final Rx<IconData?> selectedIcon = Rx(null);
  final Rx<Color?> selectedColor = Rx(null);

  final RxBool _isSubmitting = false.obs;
  final RxString _errorMessage = ''.obs;

  bool get isSubmitting => _isSubmitting.value;

  String get errorMessage => _errorMessage.value;

  Account? _editingAccount;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateIcon() {
    if (selectedIcon.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateColor() {
    if (selectedColor.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateBalace(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    return null;
  }

  void initEditing(Account account) {
    _editingAccount = account;
    nameController.text = account.name;
    balanceController.text = CurrencyInputFormatter.format(account.balance);
    selectedIcon.value = account.icon;
    selectedColor.value = account.color;
  }

  Future<void> saveOrUpdateAccount(BuildContext context) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    final Either<Failure, void> response;

    if (_editingAccount != null) {
      final updatedAccount = Account(
        id: _editingAccount!.id,
        name: nameController.text,
        balance: CurrencyInputFormatter.unformat(balanceController.text),
        iconCodePoint: selectedIcon.value!.codePoint,
        colorValue: selectedColor.value!.toARGB32(),
      );
      response = await _accountRepository.updateAccount(updatedAccount);
    } else {
      response = await _accountRepository.createAccount(
        name: nameController.text,
        balance: CurrencyInputFormatter.unformat(balanceController.text),
        iconCodePoint: selectedIcon.value!.codePoint,
        colorValue: selectedColor.value!.toARGB32(),
      );
    }

    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) {
        final accountsController = Get.find<AccountsController>();
        accountsController.getAccounts();
        context.pop();
        _clearFields();
      },
    );

    _isSubmitting.value = false;
  }

  Future<void> deleteAccount(BuildContext context) async {
    _isSubmitting.value = true;

    final response = await _accountRepository.deleteAccount(
      _editingAccount!.id,
    );
    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) {
        final accountsController = Get.find<AccountsController>();
        accountsController.getAccounts();
        context.pop();
        _clearFields();
      },
    );

    _isSubmitting.value = false;
  }

  void _clearFields() {
    nameController.clear();
    balanceController.clear();
    selectedColor.value = null;
    selectedIcon.value = null;
    _editingAccount = null;
  }

  void onDispose() {
    _clearFields();
    nameController.dispose();
    balanceController.dispose();
    selectedColor.value = null;
    selectedIcon.value = null;
  }
}

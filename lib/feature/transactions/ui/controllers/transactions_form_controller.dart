import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/currency_input_formatter.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/categories/domain/models/category.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';
import 'package:konta_app/feature/transactions/domain/usecases/create_transaction_usecase.dart';
import 'package:konta_app/feature/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:konta_app/feature/transactions/domain/usecases/update_transaction_usecase.dart';

class TransactionFormController extends GetxController {
  final CreateTransactionUsecase _createTransactionUsecase =
      getIt<CreateTransactionUsecase>();

  final UpdateTransactionUsecase _updateTransactionUsecase =
      getIt<UpdateTransactionUsecase>();

  final DeleteTransactionUsecase _deleteTransactionUsecase =
      getIt<DeleteTransactionUsecase>();

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final Rx<TransactionType> _selectedType = TransactionType.expense.obs;
  final Rx<Account?> _selectedAccount = Rx(null);
  final Rx<Category?> _selectedCategory = Rx(null);
  final Rx<DateTime?> _selectedDate = Rx(null);

  final RxBool _isSubmitting = false.obs;
  final RxString _errorMessage = ''.obs;
  Transaction? _editingTransaction;

  TransactionType get selectedType => _selectedType.value;

  Account? get selectedAccount => _selectedAccount.value;

  Category? get selectedCategory => _selectedCategory.value;

  DateTime? get selectedDate => _selectedDate.value;

  bool get isSubmitting => _isSubmitting.value;

  String get errorMessage => _errorMessage.value;

  void setTransactionType(TransactionType newType) {
    if (newType == _selectedType.value) return;
    _selectedCategory.value = null;
    _selectedType.value = newType;
  }

  void setAccount(Account newAccount) {
    if (newAccount == _selectedAccount.value) return;
    _selectedAccount.value = newAccount;
  }

  void setDate(DateTime newDate) {
    if (newDate == _selectedDate.value) return;
    _selectedDate.value = newDate;
  }

  void setCategory(Category newCategory) {
    if (newCategory == _selectedCategory.value) return;
    _selectedCategory.value = newCategory;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateAccount() {
    if (_selectedAccount.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateCategory() {
    if (_selectedCategory.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateDate() {
    if (_selectedDate.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  void initEditing(Transaction transaction) {
    _editingTransaction = transaction;

    _selectedType.value = transaction.type;
    amountController.text = CurrencyInputFormatter.format(transaction.amount);
    _selectedDate.value = transaction.date;
    descriptionController.text = transaction.description ?? '';
  }

  Future<void> createOrUpdateTransaction(BuildContext context) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    _errorMessage.value = '';
    final Either<Failure, void> response;

    if (_editingTransaction != null) {
      final updatedTransaction = _editingTransaction!.copyWith(
        type: _selectedType.value,
        amount: double.tryParse(amountController.text) ?? 0.0,
        date: _selectedDate.value,
        accountId: _selectedAccount.value!.id,
        categoryId: _selectedCategory.value!.id,
        description: descriptionController.text,
      );
      response = await _updateTransactionUsecase.call(
        newTransaction: updatedTransaction,
        oldTransaction: _editingTransaction!,
      );
    } else {
      response = await _createTransactionUsecase.call(
        type: _selectedType.value,
        amount: double.tryParse(amountController.text) ?? 0.0,
        date: _selectedDate.value!,
        accountId: _selectedAccount.value!.id,
        categoryId: _selectedCategory.value!.id,
        description: descriptionController.text,
      );
    }

    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) => context.pop(),
    );

    _isSubmitting.value = false;
  }

  Future<void> deleteTransaction(BuildContext context) async {
    _isSubmitting.value = true;

    final response = await _deleteTransactionUsecase.call(
      _editingTransaction!,
    );

    response.fold(
      ifLeft: (left) => _errorMessage.value = left.message,
      ifRight: (right) {
        context.pop();
        _clearFields();
      },
    );

    _isSubmitting.value = false;
  }

  void _clearFields() {
    amountController.clear();
    descriptionController.clear();
    _selectedType.value = TransactionType.expense;
    _selectedAccount.value = null;
    _selectedCategory.value = null;
    _selectedDate.value = null;

    _errorMessage.value = '';
    _editingTransaction = null;
  }

  @override
  void onClose() {
    _clearFields();
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}

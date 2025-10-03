import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/currency_input_formatter.dart';
import 'package:konta_app/common/utils/failure.dart';
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
  final Rx<TransactionType> selectedType = TransactionType.expense.obs;
  final Rx<String?> selectedAccountId = null.obs;
  final Rx<String?> selectedCategoryId = null.obs;
  final Rx<DateTime?> selectedDate = Rx(null);

  final RxBool _isSubmitting = false.obs;
  final RxString _errorMessage = ''.obs;
  Transaction? _editingTransaction;

  bool get isSubmitting => _isSubmitting.value;

  String get errorMessage => _errorMessage.value;

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateAccount() {
    if (selectedAccountId.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateCategory() {
    if (selectedCategoryId.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  String? validateDate() {
    if (selectedDate.value == null) return 'validation_empty_field'.tr;
    return null;
  }

  void initEditing(Transaction transaction) {
    _editingTransaction = transaction;

    selectedType.value = transaction.type;
    amountController.text = CurrencyInputFormatter.format(transaction.amount);
    selectedDate.value = transaction.date;
    descriptionController.text = transaction.description ?? '';
    selectedAccountId.value = transaction.accountId;
    selectedCategoryId.value = transaction.categoryId;
  }

  Future<void> createOrUpdateTransaction(BuildContext context) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    _isSubmitting.value = true;
    _errorMessage.value = '';
    final Either<Failure, void> response;

    if (_editingTransaction != null) {
      final updatedTransaction = _editingTransaction!.copyWith(
        type: selectedType.value,
        amount: double.tryParse(amountController.text) ?? 0.0,
        date: selectedDate.value,
        accountId: selectedAccountId.value,
        categoryId: selectedCategoryId.value,
        description: descriptionController.text,
      );
      response = await _updateTransactionUsecase.call(
        newTransaction: updatedTransaction,
        oldTransaction: _editingTransaction!,
      );
    } else {
      response = await _createTransactionUsecase.call(
        type: selectedType.value,
        amount: double.tryParse(amountController.text) ?? 0.0,
        date: selectedDate.value!,
        accountId: selectedAccountId.value!,
        categoryId: selectedCategoryId.value!,
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
    selectedType.value = TransactionType.expense;
    selectedAccountId.value = null;
    selectedCategoryId.value = null;
    selectedDate.value = null;

    _errorMessage.value = '';
    _editingTransaction = null;
  }

  void dispose() {
    _clearFields();
    amountController.dispose();
    descriptionController.dispose();
  }
}

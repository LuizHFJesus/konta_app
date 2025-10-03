import 'dart:async';
import 'package:dart_either/dart_either.dart';
import 'package:get/get.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/transactions/data/transactions_repository.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class TransactionsController extends GetxController {
  final TransactionsRepository _transactionRepository =
      getIt<TransactionsRepository>();

  final RxList<Transaction> _transactions = <Transaction>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  StreamSubscription<Either<Failure, List<Transaction>>>?
  _transactionsSubscription;

  List<Transaction> get transactions => _transactions.value;

  bool get isLoading => _isLoading.value;

  String get errorMessage => _errorMessage.value;

  void listenToTransactions() {
    _isLoading.value = true;
    _transactionsSubscription = _transactionRepository
        .listenTransactions()
        .listen(
          (eitherResult) {
            eitherResult.fold(
              ifLeft: (failure) => _errorMessage.value = failure.message,
              ifRight: (transactionList) {
                _transactions.value = transactionList;
              },
            );
            _isLoading.value = false;
          },
        );
  }

  Future<void> dispose() async {
    await _transactionsSubscription?.cancel();
  }
}

import 'package:get/get.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/data/repository/account_repository.dart';

class AccountsController extends GetxController {
  final AccountRepository _accountRepository = getIt<AccountRepository>();

  final RxList<Account> _accounts = <Account>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<Account?> _selectedAccount = Rx(null);
  final RxDouble _totalBalance = 0.0.obs;

  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  Account? get selectedAccount => _selectedAccount.value;
  double get totalBalance => _totalBalance.value;

  @override
  void onInit() {
    super.onInit();
    getAccounts();
  }

  void selectAccount(Account? account) {
    _selectedAccount.value = account;
  }

  void getAccounts() async {
    _errorMessage.value = '';
    _isLoading.value = true;

    final result = await _accountRepository.getAccounts();
    result.fold(
      ifLeft: (failure) => _errorMessage.value = failure.message,
      ifRight: (accountList) {
        _accounts.value = accountList;
        _calculateTotalBalance(accountList);
      },
    );

    _isLoading.value = false;
  }

  void _calculateTotalBalance(List<Account> accountList) {
    var sum = 0.0;
    for (final acc in accountList) {
      sum+= acc.balance;
    }
    _totalBalance.value = sum;
  }
}

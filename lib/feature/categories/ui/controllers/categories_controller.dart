import 'package:get/get.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/feature/categories/data/repositories/category_repository.dart';
import 'package:konta_app/feature/categories/domain/models/category.dart';

class CategoriesController extends GetxController {
  final CategoryRepository _categoryRepository = getIt<CategoryRepository>();

  final RxList<Category> _categories = <Category>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  List<Category> get categories => _categories;

  bool get isLoading => _isLoading.value;

  String get errorMessage => _errorMessage.value;

  Future<void> getCategories() async {
    _isLoading.value = true;
    _errorMessage.value = '';
    final result = await _categoryRepository.getCategories();
    result.fold(
      ifLeft: (failure) => _errorMessage.value = failure.message,
      ifRight: (categoryList) => _categories.value = categoryList,
    );
    _isLoading.value = false;
  }
}

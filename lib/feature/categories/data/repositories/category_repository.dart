import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/categories/domain/models/category.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<Category>>> getCategoriesByType(
    TransactionType transactionType,
  );

  Future<Either<Failure, Category>> getCategoryById(
    String categoryId,
  );
}

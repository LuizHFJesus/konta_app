import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/categories/domain/data/repositories/category_repository.dart';
import 'package:konta_app/feature/categories/domain/models/category.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';

class CategoryRepositoryMock implements CategoryRepository {
  final List<Category> _categories = [
    Category(
      id: 'cat1',
      type: TransactionType.expense,
      name: 'Alimentação',
      iconCodePoint: Icons.cake.codePoint,
      colorValue: const Color(0xFFF0522B).toARGB32(),
    ),
    Category(
      id: 'cat2',
      type: TransactionType.expense,
      name: 'Compras',
      iconCodePoint: Icons.shopping_bag.codePoint,
      colorValue: const Color(0xFF4570B5).toARGB32(),
    ),
    Category(
      id: 'cat3',
      type: TransactionType.expense,
      name: 'Lazer',
      iconCodePoint: Icons.headphones.codePoint,
      colorValue: const Color(0xFF9E5CA4).toARGB32(),
    ),
    Category(
      id: 'cat4',
      type: TransactionType.expense,
      name: 'Saúde',
      iconCodePoint: Icons.home_filled.codePoint,
      colorValue: const Color(0xFF95C940).toARGB32(),
    ),
    Category(
      id: 'cat5',
      type: TransactionType.expense,
      name: 'Transporte',
      iconCodePoint: Icons.directions_car.codePoint,
      colorValue: const Color(0xFFF1DD1E).toARGB32(),
    ),

    Category(
      id: 'cat6',
      type: TransactionType.income,
      name: 'Salário',
      iconCodePoint: Icons.payments.codePoint,
      colorValue: const Color(0xFFF2832A).toARGB32(),
    ),
    Category(
      id: 'cat7',
      type: TransactionType.income,
      name: 'Bônus',
      iconCodePoint: Icons.savings.codePoint,
      colorValue: const Color(0xFF4959A6).toARGB32(),
    ),
    Category(
      id: 'cat8',
      type: TransactionType.income,
      name: 'Empréstimo',
      iconCodePoint: Icons.credit_card.codePoint,
      colorValue: const Color(0xFF9E5CA4).toARGB32(),
    ),
    Category(
      id: 'cat9',
      type: TransactionType.income,
      name: 'Investimentos',
      iconCodePoint: Icons.percent.codePoint,
      colorValue: const Color(0xFFF1DD1E).toARGB32(),
    ),
    Category(
      id: 'cat10',
      type: TransactionType.income,
      name: 'Outras receitas',
      iconCodePoint: Icons.money.codePoint,
      colorValue: const Color(0xFF4EB84C).toARGB32(),
    ),
  ];

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    return Right(_categories);
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoriesByType(
    TransactionType transactionType,
  ) async {
    return Right(
      _categories.where((cat) => cat.type == transactionType).toList(),
    );
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(
    String categoryId,
  ) async {
    final category = _categories.firstWhereOrNull(
          (cat) => cat.id == categoryId,
    );
    if (category != null) {
      return Right(category);
    } else {
      return Left(Failure('Categoria não encontrada através do ID (mock).'));
    }
  }
}

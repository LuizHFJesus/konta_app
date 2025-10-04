import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/currency_input_formatter.dart';
import 'package:konta_app/common/widgets/confirmation_dialog.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
import 'package:konta_app/common/widgets/custom_tile.dart';
import 'package:konta_app/common/widgets/custom_toggle.dart';
import 'package:konta_app/common/widgets/picker_field.dart';
import 'package:konta_app/common/widgets/tile_selector_bottom_sheet.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/ui/bottom_sheets/account_selector_bottom_sheet.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';
import 'package:konta_app/feature/categories/domain/models/category.dart';
import 'package:konta_app/feature/categories/ui/controllers/categories_controller.dart';
import 'package:konta_app/feature/transactions/domain/models/transaction.dart';
import 'package:konta_app/feature/transactions/ui/controllers/transactions_form_controller.dart';

class TransactionFormView extends StatefulWidget {
  const TransactionFormView({super.key, this.transactionToEdit});

  final Transaction? transactionToEdit;

  @override
  State<TransactionFormView> createState() => _TransactionFormViewState();
}

class _TransactionFormViewState extends State<TransactionFormView> {
  late final TransactionFormController controller =
      getIt<TransactionFormController>();

  late final AccountsController accountsController = Get.put(
    getIt<AccountsController>(),
  );

  late final CategoriesController categoriesController =
      getIt<CategoriesController>();

  late final bool isEditing = widget.transactionToEdit != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await categoriesController.getCategories();
      if (isEditing) {
        controller.setAccount(
          accountsController.accounts.firstWhere(
            (acc) => acc.id == widget.transactionToEdit!.id,
          ),
        );
        controller.setCategory(
          categoriesController.getCategoryById(
            widget.transactionToEdit!.categoryId,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing ? 'Editar transação' : 'Adicionar nova transação',
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return const ConfirmationDialog(
                        title: 'Excluir transação',
                        content:
                            'Tem certeza que deseja excluir esta transação?',
                        cancelButtonText: 'Cancelar',
                        confirmButtonText: 'Excluir',
                      );
                    },
                  );

                  if (shouldDelete!) {
                    await controller.deleteTransaction(context);
                  }
                },
              ),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomToggle(
                  options: const [
                    ToggleOption('Saída'),
                    ToggleOption('Entrada'),
                  ],
                  selectedIndex: controller.selectedType.index,
                  onChanged: (index) => controller.setTransactionType(
                    TransactionType.values[index],
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controller.amountController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Saldo',
                    hintText: r'R$ 0,00',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  validator: controller.validateAmount,
                  readOnly: isEditing,
                  enabled: !isEditing,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.descriptionController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Digite a descrição da transação',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PickerField(
                  labelText: 'Conta',
                  onTap: () => _showAccountPicker(context),
                  validator: (_) => controller.validateAccount(),
                  valueWidget: controller.selectedAccount == null
                      ? Text(
                          'Selecione a conta',
                          style: TextStyle(color: theme.hintColor),
                        )
                      : Text(
                          controller.selectedAccount!.name,
                        ),
                ),
                const SizedBox(height: 16),

                PickerField(
                  labelText: 'Categoria',
                  onTap: () => _showCategoryPicker(context),
                  validator: (_) => controller.validateCategory(),
                  valueWidget: controller.selectedCategory == null
                      ? Text(
                          'Selecione a categoria',
                          style: TextStyle(color: theme.hintColor),
                        )
                      : Text(controller.selectedCategory!.name),
                ),
                const SizedBox(height: 16),

                PickerField(
                  labelText: 'Data',
                  onTap: () => _showDatePicker(context),
                  valueWidget: controller.selectedDate == null
                      ? Text(
                          'Selecione a data',
                          style: TextStyle(color: theme.hintColor),
                        )
                      : Text(
                          DateFormat(
                            'dd/MM/yyyy HH:mm',
                          ).format(controller.selectedDate!),
                        ),
                  icon: Icons.calendar_month,
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.errorMessage != '')
              Text(
                controller.errorMessage,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: CustomElevatedButton(
                text: isEditing ? 'Salvar alterações' : 'Criar nova conta',
                onPressed: () => controller.createOrUpdateTransaction(context),
                isSubmitting: controller.isSubmitting,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showAccountPicker(BuildContext context) async {
    final selectedAccount = await showModalBottomSheet<Account>(
      context: context,
      builder: (context) => AccountSelectorBottomSheet(
        selectedAccountId: controller.selectedAccount != null
            ? controller.selectedAccount!.id
            : '',
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );

    if (selectedAccount != null) controller.setAccount(selectedAccount);
  }

  void _showCategoryPicker(BuildContext context) async {
    final selectedCategory = await showModalBottomSheet<Category>(
      context: context,
      isScrollControlled: true,
      builder: (context) => TileSelectorBottomSheet<Category>(
        title: 'Categorias',
        items: categoriesController.categories,
        selectedItem: controller.selectedCategory,
        onItemSelected: (category) => context.pop(category),
        itemBuilder: (context, cat, isSelected) {
          return CustomTile(
            icon: cat.icon,
            color: cat.color,
            title: cat.name,
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
          );
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );

    if (selectedCategory != null) controller.setCategory(selectedCategory);
  }

  void _showDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: controller.selectedDate != null
          ? TimeOfDay.fromDateTime(controller.selectedDate!)
          : TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    controller.setDate(
      pickedDate.copyWith(hour: pickedTime.hour, minute: pickedTime.minute),
    );
  }
}

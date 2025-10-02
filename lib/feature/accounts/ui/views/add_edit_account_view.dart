import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/utils/currency_input_formatter.dart';
import 'package:konta_app/common/widgets/confirmation_dialog.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
import 'package:konta_app/common/widgets/picker_bottom_sheet.dart';
import 'package:konta_app/common/widgets/picker_field.dart';
import 'package:konta_app/feature/accounts/data/model/account.dart';
import 'package:konta_app/feature/accounts/ui/controllers/account_form_controller.dart';
import 'package:konta_app/feature/accounts/utils/account_presets.dart';

class AddEditAccountView extends StatefulWidget {
  const AddEditAccountView({super.key, this.accountToEdit});

  final Account? accountToEdit;

  @override
  State<AddEditAccountView> createState() => _AddEditAccountViewState();
}

class _AddEditAccountViewState extends State<AddEditAccountView> {
  late final AccountFormController controller;
  late final bool isEditing;

  @override
  void initState() {
    super.initState();
    controller = getIt<AccountFormController>();
    isEditing = widget.accountToEdit != null;
    if (isEditing) controller.initEditing(widget.accountToEdit!);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Editar conta' : 'Adicionar nova conta'),
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
                        title: 'Excluir conta',
                        content:
                            '''Tem certeza que deseja excluir esta conta?\nTodas as transações associadas a ela também serão removidas.''',
                        cancelButtonText: 'Cancelar',
                        confirmButtonText: 'Excluir',
                      );
                    },
                  );

                  if (shouldDelete!) await controller.deleteAccount(context);
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
                TextFormField(
                  controller: controller.nameController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nome da conta',
                    hintText: 'Digite o nome da conta',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: controller.validateName,
                ),
                const SizedBox(height: 16),
                PickerField(
                  labelText: 'Ícone',
                  onTap: _showIconPicker,
                  validator: (_) => controller.validateIcon(),
                  valueWidget: controller.selectedIcon.value == null
                      ? Text(
                          'Selecione um ícone',
                          style: TextStyle(color: Theme.of(context).hintColor),
                        )
                      : Icon(
                          controller.selectedIcon.value,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                ),
                const SizedBox(height: 16),
                PickerField(
                  labelText: 'Cor',
                  onTap: _showColorPicker,
                  validator: (_) => controller.validateColor(),
                  valueWidget: controller.selectedColor.value == null
                      ? Text(
                          'Selecione uma cor',
                          style: TextStyle(color: Theme.of(context).hintColor),
                        )
                      : Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: controller.selectedColor.value,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.balanceController,
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
                  validator: controller.validateBalace,
                  readOnly: isEditing,
                  enabled: !isEditing,
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
                onPressed: () => controller.saveOrUpdateAccount(context),
                isSubmitting: controller.isSubmitting,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showIconPicker() async {
    final selectedIcon = await showModalBottomSheet<IconData>(
      context: context,
      builder: (context) => PickerBottomSheet<IconData>(
        title: 'Selecione um ícone',
        items: AccountPresets.predefinedIcons,
        itemBuilder: (iconData) {
          return IconButton(
            onPressed: () => context.pop(iconData),
            icon: Icon(iconData, size: 24),
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

    if (selectedIcon != null) controller.selectedIcon.value = selectedIcon;
  }

  void _showColorPicker() async {
    final selectedColor = await showModalBottomSheet<Color>(
      context: context,
      builder: (context) => PickerBottomSheet<Color>(
        title: 'Selecione uma cor',
        items: AccountPresets.predefinedColors,
        itemBuilder: (color) {
          return InkWell(
            onTap: () => context.pop(color),
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
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

    if (selectedColor != null) controller.selectedColor.value = selectedColor;
  }
}

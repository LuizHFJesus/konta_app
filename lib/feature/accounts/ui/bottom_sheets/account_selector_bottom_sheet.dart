import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
import 'package:konta_app/common/widgets/custom_text_button.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';
import 'package:konta_app/feature/accounts/ui/widgets/account_selector_tile.dart';

class AccountSelectorBottomSheet extends StatelessWidget {
  const AccountSelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AccountsController>();
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      }

      if (controller.errorMessage != '') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 32,
            children: [
              Text(
                'Erro: ${controller.errorMessage}',
                style: theme.textTheme.headlineMedium,
              ),
              CustomElevatedButton(
                onPressed: controller.listenToAccounts,
                text: 'Tentar novamente',
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contas', style: theme.textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => context.push('/accounts'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                AccountSelectorTile(
                  icon: Icons.wallet,
                  color: theme.colorScheme.onSurfaceVariant,
                  name: 'Todas as contas',
                  balance: controller.totalBalance,
                  onTap: () => controller.selectAccount(null),
                  isSelected: controller.selectedAccount == null,
                ),
                const SizedBox(height: 8),

                ...controller.accounts.map((acc) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AccountSelectorTile(
                      icon: acc.icon,
                      color: acc.color,
                      name: acc.name,
                      balance: acc.balance,
                      onTap: () => controller.selectAccount(acc),
                      isSelected: controller.selectedAccount?.id == acc.id,
                    ),
                  );
                }),
              ],
            ),
            CustomTextButton(
              icon: Icon(
                Icons.add_box_outlined,
                color: theme.colorScheme.primary,
              ),
              text: 'Adicionar nova conta',
              onPressed: () => context.push('/accounts'),
            ),
          ],
        ),
      );
    });
  }
}

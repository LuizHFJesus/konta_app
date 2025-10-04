import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/di/dependency_injection.dart';
import 'package:konta_app/app/navigation/app_routes.dart';
import 'package:konta_app/common/widgets/custom_elevated_button.dart';
import 'package:konta_app/common/widgets/custom_tile.dart';
import 'package:konta_app/feature/accounts/ui/controllers/accounts_controller.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AccountsController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contas'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) return _buildLoadingState();
        if (controller.errorMessage != '') {
          return _buildErrorState(controller, theme);
        }

        if (controller.accounts.isEmpty) return _buildEmptyState(context);

        return ListView.separated(
          itemCount: controller.accounts.length,
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final account = controller.accounts[index];

            return CustomTile(
              icon: account.icon,
              color: account.color,
              title: account.name,
              subTitle: 'Saldo: R\$ ${account.balance.toStringAsFixed(2)}',
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await context.push(
                  AppRoutes.accountsEdit.replaceFirst(':id', account.id),
                  extra: account,
                );
              },
            );
          },
        );
      }),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: controller.errorMessage == ''
            ? CustomElevatedButton(
                text: 'Criar nova conta',
                onPressed: () async {
                  await context.push(AppRoutes.accountsCreate);
                },
              )
            : CustomElevatedButton(
                text: 'Tentar novamente',
                onPressed: controller.getAccounts,
              ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(AccountsController controller, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Text(
          'Erro: ${controller.errorMessage}',
          style: theme.textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/wallet-no-accounts.svg',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: 24),
            Text(
              'Você ainda não cadastrou nenhuma conta.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

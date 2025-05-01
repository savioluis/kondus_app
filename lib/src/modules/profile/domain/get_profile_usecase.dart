import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/src/modules/profile/domain/profile_model.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';

final class GetProfileUsecase {
  Future<ProfileState> call() async {
    final authService = GetIt.instance<AuthService>();

    try {
      final userContent = await authService.getLoggedUserInfo();

      if (userContent == null) {
        return ProfileErrorState(
          error: KondusError(
            message: 'Erro ao obter dados do usuário.',
            type: KondusErrorType.unknown,
          ),
        );
      }

      final model = ProfileModel.fromDTO(userContent);

      return ProfileSuccessState(model: model);
    } on HttpError catch (e) {
      return ProfileErrorState(
        error: KondusError(
          message: e.message,
          type: KondusErrorType.unknown,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}

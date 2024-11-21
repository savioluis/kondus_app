import 'package:kondus/core/providers/url_launcher/i_url_launcher_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherProvider implements IUrlLauncherProvider {
  @override
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Future<void> openMail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch mailto:$email');
    }
  }

  @override
  Future<void> openPhone(String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch tel:$phoneNumber');
    }
  }
}

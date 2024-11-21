abstract interface class IUrlLauncherProvider {
  Future<void> openUrl(String url);
  Future<void> openMail(String email);
  Future<void> openPhone(String phoneNumber);
}

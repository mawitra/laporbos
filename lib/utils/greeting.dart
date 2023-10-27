class GreetingUtil {
  static String getGreetingMessage() {
    final currentTime = DateTime.now().hour;

    if (currentTime >= 0 && currentTime < 10) {
      return 'Selamat Pagi';
    } else if (currentTime >= 10 && currentTime < 14) {
      return 'Selamat Siang';
    } else if (currentTime >= 14 && currentTime < 17) {
      return 'Selamat Sore';
    } else if (currentTime >= 17 && currentTime < 24) {
      return 'Selamat Malam';
    }

    return 'Selamat';
  }
}

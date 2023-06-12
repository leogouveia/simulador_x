class TimeGreeting {
  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom Dia';
    } else if (hour < 17) {
      return 'Boa Tarde';
    } else {
      return 'Boa Noite';
    }
  }
}

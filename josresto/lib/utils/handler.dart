class ErrorHandler {
  static String errorHandlerMessage(String error) {
    if (error.contains("SocketException")) {
      return "Tidak dapat terhubung ke internet, Periksa koneksi anda";
    } else if (error.contains("TimeoutException")) {
      return "Waktu permintaan habis. Silahkan coba lagi nanti";
    } else if (error.contains("404")) {
      return "Data tidak ditemukan";
    } else if (error.contains("505")) {
      return "Terjadi kesalahan pada server. Silahkan coba lagi nanti";
    } else {
      return "Terjadi kesalahan, silahkan coba lagi nanti";
    }
  }
}

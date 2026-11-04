class AppError extends Error {
  final String error;

  AppError([this.error = "Ocorreu um erro, tente novamente"]);
}

class StringResources {
  /* Commons */
  static const String appName = "Vallexplora";
  static const String slogan = "";
  static const String optionalField = " (opcional)";
  static const String optionOr = "o";
  static const String signInWithGoogle = "Inicia sesión con Google";

  /* Welcome Screen */
  static const String welcomeTitle = "Bienvenido a $appName";
  static const String welcomeSubtitle =
      "¡Registrate, y explora el Valle con nosotros!";
  static const String login = "¿Ya tienes una?";
  static const String register = "Crea tu cuenta";

  /* Registration Screen */
  static const String signUpTitle = "¡Empieza a explorar el Valle!";
  static const String signUpFormFullName = "¿Cómo te llamamos?";
  static const String signUpFormEmail = "Tu correo";
  static const String signUpFormEmailInfo = "Lo usarás para iniciar sesión";
  static const String signUpFormPhone = "Tu número de teléfono";
  static const String signUpFormPassword = "Escribe una contraseña";
  static const String signUpFormPasswordInfo =
      "Una fuerte, que puedas recordar";
  static const String signUpFormPasswordVerify = "Escríbela otra vez";
  static const String signUpFormSubmit = "¡Empecemos!";
  static const String signUpLoginInstead =
      "¿Ya tienes una cuenta? Inicia sesión aquí";

  static const String emailIsInvalidError = "Ingresa un email válido";
  static const String emailIsTakenError = "Ese correo ya está en uso";
  static const String passTooShortError = "Tu contraseña es muy corta";
  static const String passIsInvalidError = "Tu contraseña no es válida";

  static const String signUpSuccess =
      "Te has registrado con éxito. ¡Bienvenido a Vallexplora! Iniciando sesión...";
  static const signUpErrorMessages = {
    "Weak": "La contraseña no cumple con los requisitos mínimos de seguridad.",
    "EmailTaken": "El correo ingresao ya está en uso.",
  };

  /* Login Screen */
  static const String loginTitle = "Nos alegra verte de nuevo";
  static const String loginFormEmail = "Tu correo";
  static const String loginFormPassword = "Tu contraseña";
  static const String loginFormForgot = "¿La olvidaste?";
  static const String loginFormSubmit = "Iniciar sesión";
  static const String loginLoading = "Iniciando sesión...";
  static const String loginSignUpInstead =
      "¿No tienes una cuenta todavía? Registrate aquí";

  static loginSuccess(String displayName) =>
      "Sesión iniciada correctamente. Bienvenido, $displayName";
  static const loginErrorMessages = {};

  /* Challenges Screen */
  static const String newChallengeTitle = "Nuevo desafío";
  static const String newChallengeName = "¿Cómo se llama el desafío?";
  static const String newChallengeDescription = "¿En qué consistirá?";
  static const String newChallengePoints = "¿Cuántos puntos vale?";
  static const String newChallengeFrom = "¿Cuándo empieza?";
  static const String newChallengeTo = "¿Cuándo vence?";
  static const String newChallengePlace = "¿En qué municipio?";
}


enum tipo_enum {
  Conferenza, Libro, Rivista, Fascicolo, Articolo
}

tipo_enum? convertStringToEnum(String value) {
  try {
    return tipo_enum.values.firstWhere(
            (e) => enumToString(e).toLowerCase() == value.toLowerCase());
  } catch (e) {
    return null;
  }
}

String convertEnumToString(tipo_enum value) {
  return enumToString(value).split('.').last;
}

String enumToString(Object enumValue) => enumValue.toString().split('.').last;

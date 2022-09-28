class JSON {
  static T resolve<T>(
      {required Map<String, dynamic> json,
      required String path,
      required T defaultValue}) {
    try {
      dynamic current = json;
      path.split('.').forEach((segment) {
        final maybeInt = int.tryParse(segment);

        if (maybeInt != null && current is List<dynamic>) {
          current = current[maybeInt];
        } else if (current is Map<String, dynamic>) {
          current = current[segment];
        }
      });

      return (current as T) ?? defaultValue;
    } catch (error) {
      return defaultValue;
    }
  }
}

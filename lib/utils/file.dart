class FileUtils {
  static String getFileNameFromPath(String path) {
    final splittedPaths = path.split('/');
    return splittedPaths.last;
  }
}

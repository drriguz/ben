class Version {
  static int major = 0;
  static int minor = 1;

  get fullVersion {
    return "${major}.${minor}";
  }
}

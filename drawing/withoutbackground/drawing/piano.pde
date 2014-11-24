class Piano {
  String pitch;
  int locked = 0;
  Piano(String _pitch) {
    pitch = _pitch;
  }

  void play() {
    if (locked < 1) {
      out.playNote( 0.0, 0.3, this.pitch);
      locked = 10;
    }
  }

  void playNote() {
  }

  void update() {
    locked -=1;
  }

  String getPitch() {
    return pitch;
  }
}


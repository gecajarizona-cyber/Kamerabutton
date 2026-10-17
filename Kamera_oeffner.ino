bool wasTouched13 = false;
bool wasTouched14 = false;

void setup() {
  Serial.begin(115200);
}

void loop() {
  bool touched13 = touchRead(13) < 900;
  bool touched14 = touchRead(14) < 900;

  // Pin 13: Kamera öffnen
  if (touched13 && !wasTouched13) {
    Serial.println("OPEN");
  }

  // Pin 14: Foto machen
  if (touched14 && !wasTouched14) {
    Serial.println("FOTO");
  }

  wasTouched13 = touched13;
  wasTouched14 = touched14;

  delay(50);
}



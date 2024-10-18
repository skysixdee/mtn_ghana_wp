import 'dart:math';

int getTransactionId() {
  Random random = Random();
  int randomNumber = random.nextInt(1000000000);
  return randomNumber;
}

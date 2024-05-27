String formatCurrency(int amount) {
    if (amount >= 1000000) {
      double result = amount / 1000000;
      if (result % 1 == 0) {
        return 'Rp ${result.toInt()} jt/thn';
      } else {
        return 'Rp ${result.toStringAsFixed(1)} jt/thn';
      }
    } else if (amount >= 1000) {
      double result = amount / 1000;
      if (result % 1 == 0) {
        return 'Rp ${result.toInt()} thn';
      } else {
        return 'Rp ${result.toStringAsFixed(1)} thn';
      }
    } else {
      return 'Rp $amount';
    }
  }
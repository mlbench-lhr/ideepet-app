String formatPhone(String? phone) {
  if (phone == null) {
    return '';
  }
  if (phone.startsWith('+55')) {
    phone = phone.substring(3);
  }

  if (phone.length == 11) {
    return '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
  } else if (phone.length == 10) {
    return '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6)}';
  }

  return phone;
}

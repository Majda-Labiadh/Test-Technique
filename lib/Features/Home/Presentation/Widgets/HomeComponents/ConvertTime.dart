String convertTime(String startH, String startM, String endH, String endM) {
  if (startH.length == 1) {
    startH = '0' + startH;
  }
  if (endH.length == 1) {
    endH = '0' + endH;
  }
  if (startM.length == 1) {
    startM = '0' + startM;
  }
  if (endM.length == 1) {
    endM = '0' + endM;
  }
  return startH + ':' + startM + '-' + endH + ':' + endM;
}

import processing.serial.*;

Serial port;

int BAUD = 9600;

String APIKEY = "xxx";
String CITYNAME = "Boston";

int STRLEN = 16;

void setup() {
  port = new Serial(this, Serial.list()[2], BAUD); // set baud rate
  println(Serial.list());
  delay(2000); // wait for the LCD to initialize
}

void draw() {
  
  JSONObject resp = getResponse(CITYNAME, APIKEY);  
  
  String tempStr = getTempStr(resp);
  String desc = getDesc(resp);
  String outstr = tempStr + desc;

  port.clear();
  port.write(outstr);
 
  println(tempStr);
  println(desc);
  
  delay(10*60*1000);
  
}

JSONObject getResponse(String cityname, String apiKey) {
  String request = "http://api.openweathermap.org/data/2.5/weather?q=" + cityname + 
                   "&appid=" + apiKey;
  println(request);
  return loadJSONObject(request);
}

String getDesc(JSONObject response) {
  JSONArray weather = response.getJSONArray("weather");
  String desc = weather.getJSONObject(0).getString("description");
  return padStr(desc, STRLEN); 
}

String getTempStr(JSONObject response) {
  JSONObject main = response.getJSONObject("main");
  String temp = String.format("%3.1f degrees F", kelvin2F(main.getFloat("temp")));
  return padStr(temp, STRLEN);
}

float kelvin2F(float kelvin) { return (kelvin - 273.15) * 1.8 + 32.0; }

String padStr(String str, int padLen) {
  int len = str.length();
  if (len < padLen) { for (int i = len; i < padLen; i++) { str += " "; } }
  if (len > padLen) { str = str.substring(0, padLen); }
  return str;
}
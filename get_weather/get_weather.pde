import processing.serial.*;

Serial port;
int BAUD = 9600;
String APIKEY = "xxx";
String CITYNAME = "Boston";

void setup() {
  port = new Serial(this, Serial.list()[2], BAUD); // set baud rate
  println(Serial.list());
  delay(5000); // wait for the LCD to initialize
}

void draw() {
  
  JSONObject resp = getResponse(CITYNAME, APIKEY);  
  
  String tempStr = getTempStr(resp);
  port.write(0xff);
  port.write(tempStr);
  
  String desc = getDesc(resp);
  port.write(0xfe);
  port.write(desc);
  
  port.write(0xfd);
  
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
  return weather.getJSONObject(0).getString("description");
}

String getTempStr(JSONObject response) {
  JSONObject main = response.getJSONObject("main");
  return String.format("%3.1f degrees F", kelvin2F(main.getFloat("temp")));
}

float kelvin2F(float kelvin) { return (kelvin - 273.15) * 1.8 + 32.0; }
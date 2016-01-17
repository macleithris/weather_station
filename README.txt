ARDUINO WEATHER STATION
-----------------------

Things you need:
  - an Arduino
  - an 16x2 LCD
  - an internet-connected computer with the Arduino and Processing
    software installed
      - Arduino: https://www.arduino.cc/en/Main/Software
      - Processing: https://processing.org/download/
  - a USB cable to hook up the Arduino to your computer

Step 1
------

To be able to access the weather data you need to get an API key
from openweathermap.org. It's free & easy & takes two minutes.
Create an account here:

http://www.openweathermap.org/

When you log in you should be able to see the API key under your
profile. It's a big long hexadecimal number that looks like 
"4434f7c07....". 

Step 2
------

Wire up the LCD to the Arduino. I won't describe how to do this in 
detail, but you want to hook it up the same way as Project 11 in 
the Arduino projects book, except without the tilt sensor.

Step 3
------

Open up the write_to_lcd Arduino sketch and load it onto the 
Arduino. If you've done everything right, you'll see a message
printed on the LCD "Waiting for weather data...".

Step 4
------

Close the Arduino sketch and open up the get_weather Processing
sketch. You need to change lines 7 and 8: replace the xxx with 
the API key from step 1, and change Boston in line 8 to whatever
city you want. Now run the Processing sketch. After a short delay
you should see the weather report on the LCD. The temperature
will be on line 1 and the description will be on line 2.
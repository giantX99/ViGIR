import csv
import time
from RPLCD.i2c import CharLCD

#CharLCD(i2c port expander, LCD address in memory) = initiates the class variable

#RPLCD functions:
    #lcd.write_string('') -> writes (\n = new line, \r = go back to column 0 (row,0))
    #lcd.cursor_pos = (row, col) -> cursor position, when '= home()' go back to initial position
    #lcd.clear() -> clean the display, reset cursor position
    #lcd.close(clear = True) -> close() clears the connection
    #lcd.cursor_mode = ... -> 'hide' = no cursor displayed ; 'line' = cursor indicated by underline ; 'blink' = cursor is blinking square.

#setup:
def lcd_setup():
    lcd = CharLCD('PCF8574', 0x27) #The correct i2c_expander from our lcd display is PCF8574T however RPLCD doesnt support the T in the end...
    lcd.clear()
    lcd.cursor_mode = 'hide'
    lcd.cursor_pos = (0,3)
    lcd.write_string('1234567890')
    lcd.cursor_pos = (1,3)
    return lcd

#reading file: 
def status_from_file(file_name):
    camera_status = []
    suffix = '.csv'

    if (file_name.endswith(suffix)):
        file_name = file_name
    else:
        file_name += suffix

    try:
        csv_file = open(file_name, 'r')
        csv_reader = list(csv.reader(csv_file))
        csv_reader.sort(key=lambda csv_reader: csv_reader[0])
        for i in csv_reader:
            camera_status.append(i[1])
        csv_file.close()
        return camera_status
    except FileNotFoundError:
        print('File not found!')
        csv_file.close()
        return None
    
#main:
def lcd_feedback(csv_file):
    lcd = lcd_setup()
    camera_status = status_from_file(csv_file)
    if camera_status is None :
        lcd.clear()
        lcd.write_string('File Error!\n\rTry again.')
    else:
        for status in camera_status:
            if status == '1':
                print('camera[{status}] = Y')
                lcd.write_string('Y')
            else:
                print('camera[{status}] = N')
                lcd.write_string('N')
        if camera_status.count('0') is False:
            time.sleep(10)
            lcd.clear()
            lcd.wirte_string('Capture Success!')
    lcd.close(clear = True)

if __name__ == "__main__":
    lcd_feedback(input())

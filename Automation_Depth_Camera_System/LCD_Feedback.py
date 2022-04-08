import csv
from RPLCD.i2c import CharLCD

lcd = CharLCD('PCF8574T', ) #(i2c port expander, LCD address in memory) = initiates the class variable

#RPLCD functions:
    #lcd.write_string('') -> writes (\n = new line, \r = go back to column 0 (row,0))
    #lcd.cursor_pos = (row, col) -> cursor position, when '= home()' go back to initial position
    #lcd.clear() -> clean the display
    #lcd.close(clear = True) -> close() clears the connection
    #lcd.cursor_mode = ... -> 'hide' = no cursor displayed ; 'line' = cursor indicated by underline ; 'blink' = cursor is blinking square.

#setup:
lcd.clear()
lcd.cursor_mode = 'hide'
lcd.cursor_pos = (0,3)
lcd.write_string('1234567890')
lcd.cursor_pos = (1,3)

#reading file:
#conditional statement: if camera x capture pic write Y at (1,x+2) 
def read_file(camera_status):
    file_name = input('Enter file name: ')
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
    except FileNotFoundError:
        print('File not found!')
        

def main():
    camera_status = []
    read_file(camera_status)

    for status in camera_status:
        lcd.cursor_pos = (1,status+2)
        if status == '1':
            print('camera['+ status +'] = Y')
            lcd.write_string('Y')
        else:
            print('camera['+ status +'] = N')
            lcd.write_string('N')

if __name__ == "__main__":
    main()
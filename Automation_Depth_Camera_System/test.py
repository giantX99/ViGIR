import csv
import time

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
        
def lcd_feedback(csv_file):
    #lcd = lcd_setup()
    camera_status = status_from_file(csv_file)
    if camera_status is None :
        #lcd.clear()
        #lcd.write_string('File Error!\n\rTry again.')
        print('File Error!\nTry again.')
    else:
        for status in camera_status:
            if status == '1':
                print('camera[{status}] = Y')
                #lcd.write_string('Y')
            else:
                print('camera[{status}] = N')
                #lcd.write_string('N')
        if camera_status.count('0') is False:
            time.sleep(4)
            print('Capture Successful!')
            #lcd.clear()
            #lcd.wirte_string('Capture Success!')
    #lcd.close(clear = True)

if __name__ == "__main__":
    lcd_feedback(input())
import csv

def read_file(camera_status):
    while(True):
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
            #print(camera_status)
            csv_file.close()
            break
        except FileNotFoundError:
            print('File not found!')
            continue

def main():
    while (True):
        camera_status = []
        read_file(camera_status)

        for status in camera_status:
            #lcd.cursor_pos = (1,i+2)
            if status == '1':
                print('camera['+ status +'] = Y')
                #lcd.write_string('Y')
            else:
                print('camera['+ status +'] = N')
                #lcd.write_string('N')

if __name__ == "__main__":
    main()
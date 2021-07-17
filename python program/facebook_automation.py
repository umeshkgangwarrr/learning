from selenium import webdriver
from time import sleep
#import getpass
from getpass import getpass
from webdriver_manager.chrome import ChromeDriverManager 
from selenium.webdriver.chrome.options import Options

usr = input('Enter the Email id:')
#pwd = input('Enter the password')
#pwd = getpass.getpass(prompt='Enter the password: ')
pwd = getpass('Enter the Password: ')

#usr = 'umer@gmail.com'

#pwd = 'ujkfhkf'

driver = webdriver.Chrome(ChromeDriverManager().install())
#driver = webdriver.Chrome(r"C:\Users\Gangwar\Downloads\chromedriver_win32\chromedriver.exe")
driver.get('https://www.facebook.com/')
driver.maximize_window()
print('Opened Facebook Successfully.')
sleep(1)

driver.find_element_by_id('email').send_keys(usr)
print("Email ID entered.")

driver.find_element_by_id('pass').send_keys(pwd)
print("Password entered")

login_box = driver.find_element_by_id('u_0_b') # button id which you can find in facebook souce code (name="login")
login_box.click()



print("Done")
input('Press any key to quit')
driver.quit()
print('finish')


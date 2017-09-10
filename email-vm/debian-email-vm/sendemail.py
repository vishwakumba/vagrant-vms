import smtplib
from email.mime.text import MIMEText
import datetime

to = 'vishwa.dwp@gmail.com'
gmail_user = 'dwp.chaps.monitoring@gmail.com'
gmail_password = 'S3cr3t00'

today = datetime.date.today()
sub = 'From python email, with love..on %s' % today.strftime('%b %d %Y')
data = 'Hello, how are you!, My name is Monty Python & Friends..'

smtpserver = smtplib.SMTP('smtp.gmail.com', 587)
smtpserver.ehlo()
smtpserver.starttls()
smtpserver.ehlo
smtpserver.login(gmail_user, gmail_password)

msg = MIMEText(data)
msg['Subject'] = sub 
msg['From'] = gmail_user
msg['To'] = to
smtpserver.sendmail(gmail_user, [to], msg.as_string())
smtpserver.quit()


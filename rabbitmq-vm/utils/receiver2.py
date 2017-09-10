#!/usr/bin/env python
import pika

#server = 'gysp-il2-dev-stub.itsshared.net'
server = 'gysp-il3-qa-stub.itsshared.net'
#server = 'myrabbitmq.myworld.net'

credentials = pika.PlainCredentials('admin', 'password123')
parameters = pika.ConnectionParameters(server,
                                       5672,
                                       '/',
                                       credentials)

connection = pika.BlockingConnection(parameters)
                                
channel = connection.channel()

channel.queue_declare(queue='hai')

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)

channel.basic_consume(callback,
                      queue='hai',
                      no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()

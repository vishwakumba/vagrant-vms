#!/usr/bin/env python
import pika

#connection = pika.BlockingConnection(pika.ConnectionParameters(host='myrabbitmq.myworld.net'))


#server = 'gysp-il2-dev-stub.itsshared.net'
server = 'gysp-il3-qa-stub.itsshared.net'
#server = 'myrabbitmq.myworld.net'

credentials = pika.PlainCredentials('gysp_user', 'password123')
parameters = pika.ConnectionParameters(server,
                                       5672,
                                       'gysp_vhost',
                                       credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='hello')

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)

channel.basic_consume(callback,
                      queue='hello',
                      no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()

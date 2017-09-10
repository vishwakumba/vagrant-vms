#!/usr/bin/env python
import pika

#connection = pika.BlockingConnection(pika.ConnectionParameters(
#        host='myrabbitmq.myworld.net'))

#credentials = pika.PlainCredentials('guest', 'guest')
#parameters = pika.ConnectionParameters('myrabbitmq.myworld.net',
#                                       5672,
#                                       '/',
#                                       credentials)

#server = 'myrabbitmq.myworld.net'
server = 'gysp-il2-dev-stub.itsshared.net'

credentials = pika.PlainCredentials('admin', 'password123')
parameters = pika.ConnectionParameters(server,
                                       5672,
                                       '/',
                                       credentials)

connection = pika.BlockingConnection(parameters)
                                
channel = connection.channel()

channel.queue_declare(queue='hai') 

#exchange name is empty, so message gets routed to the queue with the name == routing key
channel.basic_publish(exchange='',
                      routing_key='hai',
                      body='Hello World!')
print(" [x] Sent 'Hello World!'")
connection.close()

#!/usr/bin/env python
import pika

#server = 'myrabbitmq.myworld.net'
#server = 'gysp-il2-dev-stub.itsshared.net'
server = 'gysp-il3-qa-stub.itsshared.net'

credentials = pika.PlainCredentials('gysp_user', 'password123')
parameters = pika.ConnectionParameters(server,
                                       5672,
                                       'gysp_vhost',
                                       credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='hello') 

#exchange name is empty, so message gets routed to the queue with the name == routing key
channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print(" [x] Sent 'Hello World!'")
connection.close()

#!/usr/bin/env dotnet-script

#r "nuget: RabbitMQ.Client, 6.0.0"

using System;
using RabbitMQ.Client;
using System.Text;


var factory = new ConnectionFactory() { HostName = "localhost" };
using(var connection = factory.CreateConnection())
using(var channel = connection.CreateModel())
{
    channel.QueueDeclare(queue: "production",
                            durable: false,
                            exclusive: false,
                            autoDelete: false,
                            arguments: null);

    string message = "Hello World!";
    var body = Encoding.UTF8.GetBytes(message);

    channel.BasicPublish(exchange: "",
                            routingKey: "hello",
                            basicProperties: null,
                            body: body);
    Console.WriteLine(" [x] Sent {0}", message);


Console.WriteLine(" Press [enter] to exit.");
Console.ReadLine();
}


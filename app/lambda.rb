require "json"
require 'aws-sdk-dynamodb'

module LambdaFunction
  class Handler
    def self.process(event:, context:)
      puts event
      event["Records"].each do |record|
        sleep_sec = record["dynamodb"]["NewImage"]["sleep"]["N"]
        id = record["dynamodb"]["NewImage"]["id"]["N"].to_i
        content = record["dynamodb"]["NewImage"]["content"]["S"]

        sleep sleep_sec.to_i
        dynamodb_client = Aws::DynamoDB::Client.new(region: "ap-northeast-1")

        table_item = {
          table_name: "TestStreamDst",
          key: {
            id: id
          },
          update_expression: 'SET sleep = :s, content = :c',
          expression_attribute_values: { ':s': sleep_sec, ':c': content },
          return_values: "UPDATED_NEW"
        }

        puts dynamodb_client.update_item(table_item)
      end
    end
  end
end


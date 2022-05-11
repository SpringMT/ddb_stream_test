require 'aws-sdk-dynamodb'

dynamodb_client = Aws::DynamoDB::Client.new(region: "ap-northeast-1")

first_table_item = {
  table_name: "TestStreamSrc",
  key: {
    id: 1
  },
  update_expression: 'SET sleep = :s, content = :c',
  expression_attribute_values: { ':s': 60, ':c': "first_item long" },
  return_values: "UPDATED_NEW"
}


second_table_item = {
  table_name: "TestStreamSrc",
  key: {
    id: 1
  },
  update_expression: 'SET sleep = :s, content = :c',
  expression_attribute_values: { ':s': 5, ':c': "second_item short" },
  return_values: "UPDATED_NEW"
}

puts dynamodb_client.update_item(first_table_item)

sleep 5

puts dynamodb_client.update_item(second_table_item)

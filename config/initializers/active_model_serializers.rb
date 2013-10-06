ActiveSupport.on_load(:active_model_serializers) do
  #Disable for all serializers except for ArraySerializer
  ActiveModel::Serializer.root = false

  #Disable for ArraySerializer
  ActiveModel::ArraySerializer.root = false
end
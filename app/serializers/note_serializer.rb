class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_id, :company_id, :company_name
end

json.data do
    json.partial! 'project', collection: @projects, as: :project
end
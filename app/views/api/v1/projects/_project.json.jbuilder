json.(project,
    :id
)
json.type "project"
json.attributes do
    json.title project.title
    json.thumbnail request.base_url + url_for(project.thumbnail)
    json.description project.description
    json.location project.location
    json.type project.project_type
    json.ownerName project.user.name
    json.createdAt project.created_at
    json.updatedAt project.updated_at
end

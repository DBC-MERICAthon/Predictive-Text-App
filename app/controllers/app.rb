get '/docs/new' do
  current_user
  erb :"docs/new_doc"
end

post '/docs' do
  current_user
  create_doc
  redirect "/docs/#{@doc.id}"
end

get '/docs/:id' do
  @doc = Doc.where(id: params[:id]).first
  erb :"docs/show"
end

put '/docs/:id' do
  doc = Doc.where(id: params[:id]).first
  p params
  doc.title = params[:title]
  doc.content = params[:content]
  if doc.save
    content_type :json
    doc.user_id.to_json
  else
    status 500
    "Whoops! Something TERRIBLE happened... O_O"
    # error message
  end
end

put '/docs/:id/photo' do
  @doc = Doc.where(id: params[:id]).first
  @doc.photo = params[:photo_url]
  @doc.save
  erb :_photo, layout: false
end

delete 'docs/:id' do
  doc = Doc.where(id: params[:id]).first
  doc.destroy
end

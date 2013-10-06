class Rails::AngularTemplateGenerator < Rails::Generators::NamedBase



  #create template
  def create_template_files
    # routes file path
    routes_file = "app/assets/javascripts/app/config/routes.js.coffee.erb"
    #after creating the angular views, we need to empty the server side corresponding views and append a div with ng-view directive
    actions_controller =['index','new','show','edit'];
    actions_controller.each do |action|
      File.open("app/views/#{file_name.pluralize}/#{action}.html.erb",'r+') do |file|
        gsub_file(file,/.*/,"<div ng-view></div>")
      end
    end


    #create view templates
    create_file "app/assets/templates/#{file_name.pluralize}/index.html.erb", <<-FILE
      <h1>#{file_name.pluralize}/index template</h1>
      <p><h2>{{message}}</h2></p>
    FILE
    create_file "app/assets/templates/#{file_name.pluralize}/new.html.erb", <<-FILE
      <h1>#{file_name.pluralize}/new template</h1>
    FILE
    create_file "app/assets/templates/#{file_name.pluralize}/show.html.erb", <<-FILE
      <h1>#{file_name.pluralize}/show template</h1>
    FILE
    create_file "app/assets/templates/#{file_name.pluralize}/edit.html.erb", <<-FILE
      <h1>#{file_name.pluralize}/edit template</h1>

    FILE



    #create controller
    create_file "app/assets/javascripts/app/controllers/#{file_name.pluralize}/#{file_name.pluralize}_controller.js.coffee", <<-FILE
      @#{file_name.pluralize.capitalize}Controller = ($scope,$resource,#{file_name.pluralize.capitalize}Service,$http,$location) ->
          $scope.message = "Here is the #{file_name.pluralize.capitalize}Controller"
          $scope.#{file_name.pluralize} = {}
          $scope.#{file_name} = {}

          #===============================================================
          # GET /#{file_name.pluralize.capitalize}
          #===============================================================

          $http.get( '/#{file_name.pluralize}'

          ).then ((response) ->
             $scope.#{file_name.pluralize} = response.data
          ),(error) ->
             console.log(error)

          #===============================================================
          # GET /#{file_name.pluralize.capitalize}/new
          #===============================================================

          $http.get('/#{file_name.pluralize}/new'

          ).then ((response) ->
              $location.url('/#{file_name.pluralize}/new')
              console.log(response.data)
          ), (error) ->
              console.log(error)


          #===============================================================
          # GET /#{file_name.pluralize.capitalize}/show/:id
          #===============================================================

          $http.get('/#{file_name.pluralize}/:id',
            {id: id}

          ).then ((response) ->
             $scope.#{file_name} = response.data

          ), (error) ->
             console.log(error)

          $scope.show = (id) ->
            #{file_name.pluralize.capitalize}Service.get {id: id}, (resource) ->
               $scope.#{file_name} = resource
            , (response) ->
               console.log(response)


          #===============================================================
          # GET /#{file_name.pluralize.capitalize}/:id/edit
          #===============================================================
          $scope.edit = (id) ->
            #{file_name.pluralize.capitalize}Service.get {id: id, action:'edit'}, (resource) ->
              # typically, redirect to the edit form
              # $location.url('#{file_name.pluralize}/edit')
               $scope.#{file_name} = resource
            , (response) ->
               console.log(response)



          #===============================================================
          # PUT /#{file_name.pluralize.capitalize}/:id/update
          #===============================================================
          $scope.update = (id,data) ->
            #{file_name.pluralize.capitalize}Service.update {id: id },data, (resource) ->
               console.log(resource)
            , (response) ->
               console.log(response)




          #===============================================================
          # POST /#{file_name.pluralize.capitalize}
          #===============================================================
          $scope.create = (data) ->
              console.log("Create action")
              #{file_name.pluralize.capitalize}Service.save() {withCredentials: true, headers:{'Content-Type':undefined}, transformRequest: angular.identity },data, (resource) ->
                console.log(resource)
                $scope.#{file_name.pluralize}.push(resource)
              ,(response) ->
                console.log(response)



          #===============================================================
          # DELETE /#{file_name.pluralize.capitalize}/:id
          #===============================================================

          $scope.destroy = (id) ->
            #{file_name.pluralize.capitalize}Service.delete {id: id}, (resource) ->
                $scope.#{file_name.pluralize}.splice(resource.id,1)
            ,(response) ->
                console.log(response)

    FILE

    #create directives
    create_file "app/assets/javascripts/app/directives/#{file_name.pluralize}/#{file_name.pluralize}_directives.js.coffee", <<-FILE
      console.log("#{file_name.pluralize}Directive")
    FILE


    #create routes
    inject_into_file routes_file ,
                     after: "BookLety.config(['$routeProvider' ,($routeProvider) ->\n" do <<-FILE
        $routeProvider.when('/#{file_name.pluralize}',{templateUrl: '<%= asset_path('#{file_name.pluralize}/index.html')  %>',controller: '#{file_name.pluralize.capitalize}Controller'})
        $routeProvider.when('/#{file_name.pluralize}/new',{templateUrl: '<%= asset_path('#{file_name.pluralize}/new.html')  %>',controller: '#{file_name.pluralize.capitalize}Controller'})
        $routeProvider.when('/#{file_name.pluralize}/:id',{templateUrl: '<%= asset_path('#{file_name.pluralize}/show.html')  %>',controller: '#{file_name.pluralize.capitalize}Controller'})
        $routeProvider.when('/#{file_name.pluralize}/:id/edit',{templateUrl: '<%= asset_path('#{file_name.pluralize}/edit.html')  %>',controller: '#{file_name.pluralize.capitalize}Controller'})

      FILE

    end

    # create services
    create_file "app/assets/javascripts/app/services/#{file_name.pluralize}/#{file_name.pluralize}_services.js.coffee", <<-FILE
      BookLety.factory "#{file_name.pluralize}Service",['$resource',($resource) ->
        #{file_name.pluralize.capitalize}Service = $resource '/#{file_name.pluralize.capitalize}/:id',{id: '@id'},{update: {method: 'PUT'} }
        #{file_name.pluralize.capitalize}Service::save = ->
          if @id?
            @update()
          else
            @create()

        #{file_name.pluralize.capitalize}Service
      ]
    FILE

    #create filters
    create_file "app/assets/javascripts/app/filters/#{file_name.pluralize}/#{file_name.pluralize}_filters.js.coffee", <<-FILE
      console.log("#{file_name.pluralize}Controller")
    FILE

  end

end

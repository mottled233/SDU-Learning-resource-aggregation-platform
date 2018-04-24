require "knowledges_controller"

class ResourcesController < KnowledgesController
    def new
        super
        @resource = Resource.new
    end
end

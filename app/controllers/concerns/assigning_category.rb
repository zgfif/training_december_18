module AssigningCategory
  extend ActiveSupport::Concern

  included do
    before_action :find_resource, only: :update
  end

  private
  def find_resource
    @resource ||= Author.find params[:id]
  end

  def new_categories
    Category.where id: new_categories_ids
  end

  def new_categories_ids
    present_ids = resource.category_ids.map(&:to_s)

    resource_params[:category_ids].select { |id| present_ids.exclude? id }
  end
end

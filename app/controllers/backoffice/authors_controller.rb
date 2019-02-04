module Backoffice
  class AuthorsController < ApplicationController
    before_action :find_resource, only: :update

    def create
      render :errors, status: 422 unless resource.save
    end

    def update
      categories_array

      assign_categories
    end

    private
    attr_reader :resource

    def build_resource
      @resource = Author.new resource_params
    end

    def find_resource
      @resource ||= Author.find params[:id]
    end


    def resource_params
      params.require(:author).permit(:name, category_ids: []).merge(user: current_user)
    end

    def categories_array
      ids = resource_params[:category_ids]

      ids = ids[0].split(',')

      @category_ids = ids.map { |el| el.to_i }
    end

    def assign_categories
      @category_ids.to_a.each do |category_id|
        category = Category.find_by id: category_id

        if category
          unless resource.categories.exists?(category_id)
            resource.categories << category

            category.update_total_authors
          end
        end
      end
    end

    def collection
      @collection ||= Author.order :name
    end

    def authorize_collection
      authorize collection, policy_class: Backoffice::AuthorPolicy
    end

    def authorize_resource
      authorize resource, policy_class: Backoffice::AuthorPolicy
    end
  end
end

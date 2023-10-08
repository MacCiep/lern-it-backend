# frozen_string_literal: true

require 'pagy/extras/metadata'
require 'pagy/extras/items'
require 'pagy/extras/standalone'

Pagy::DEFAULT[:url] = '/'
Pagy::DEFAULT[:metadata] = [:pages, :page, :count, :items]

Pagy::DEFAULT[:metadata_key_overrides] = {
  items: :per_page,
  count: :total_count,
  pages: :total_pages,
  page: :current_page
}

Pagy::MetadataExtra.class_eval do
  private
  def normalized_pagy_metadata(pagy, absolute: nil)
    pagy_metadata(pagy, absolute:).transform_keys! { |key| Pagy::DEFAULT[:metadata_key_overrides][key] || key }
  end
end

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
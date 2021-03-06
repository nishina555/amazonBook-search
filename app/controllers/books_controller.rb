class BooksController < ApplicationController
  def search
    if params[:keyword].present?
      books = Amazon::Ecs.item_search(
                             params[:keyword],
                             search_index: 'Books',
                             dataType: 'script',
                             response_group: 'ItemAttributes, Images',
                             country: 'jp',
                             power: 'Not kindle'
      )

      @books = []
      books.items.each do |item|
        book = Book.new(
                       item.get('ItemAttributes/Title'),
                       item.get('LargeImage/URL'),
                       item.get('DetailPageURL')
        )
        @books << book

      end
    end

  end
end

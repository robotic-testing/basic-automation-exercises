# frozen_string_literal: true

class FilteringTableController < BaseController
  SORTABLE_KEYS = %i[first_name last_name birth_date].freeze
  DATA_ITEMS = [
    { is_active: true, birth_date: Date.iso8601('1981-01-01'), first_name: 'Dickerson', last_name: 'Macdonald' },
    { is_active: false, birth_date: Date.iso8601('2000-03-21'), first_name: 'Larsen', last_name: 'Shaw' },
    { is_active: false, birth_date: Date.iso8601('2012-11-13'), first_name: 'Mini', last_name: 'Navarro' },
    { is_active: false, birth_date: Date.iso8601('1932-08-10'), first_name: 'Geneva', last_name: 'Wilson' },
    { is_active: true, birth_date: Date.iso8601('1983-04-27'), first_name: 'Jami', last_name: 'Carney' },
    { is_active: false, birth_date: Date.iso8601('1994-12-21'), first_name: 'Essie', last_name: 'Dunlap' },
    { is_active: true, birth_date: Date.iso8601('1981-07-11'), first_name: 'Thor', last_name: 'Macdonald' },
    { is_active: true, birth_date: Date.iso8601('1934-07-21'), first_name: 'Larsen', last_name: 'Shaw' },
    { is_active: false, birth_date: Date.iso8601('1995-09-01'), first_name: 'Mitzi', last_name: 'Navarro' },
    { is_active: false, birth_date: Date.iso8601('1999-05-05'), first_name: 'Genevieve', last_name: 'Wilson' },
    { is_active: true, birth_date: Date.iso8601('1983-05-20'), first_name: 'John', last_name: 'Carney' },
    { is_active: false, birth_date: Date.iso8601('1992-11-29'), first_name: 'Dick', last_name: 'Dunlap' }
  ].freeze

  namespace '/filtering-table' do
    get { erb :filtering_table }

    get '/items' do
      items = DATA_ITEMS.dup

      query = params['query'].to_s.strip.downcase

      unless query.empty?
        filter_by_any_value = ->(item) { item.any? { |_, value| value.to_s.downcase.include? query } }
        filter_by_filter_on = ->(item) { filter_on.any? { |filter_key| item[filter_key.to_sym].downcase.include? query } }

        by_filter = filter_on.any? ? filter_by_filter_on : filter_by_any_value
        items = items.select(&by_filter)
      end

      items = items.select { |item| item[:is_active] } if only_active

      if birth_date_start && birth_date_end
        items = items.select { |item| item[:birth_date] >= birth_date_start && item[:birth_date] <= birth_date_end }
      elsif birth_date_start
        items = items.select { |item| item[:birth_date] == birth_date_start }
      end

      if !sort_by.empty? && SORTABLE_KEYS.include?(sort_by)
        items.sort_by! { |item| item[sort_by] }
        items.reverse! if sort_direction != 'asc'
      end

      ending_index = (page * page_size) - 1
      ending_index = items.length if ending_index > items.length

      json items: items[starting_index..ending_index], totalItems: items.length
    end

    def filter_on
      params['filter_on'] || []
    end

    def birth_date_start
      params['birth_date_start'] ? Date.iso8601(params['birth_date_start']) : nil
    end

    def birth_date_end
      params['birth_date_end'] ? Date.iso8601(params['birth_date_end']) : nil
    end

    def page
      params['page'].to_i
    end

    def page_size
      params['size'].to_i || 5
    end

    def starting_index
      (page * page_size) - page_size
    end

    def sort_direction
      params['sort_direction'] || 'asc'
    end

    def sort_by
      params['sort_by'].to_s.to_sym
    end

    def only_active
      params['only_active']
    end
  end
end

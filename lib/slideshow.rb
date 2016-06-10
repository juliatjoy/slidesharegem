require 'nokogiri'

module SlideShare
  class SlideShow
    attr_accessor :xml_response,
                    :id, :title, :description, :status,
                    :created_at, :updated_at,
                    :username,
                    :url,
                    :language, :format, :type,
                    :downloadable, :in_contest,
                    :tags,
                    :slide_count, :favorite_count,
                    :is_visible_by_contacts

    def initialize xml_response = nil
      @xml_response = xml_response
      parse_response if @xml_response
    end

    private

    def parse_response
      @id = xml_response_integer('ID')
      @title = xml_response_text('Title')
      @description = xml_response_text('Description')
      @status = xml_response_status
      @username = xml_response_text('Username')
      @url = xml_response_text('URL')
      @created_at = Time.parse xml_response_text('Created') rescue nil
      @updated_at = Time.parse xml_response_text('Updated') rescue nil
      @language = xml_response_text('Language')
      @format = xml_response_text('Format')
      @downloadable = xml_response_boolean('Download')
      @type = xml_response_type
      @in_contest = xml_response_boolean('InContest')
      @tags = xml_response_text_array('Tag')
      @slide_count = xml_response_integer('NumSlides')
      @favorite_count = xml_response_integer('NumFavorites')
      @is_visible_by_contacts = xml_response_boolean('ShareWithContacts')
    end

    def xml_response_text(attribute_name)
        node = @xml_response.search(attribute_name)
        node.text unless node.empty?
      end

      def xml_response_text_array(attribute_name)
        node = @xml_response.search(attribute_name)
        node.map(&:text) unless node.empty?
      end

      def xml_response_boolean(attribute_name)
        node = @xml_response.search(attribute_name)
        node.first.content == '1' unless node.empty?
      end

      def xml_response_integer(attribute_name)
        text = xml_response_text(attribute_name)
        text.to_i if text
      end

      def xml_response_integer_array(attribute_name)
        text_list = xml_response_text_array(attribute_name)
        text_list.map(&:to_i) if text_list
      end

      def xml_response_status
        case xml_response_integer('Status')
          when 0 then
            :queued_for_conversion
          when 1 then
            :converting
          when 2 then
            :converted
          else
            :conversion_failed
        end
      end

      def xml_response_type
        case xml_response_integer('SlideshowType')
          when 0 then
            :presentation
          when 1 then
            :document
          when 2 then
            :portfolio
          else
            :video
        end
      end
  end
end

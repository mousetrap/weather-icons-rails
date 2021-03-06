module WeatherIcons
  module Rails
    class << self
      def load!
        if rails?
          register_rails_engine
        end

        if compass?
          register_compass_extension
        end
      end

      def gem_path
        @gem_path ||= File.expand_path('..', File.dirname(__FILE__))
      end

      def stylesheets_path
        File.join(assets_path, 'stylesheets')
      end

      def fonts_path
        File.join(assets_path, 'fonts')
      end

      def assets_path
        @assets_path ||= File.join(gem_path, 'vendor', 'assets')
      end

      def compass?
        defined?(::Compass)
      end

      def rails?
        defined?(::Rails)
      end

      private

      def register_compass_extension
        ::Compass::Frameworks.register(
          'weather-icons',
          path: gem_path,
          stylesheets_directory: stylesheets_path,
          templates_directory: File.join(gem_path, 'templates')
        )
      end

      def register_rails_engine
        require 'sass'
        require 'weather-icons/rails/engine'
        require 'weather-icons/rails/railtie'
      end
    end
  end
end

WeatherIcons::Rails.load!

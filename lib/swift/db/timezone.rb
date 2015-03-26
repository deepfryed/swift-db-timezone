require 'tzinfo'

module Swift
  module DB
    module Timezone
      class Convert
        SECONDS_IN_DAY = 86400

        attr_reader :from, :to

        def initialize from, to
          @from = TZInfo::Timezone.get(from)
          @to   = TZInfo::Timezone.get(to)
        end

        def convert time
          utc     = from.local_to_utc(time)
          offset  = Rational(to.period_for_utc(utc).utc_total_offset, SECONDS_IN_DAY)
          local   = to.utc_to_local(utc)
          seconds = local.second + local.second_fraction
          Swift::DateTime.civil(local.year, local.month, local.day, local.hour, local.minute, seconds, offset)
        end
      end # Convert

      class Result
        include Enumerable

        attr_reader :result, :converter

        def initialize result, converter
          @result    = result
          @converter = converter
        end

        def each
          result.each do |tuple|
            tuple.keys.each do |k|
              case tuple[k]
                when DateTime, Swift::DateTime
                  tuple[k] = converter.convert(tuple[k])
              end
            end
            yield tuple
          end
        end

        def self.wrap result, options = {}
          options  = options.dup
          db_tz    = options.fetch(:database_timezone, 'UTC')
          local_tz = options.fetch(:local_timezone,    'UTC')

          options.delete(:database_timezone)
          options.delete(:local_timezone)

          Swift::DB::Timezone::Result.new result, Swift::DB::Timezone::Convert.new(db_tz, local_tz)
        end
      end # Result

      def initialize options = {}
        options  = options.dup
        db_tz    = options.fetch(:database_timezone, 'UTC')
        local_tz = options.fetch(:local_timezone,    'UTC')

        options.delete(:database_timezone)
        options.delete(:local_timezone)
        @converter = Convert.new(db_tz, local_tz)

        super options
      end

      def execute *args
        Swift::DB::Timezone::Result.new super, @converter
      end
    end # Timezone
  end # DB
end # Swift

module BeechServer
  module Models
    module BadgesChecker

      attr_accessor :badge

      def unearned_badges
        Badge.all - awards.includes(:badge).map(&:badge)
      end

      def deserves_badge?(badge)
        RegularBadgeChecker.create_badge(badge, self).check
      end

      class RegularBadgeChecker

        attr_reader :badge, :user

        class << self
          def create_badge(badge, user)
            cst_prefix = "BeechServer::Models::BadgesChecker::"
            cst_name = "#{badge.badge_type}_badge_checker".camelize
            "#{cst_prefix}#{cst_name}".constantize.new badge, user
          end
        end

        def initialize(badge, user)
          @badge = badge
          @user = user
        end

        def badge_condition_params
          badge.condition.split(':')
        end
      end

      class QuantityBadgeChecker < RegularBadgeChecker
        def check
          type, target = badge_condition_params
          case type
          when 'any'
            user.beers.size >= badge.quantity
          when 'country'
            user.beers_for_country(target).size >= badge.quantity
          when 'color'
            user.beers_for_color(target).size >= badge.quantity
          when 'beer'
            user.beers_for_name(target).size >= badge.quantity
          end
        end
      end

      class OneOfEachBadgeChecker < RegularBadgeChecker
        def check
          type, target = badge_condition_params
          targets = target.split(',')

          targets.all? do |target|
            association_mapping(type, target).any?
          end
        end

        def association_mapping(type, target)
          mapping = {
            color: :beers_for_color,
            beers: :beers_for_name,
            countries: :beers_for_country
          }
          user.send mapping[type.intern], target
        end

      end

      class DifferentBadgeChecker < RegularBadgeChecker
        def check
          type, target = badge_condition_params
          association_mapping(type).size >= badge.quantity
        end

        def association_mapping(type)
          mapping = {beer: :beers, country: :beer_countries}
          user.send mapping[type.intern]
        end
      end

    end
  end
end

